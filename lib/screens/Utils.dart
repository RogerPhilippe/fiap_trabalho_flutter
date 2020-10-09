import 'package:fiap_trabalho_flutter/data/controllers/Controller.dart';
import 'package:fiap_trabalho_flutter/data/utils/UserSession.dart';
import 'package:fiap_trabalho_flutter/helpers/Constants.dart';
import 'package:fiap_trabalho_flutter/screens/CEP.dart';
import 'package:fiap_trabalho_flutter/screens/Exchange.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class Utils extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _Utils();
  }

}

class _Utils extends State<Utils> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  final userSession = GetIt.instance.get<UserSession>();
  Controller mController;

  @override
  Widget build(BuildContext context) {

    mController = Provider.of<Controller>(context);
    return Scaffold(
      backgroundColor: appDarkGreyColor,
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        children: [
          _bodyBuilder()
        ],
      ),
    );
  }

  Widget _bodyBuilder() {
    return SafeArea(
        child: Column(
          children: [
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
                          child: _buildDefaultText("Utils", 24)
                      )
                    ]
                )
            ),
            Flexible(child:
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 48),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 16, 40, 16),
                    height: 90.0,
                    width: double.infinity,
                    child: _buildDefaultBtn("Câmbio", () =>
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Exchange())
                        )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 16, 40, 16),
                    height: 90.0,
                    width: double.infinity,
                    child: _buildDefaultBtn("Busca CEP", () =>
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CEP())
                        )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 16, 40, 16),
                    height: 90.0,
                    width: double.infinity,
                    child: _buildDefaultBtn("Calculadora", () {

                    }),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 16, 40, 16),
                    height: 90.0,
                    width: double.infinity,
                    child: _buildDefaultBtn("Google Map", () {

                    }),
                  ),
                ],
              ),
            ))
          ],
        )
    );
  }

  Widget _buildDefaultText(String text, double size) {
    return Text(
        text,
        style: TextStyle(color: mainColor, fontSize: size)
    );
  }

  Widget _buildDefaultBtn(String text, Function func) {
    return RaisedButton(
        onPressed: func,
        child: Text(
            text,
            style: TextStyle(color: mainAccentColor, fontSize: 18.0)
        ),
        color: mainColor
    );
  }

}