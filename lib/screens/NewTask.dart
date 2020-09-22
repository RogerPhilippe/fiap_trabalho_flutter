import 'package:fiap_trabalho_flutter/data/DatabaseHandler.dart';
import 'package:fiap_trabalho_flutter/data/model/Task.dart';
import 'package:fiap_trabalho_flutter/data/repository/TaskRepository.dart';
import 'package:fiap_trabalho_flutter/data/service/LogUtils.dart';
import 'package:fiap_trabalho_flutter/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NewTask extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController taskTodoDateController = TextEditingController();
  bool _loading = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      backgroundColor: appDarkGreyColor,
      body: _buildBody(),
    );
  }

  // Body
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _buildContent(),
      ],
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Column(
        children: [
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
                        child: _buildDefaultText("Criar Tarefas", 24)
                    )
                  ]
              )
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: _formContent(),
          )
        ],
      ),
    );
  }

  Widget _formContent() {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: _buildTextFormField(
                  "Tarefa",
                  taskTitleController, false, true, "Digite o título da tarefa",
                  TextInputType.text)
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: _buildTextFormField(
                  "Detalhes",
                  taskDescriptionController, false, false, "Digite a descrição da tarefa",
                  TextInputType.text)
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: _buildTextFormField(
                  "Data",
                  taskTodoDateController, false, false, "Digite a data da tarefa",
                  TextInputType.text)
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
              height: 90.0,
              width: double.infinity,
              child: _buildSaveBtn()
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultText(String text, double size) {
    return Container(
      child: Text(text,
          style: TextStyle(color: Colors.orange, fontSize: size)),
    );
  }

  Widget _buildTextFormField(
      String hint,
      TextEditingController controller,
      bool obscureText,
      bool mandatory,
      String errorMsg,
      TextInputType textInputType
      ) {
    return TextFormField(
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.orange),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orange)
          )
      ),
      controller: controller,
      // ignore: missing_return
      validator: (value) {
        if (mandatory && value.isEmpty) {
          return errorMsg;
        }
      },
    );
  }

  Widget _buildSaveBtn() {
    return RaisedButton(
        onPressed: () {
          if(_formKey.currentState.validate()) {
            var id = DateTime.now().millisecondsSinceEpoch.toString();
            var title = taskTitleController.text;
            var description = taskDescriptionController.text;
            var todoDate = taskTodoDateController.text;
            var dateCreated = DateTime.now().millisecondsSinceEpoch;
            var dateLastUpdate = DateTime.now().millisecondsSinceEpoch;
            final task = new Task(id, title, description, dateCreated, 0, dateLastUpdate, 0);
            setState(() {
              _loading = true;
            });
            saveTask(task);
          }
        },
        child: Text(
            "SALVAR",
            style: TextStyle(color: Colors.white, fontSize: 18.0)
        ),
        color: Colors.orange
    );
  }

  void saveTask(Task task) {

    DatabaseHandler.getDatabase().then((db) {
      TaskRepository.insert(task, db).then((value) {
        LogUtils.info("Task salva!");
        Navigator.of(context).pop(true);
      }).catchError((onError) {
        LogUtils.error('Erro ao tentar salvar');
        LogUtils.error(onError);
        setState(() {
          _loading = false;
        });
      });
    }).catchError((onError) => LogUtils.error('Erro ao abrir banco de dados!'));

  }

}