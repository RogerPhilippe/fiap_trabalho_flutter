import 'package:fiap_trabalho_flutter/data/controllers/Controller.dart';
import 'package:fiap_trabalho_flutter/data/utils/UserSession.dart';
import 'package:fiap_trabalho_flutter/helpers/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class Exchange extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _Exchange();
  }

}

class _Exchange extends State<Exchange> with WidgetsBindingObserver {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  final userSession = GetIt.instance.get<UserSession>();
  Controller mController;

  TextEditingController realToDollarController = TextEditingController();
  TextEditingController dollarToRealController = TextEditingController();

  TextEditingController realToEuroController = TextEditingController();
  TextEditingController euroToRealController = TextEditingController();

  TextEditingController realToBcController = TextEditingController();
  TextEditingController bcToRealController = TextEditingController();

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
                          child: _buildDefaultText("Câmbio", 24)
                      )
                    ]
                )
            ),
            Flexible(child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 48),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Container(
                                padding: EdgeInsets.fromLTRB(24, 16, 8, 16),
                                child:  Observer(builder: (_){
                                  realToDollarController.text = mController.dollarToReal;
                                  return _buildDefaultTextField("Real", realToDollarController, (value) => mController.setDollarToReal(value));
                                })
                            )
                        ),
                        Flexible(
                            child: Container(
                                padding: EdgeInsets.fromLTRB(8, 16, 16, 16),
                                child: Observer(builder: (_) {
                                  dollarToRealController.text = mController.dollar;
                                  return _buildDefaultTextField("Dolar", dollarToRealController, (value) => mController.setDollar(value));
                                })
                            )
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 16, 24, 16),
                          child: _buildDefaultBtn("Calc.", () => {
                            mController.exchangeService("dollar")
                          }),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Container(
                                padding: EdgeInsets.fromLTRB(24, 16, 8, 16),
                                child:  Observer(builder: (_){
                                  realToEuroController.text = mController.euroToReal;
                                  return _buildDefaultTextField("Real", realToEuroController, (value) => mController.setEuroToReal(value));
                                })
                            )
                        ),
                        Flexible(
                            child: Container(
                                padding: EdgeInsets.fromLTRB(8, 16, 16, 16),
                                child: Observer(builder: (_) {
                                  euroToRealController.text = mController.euro;
                                  return _buildDefaultTextField("Euro", euroToRealController, (value) => mController.setEuro(value));
                                })
                            )
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 16, 24, 16),
                          child: _buildDefaultBtn("Calc.", () => {
                            mController.exchangeService("euro")
                          }),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Container(
                                padding: EdgeInsets.fromLTRB(24, 16, 8, 16),
                                child:  Observer(builder: (_){
                                  realToBcController.text = mController.btcToReal;
                                  return _buildDefaultTextField("Real", realToBcController, (value) => mController.setBtcToReal(value));
                                })
                            )
                        ),
                        Flexible(
                            child: Container(
                                padding: EdgeInsets.fromLTRB(8, 16, 16, 16),
                                child: Observer(builder: (_) {
                                  bcToRealController.text = mController.bitCoin;
                                  return _buildDefaultTextField("BitCoin", bcToRealController, (value) => mController.setBitCoin(value));
                                })
                            )
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 16, 24, 16),
                          child: _buildDefaultBtn("Calc.", () => {
                            mController.exchangeService("btc")
                          }),
                        )
                      ],
                    )
                  ],
                )
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

  Widget _buildDefaultTextField(String hint, TextEditingController controller, Function func) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: mainColor),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: mainColor)
          )
      ),
      controller: controller,
      onChanged: func,
    );
  }

}