import 'package:fiap_trabalho_flutter/data/service/MethodChannelService.dart';

class LogUtils {

  static info(String infoMsg) async {

    await MethodChannelService.logInfo(infoMsg);
  }

  static error(String errorMsg) async {

    await MethodChannelService.logError(errorMsg);
  }

}