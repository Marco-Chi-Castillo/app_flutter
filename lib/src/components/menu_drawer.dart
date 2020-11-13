import 'package:flutter/material.dart';
import 'package:reservaciones_app/src/providers/menu_provider.dart';
import 'package:reservaciones_app/src/utils/getIcon_util.dart';
import 'package:reservaciones_app/src/utils/paletaColor_util.dart';

class MenuDrawer {
  Widget menuDrawer() {
    return FutureBuilder(
        future: menuProvider.cargarData(),
        initialData: [],
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          return ListView(
            children: _itemsListView(snapshot.data, context),
          );
        });
  }

  List<Widget> _itemsListView(List<dynamic> data, BuildContext context) {
    final List<Widget> opcionesMenu = [];

    opcionesMenu.add(_drawerHeader());

    data.forEach((element) {
      final widgetTemp = ListTile(
        title: Text(element['texto']),
        leading: getIcon(element['icon']),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.pop(
              context); //Para cerrar el Drawer de Page en que nos encontremos.
          Navigator.pushNamed(context, element['ruta']);
        },
      );

      opcionesMenu..add(widgetTemp)..add(Divider());
    });

    return opcionesMenu;
  }

  DrawerHeader _drawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Style.colorPrimary,
      ),
      child: Column(
        children: <Widget>[
          Image(
            height: 100,
            width: 100,
            image: AssetImage('assets/images/logo_itsva.png'),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              'Reservación de Espacios',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final menuDrawer = new MenuDrawer();
