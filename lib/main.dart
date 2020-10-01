import 'package:fiap_trabalho_flutter/data/controllers/Controller.dart';
import 'package:fiap_trabalho_flutter/data/utils/UserSession.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'helpers/Constants.dart';
import 'screens/Home.dart';

void main() {

  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<UserSession>(UserSession());

  debugPaintSizeEnabled = false;
  runApp(
      MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [const Locale('pt', 'BR')],
        home: _Main(),
      ),
  );
}

class _Main extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Controller>(create: (_) => Controller())
      ],
      child: MaterialApp(
        title: appTitle,
        theme: ThemeData.dark(),
        home: Home(),
      )
    );
  }

}
