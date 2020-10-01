import 'package:fiap_trabalho_flutter/data/controllers/Controller.dart';
import 'package:fiap_trabalho_flutter/data/model/Task.dart';
import 'package:fiap_trabalho_flutter/data/service/LogUtils.dart';
import 'package:fiap_trabalho_flutter/helpers/Constants.dart';
import 'package:fiap_trabalho_flutter/screens/NewTask.dart';
import 'package:fiap_trabalho_flutter/screens/utils/DateUtils.dart';
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _lastItemRemovedIndex = -1;

  Controller mController;

  @override void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    LogUtils.info('state = $state');
    if (state == AppLifecycleState.paused)
      mController.dispose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    mController = Provider.of<Controller>(context);
    mController.loadTaskList();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appDarkGreyColor,
      body: Observer(builder: (_) {
        if (mController.tasksLoaded) {
          return _buildContent();
        } else {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }
      }),
      floatingActionButton: Observer(builder: (_) {
        if (mController.tasksLoaded)
          return _buildFloatingButton(context);
        else
          return SizedBox(height: 20);

      })
    );
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
            ),
            Expanded(
              child: _buildList()
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

  Widget _buildList() {
    return Observer(builder: (_) {
      return ListView.builder(
          padding: EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
          itemCount: mController.items.length,
          itemBuilder: (context, index) =>
              _buildDismissibleTaskList(context, index)
      );
    });
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
      onDismissed: (direction) => _removeTask(direction, index),
    );
  }

  // Task List
  Widget _buildTaskList(BuildContext context, int index) {
    return Observer(builder: (_) {
      Task task = mController.items[index];
      return CheckboxListTile(
          title: Text(mController.items[index].title),
          subtitle: Text("${DateUtils().getFormattedDate(task.todoDate)} ${mController.items[index].description}"),
          value: mController.items[index].status == 1,
          onChanged: (checked) => mController.setItemCheckStatus(checked, index)
      );
    });
  }

  void _removeTask(DismissDirection direction, int index) {
    mController.removeList(index);
    _lastItemRemovedIndex = index;
    final snack = _snackBar(mController.removedTaskList.last.title);
    _scaffoldKey.currentState.showSnackBar(snack);
  }

  Widget _snackBar(String title) {
    return SnackBar(
      content: Text("Tarefa $title removido da lista!"),
      action: SnackBarAction(
        label: "Desfazer", onPressed: () =>
          mController.cancelLastItemRemoved(_lastItemRemovedIndex),
      ),
      duration: Duration(seconds: 3),
    );
  }

  // Floating ADD Task button
  Widget _buildFloatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        mController.dispose();
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => NewTask()));
      },
      tooltip: 'Criar Tarefa',
      child: Icon(Icons.add),
    );
  }

}