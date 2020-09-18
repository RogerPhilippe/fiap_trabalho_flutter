import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'helpers/Constants.dart';
import 'screens/Home.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(_Main());
}

class _Main extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData.dark(),
      home: Home(),
    );
  }

}
