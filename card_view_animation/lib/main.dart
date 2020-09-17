import 'package:card_view_animation/test.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String texttest = '123';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (_) {
          return HomePage();
        },
      },
      initialRoute: '/home',
    );
  }
}
