import 'package:fiap_trabalho_flutter/data/DatabaseHandler.dart';
import 'package:fiap_trabalho_flutter/data/controllers/Controller.dart';
import 'package:fiap_trabalho_flutter/data/controllers/ItemModel.dart';
import 'package:fiap_trabalho_flutter/data/model/Task.dart';
import 'package:fiap_trabalho_flutter/data/repository/TaskRepository.dart';
import 'package:fiap_trabalho_flutter/data/service/LogUtils.dart';
import 'package:fiap_trabalho_flutter/helpers/Constants.dart';
import 'package:fiap_trabalho_flutter/screens/NewTask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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

  bool _loading = false;

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
    controller.loadTaskList();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appDarkGreyColor,
      body: _buildBody(controller),
      floatingActionButton: _buildFloatingButton(context)
    );
  }

  // Body
  Widget _buildBody(Controller controller) {
    if (_loading) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }
    else {
      return Stack(
        children: <Widget>[
          _buildContent(controller),
        ],
      );
    }
  }

  Widget _buildContent(Controller controller) {
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
            ),
            Expanded(
              child: _buildList(controller.items)
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

  Widget _buildList(List<Task> list) {
    return Observer(builder: (_) {
      return ListView.builder(
          padding: EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
          itemCount: list.length,
          itemBuilder: (context, index) =>
              _buildDismissibleTaskList(context, index, list)
      );
    });
  }

  // Dismissible Task list
  Widget _buildDismissibleTaskList(BuildContext context, int index, List<Task> list) {
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
      child: _buildTaskList(context, index, list),
      onDismissed: (direction) => _removeTask(direction, index, list),
    );
  }

  // Task List
  Widget _buildTaskList(BuildContext context, int index, List<Task> list) {
    return CheckboxListTile(
        title: Text(list[index].title),
        subtitle: Text(list[index].description),
        value: list[index].status == 1,
        onChanged: (checked) {
          setState(() {
            if (checked)
              list[index].status = 1;
            else
              list[index].status = 0;
          });
        }
    );
  }

  void _removeTask(DismissDirection direction, int index, List<Task> list) {
    setState(() {
      _lastItemRemoved.add(list[index]);
      _lastItemListRemoved = index;
      list.removeAt(index);
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