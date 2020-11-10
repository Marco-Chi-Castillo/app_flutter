import 'package:flutter/material.dart';
import 'package:reservaciones_app/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservaciones_app',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
