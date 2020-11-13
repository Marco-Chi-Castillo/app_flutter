import 'package:flutter/material.dart';
import 'package:reservaciones_app/src/components/menu_drawer.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('En desarollo'),
      ),
      drawer: Drawer(
        child: menuDrawer.menuDrawer(),
      ),
      body: Center(
        child: Text('En Desarollo'),
      ),
    ));
  }
}
