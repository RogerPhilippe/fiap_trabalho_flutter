import 'package:flutter/services.dart';

class MethodChannelService {

  static const platform = const MethodChannel('app/logs');

  static logInfo(String infoMsg) async {

    await platform.invokeMethod("info", {"infoMsg": infoMsg});
  }

  static logError(String errorMsg) async {

    await platform.invokeMethod("error", {"errorMsg": errorMsg});
  }

}