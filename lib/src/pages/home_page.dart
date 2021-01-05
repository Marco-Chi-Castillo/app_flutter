import 'package:flutter/material.dart';

import 'package:reservaciones_app/src/components/menu_drawer.dart';
import 'package:reservaciones_app/src/providers/db_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //BASE DE DATOS
    DBProvider.db.database;

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('ITSVA'),
        ),
        drawer: Drawer(
          child: menuDrawer.menuDrawer(),
        ),
        body: Center(
          child: Text('Proximamente...'),
        ),
      ),
    );
  }
}
