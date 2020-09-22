import 'package:flutter/services.dart';

class LogUtils {

  static const platform = const MethodChannel('app/logs');

  static info(String infoMsg) async {

    await platform.invokeMethod("info", {"infoMsg": infoMsg});
  }

  static error(String infoMsg) async {

    await platform.invokeMethod("error", {"errorMsg": infoMsg});
  }

}