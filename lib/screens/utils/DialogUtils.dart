import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils {

  static void makeYesNoDialog(BuildContext context, String msg, Function func) {

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
                Text(msg)
              ],
            ),
            actions: [
              FlatButton(onPressed: () {
                Navigator.of(context).pop();
                }, child: Text("Não")),
              FlatButton(onPressed: () {
                Navigator.of(context).pop();
                func();
                }, child: Text("Sim"))
            ],
          );
        });
  }

  static void makeOkDialog(BuildContext context, String msg) {

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(msg)
              ],
            ),
            actions: [
              FlatButton(onPressed: () {
                Navigator.of(context).pop();
                }, child: Text("OK"))
            ],
          );
        }
    );
  }

}