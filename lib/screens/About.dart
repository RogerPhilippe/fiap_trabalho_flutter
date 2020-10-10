import 'package:fiap_trabalho_flutter/data/controllers/Controller.dart';
import 'package:fiap_trabalho_flutter/helpers/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _AboutState();
  }

}

class _AboutState extends State<About> with WidgetsBindingObserver {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var controller = Controller();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: appDarkGreyColor,
        body: _buildBody()
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
            children: <Widget> [
              Container(
                  padding: EdgeInsets.fromLTRB(16, 28, 16, 28),
                  child: Row(
                      children: [
                        GestureDetector(
                          child: Icon(Icons.arrow_back, size: 28, color:  mainColor),
                          onTap: () => { Navigator.of(context).pop() },
                        ),
                        SizedBox(width: 24),
                        Center(
                            child: _buildDefaultText("Sobre", 24)
                        )
                      ]
                  )
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: _buildDefaultText("Desenvolvido para o curso MBA Mobile FIAP", 16),
              ),
              Container(
                child: _buildDefaultText("Trabalho final matéria de Flutter 19Mob", 14),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: _buildDefaultText("Integrantes:", 15),
              ),
              Container(
                child: _buildDefaultText("Felipe Cesar Morato - RM: 335676", 13),
              ),
              Container(
                child: _buildDefaultText("Rafael Caldas Teixeria - RM: 336323", 13),
              ),
              Container(
                child: _buildDefaultText("Roger Philippe Pereira - RM: 335720", 13),
              ),
              Container(
                child: _buildDefaultText("Valmir Alves Candido - RM: 335940", 13),
              ),
            ]
        )
    );
  }

  Widget _buildDefaultText(String text, double size) {
    return Text(
        text,
        style: TextStyle(color: mainColor, fontSize: size)
    );
  }

}