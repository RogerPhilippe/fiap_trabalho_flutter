import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:fiap_trabalho_flutter/data/controllers/Controller.dart';
import 'package:fiap_trabalho_flutter/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateUtils {

  final format = DateFormat("dd/MM/yyyy");

  Widget dateField(Controller controller) {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        onChanged: (value) {
          if (value != null && value.toString().isNotEmpty)
            controller.setDateTodo(value.millisecondsSinceEpoch);
        },
        decoration: InputDecoration(
            hintText: "Data",
            hintStyle: TextStyle(color: mainColor),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: mainColor)
            )
        ),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1950),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }

  String getFormattedDate(int value) {
    if (value != null && value > 0) {
      var date = DateTime.fromMillisecondsSinceEpoch(value);
      return "${format.format(date)} - ";
    } else
      return "";
  }

}