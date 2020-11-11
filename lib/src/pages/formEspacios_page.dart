import 'package:flutter/material.dart';
import 'package:reservaciones_app/src/components/menu_drawer.dart';

class FormEspacioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Espacio'),
        ),
        drawer: Drawer(
          child: menuDrawer.menuDrawer(),
        ),
        body: Center(
          child: Text('Edicción de los espacios'),
        ),
      ),
    );
  }
}
