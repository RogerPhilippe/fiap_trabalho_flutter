import 'package:fiap_trabalho_flutter/data/DatabaseHandler.dart';
import 'package:fiap_trabalho_flutter/data/controllers/Controller.dart';
import 'package:fiap_trabalho_flutter/data/model/Task.dart';
import 'package:fiap_trabalho_flutter/data/repository/TaskRepository.dart';
import 'package:fiap_trabalho_flutter/data/service/LogUtils.dart';
import 'package:fiap_trabalho_flutter/helpers/Constants.dart';
import 'package:fiap_trabalho_flutter/screens/NewTask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListTasks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListTasksState();
  }
}

class _ListTasksState extends State<ListTasks> with WidgetsBindingObserver {

  List<Task> _tasks = [];
  List<Task>  _lastItemRemoved = [];
  int _lastItemListRemoved = -1;
  bool _mustUpdateTasks = false;

  bool _loading = true;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    LogUtils.info('state = $state');
    if (state == AppLifecycleState.paused) {
      if (_lastItemRemoved.length > 0) {
        _deleteTask(_lastItemRemoved);
        _lastItemRemoved.clear();
        _lastItemListRemoved = -1;
      }
      if (_mustUpdateTasks && _tasks.length > 0) {
        _updateTask(_tasks);
        _mustUpdateTasks = false;
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_lastItemRemoved.length > 0)
      _deleteTask(_lastItemRemoved);
    if (_mustUpdateTasks && _tasks.length > 0)
      _updateTask(_tasks);
  }

  @override
  Widget build(BuildContext context) {

    var controller = Provider.of<Controller>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appDarkGreyColor,
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(context)
    );
  }

  // Body
  Widget _buildBody() {
    if (_loading) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }
    else {
      return Stack(
        children: <Widget>[
          _buildContent(),
        ],
      );
    }
  }

  Widget _buildContent() {
    return SafeArea(
        child: Column(
          children: <Widget> [
            Container(
              padding: EdgeInsets.fromLTRB(16, 28, 16, 28),
              child: Row(
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back, size: 28, color:  Colors.orange),
                    onTap: () => { Navigator.of(context).pop() },
                  ),
                  SizedBox(width: 24),
                  Center(
                      child: _buildDefaultText("Lista de Tarefas", 24)
                  )
                ]
              )
            )
          ]
      )
    );
  }

  Widget _buildDefaultText(String text, double size) {
    return Text(
        text,
        style: TextStyle(color: Colors.orange, fontSize: size)
    );
  }

  Widget _buildList(List<Task> _tasks) {
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
        itemCount: _tasks.length,
        itemBuilder: (context, index) =>
            _buildDismissibleTaskList(context, index)
    );
  }

  // Dismissible Task list
  Widget _buildDismissibleTaskList(BuildContext context, int index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment(-0.9, 0.0),
            child: Icon(Icons.delete, color: Colors.white),
          )
      ),
      direction: DismissDirection.startToEnd,
      child: _buildTaskList(context, index),
      onDismissed: (direction) => _removeTask(direction, index) ,
    );
  }

  // Task List
  Widget _buildTaskList(BuildContext context, int index) {
    return CheckboxListTile(
      title: Text(_tasks[index].title),
      subtitle: Text(_tasks[index].description),
      value: _tasks[index].status == 1,
      onChanged: (checked) {
        _mustUpdateTasks = true;
        setState(() {
          if (checked)
            _tasks[index].status = 1;
          else
            _tasks[index].status = 0;
        });
      },
    );
  }

  void _removeTask(DismissDirection direction, int index) {
    setState(() {
      _lastItemRemoved.add(_tasks[index]);
      _lastItemListRemoved = index;
      _tasks.removeAt(index);
      final snack = _snackBar();
      _scaffoldKey.currentState.showSnackBar(snack);
    });
  }

  Widget _snackBar() {
    return SnackBar(
      content: Text("Tarefa ${_lastItemRemoved[0].title} removido da lista!"),
      action: SnackBarAction(
        label: "Desfazer", onPressed: _restoreList,
      ),
      duration: Duration(seconds: 3),
    );
  }

  void _restoreList() {
    setState(() {
      _tasks.insert(_lastItemListRemoved, _lastItemRemoved[0]);
      _lastItemRemoved.removeLast();
    });
  }

  // Floating ADD Task button
  Widget _buildFloatingButton(BuildContext context) {
    if (!_loading) {
      return FloatingActionButton(
        onPressed: () async {
          bool mustUpdateTasks = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NewTask())
          );
          if (mustUpdateTasks != null && mustUpdateTasks) {
            _loading = true;
            //_loadTaskList();
          }
        },
        tooltip: 'Criar Tarefa',
        child: Icon(Icons.add),
      );
    } else return SizedBox(height: 20);
  }

  // void _loadTaskList() {
  //
  //   DatabaseHandler.getDatabase().then((db) {
  //     TaskRepository.tasks(db).then((taskList) {
  //       if (taskList != null)
  //         setState(() => _tasks = taskList);
  //       _loading = false;
  //     }).catchError((onError) => LogUtils.error('Erro ao buscar tarefas!'));
  //   }).catchError((onError) => LogUtils.error('Erro ao abrir banco de dados!'));
  // }

  void _deleteTask(List<Task> tasks) {

    DatabaseHandler.getDatabase().then((db) {
      tasks.forEach((task) {
        TaskRepository.delete(task, db).then((value) => LogUtils.info("Task Removed!"));
      });
    });
  }

  void _updateTask(List<Task> tasks) {
    DatabaseHandler.getDatabase().then((db) {
      tasks.forEach((task) {
        TaskRepository.update(task, db).then((value) => LogUtils.info("Task Updated!"));
      });
    });
  }

}