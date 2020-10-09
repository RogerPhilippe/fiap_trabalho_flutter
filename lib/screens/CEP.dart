import 'package:fiap_trabalho_flutter/data/controllers/Controller.dart';
import 'package:fiap_trabalho_flutter/data/utils/UserSession.dart';
import 'package:fiap_trabalho_flutter/helpers/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CEP extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _CEP();
  }
}

class _CEP extends State<CEP> with WidgetsBindingObserver {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  final userSession = GetIt.instance.get<UserSession>();
  Controller mController;

  TextEditingController cepController = TextEditingController();
  TextEditingController streetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mController = Provider.of<Controller>(context);

    mController.getUFs();

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
                          child: _buildDefaultText("Busca CEP", 24)
                      )
                    ]
                )
            ),
            Flexible(child:
                SingleChildScrollView(
                  padding: EdgeInsets.only(top: 48),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(24, 16, 8, 16),
                                child: _buildDefaultTextField("CEP", cepController, TextInputType.number, mController.setCep),
                              )
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(8, 16, 24, 16),
                            child: _buildDefaultBtn("Buscar", () => mController.searchAddressByCep()),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                        child: Observer(builder: (_) {
                          return Text("${mController.address}");
                        }),
                      ),
                      SizedBox(width: 24),
                      Container(
                        padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                        child: _buildDefaultText("Busca por endereço", 18),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(24, 16, 24, 8),
                        alignment: Alignment(-1, 0),
                        child: _buildDefaultText("Selecione o estado", 12),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                          alignment: Alignment(-1, 0),
                          child: _buildDropDownButtonStates()
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(24, 16, 24, 8),
                        alignment: Alignment(-1, 0),
                        child: _buildDefaultText("Selecione a cidade", 12),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                          alignment: Alignment(-1, 0),
                          child: _buildDropDownButtonCities()
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                        child: _buildDefaultTextField("Rua", streetController, TextInputType.text, (value) => mController.setStreet(value)),
                      ),
                      Container(
                        child: _buildDefaultBtn("Buscar", () => mController.searchCepByAddress()),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                        child: Observer(builder: (_) {
                          return _buildDefaultText("${mController.cepBySearch}", 16);
                        }),
                      ),
                    ],
                  )
                )
            )
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

  Widget _buildDefaultTextField(String hint, TextEditingController controller, TextInputType textInputType, Function func) {
    return TextField(
      keyboardType: textInputType,
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

  Widget _buildDropDownButtonStates() {

    return Observer(builder: (_){
      return DropdownButton<String>(
          items : mController.mUFList.map((String uf) {
            return DropdownMenuItem<String>(
              value : uf,
              child : Text(uf),
            );
          }).toList(), onChanged: (selected) => mController.setUF(selected),
        value: mController.mUF
      );
    });
  }

  Widget _buildDropDownButtonCities() {

    return Observer(builder: (_){
      return DropdownButton<String>(
          items : mController.mCities.map((String city) {
            return DropdownMenuItem<String>(
              value : city,
              child : Text(city),
            );
          }).toList(), onChanged: (selected) => mController.setCity(selected),
          value: mController.mCity
      );
    });
  }

}
