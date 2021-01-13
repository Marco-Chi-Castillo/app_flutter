import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:reservaciones_app/src/components/menu_drawer.dart';
import 'package:reservaciones_app/src/providers/edificio_list_provider.dart';
import 'package:reservaciones_app/src/utils/paletaColor_util.dart';

class EdificiosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final edificiosListProvider = Provider.of<EdificioListProvider>(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edificios'),
        ),
        drawer: Drawer(
          child: menuDrawer.menuDrawer(),
        ),
        body: _listaEdificios(context, edificiosListProvider),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'formEdificio');
          },
          child: Icon(Icons.add),
          backgroundColor: Style.colorPrimary,
        ),
      ),
    );
  }

  Widget _listaEdificios(
      BuildContext context, EdificioListProvider edificiosListProvider) {
    edificiosListProvider.getAllEdificios();
    final edificio = edificiosListProvider.edificio;
    return ListView.builder(
      itemCount: edificio.length,
      itemBuilder: (_, i) => ListTile(
        leading: Icon(Icons.apartment),
        trailing: Icon(Icons.keyboard_arrow_right),
        title: Text(edificio[i].nombre),
        onTap: () {
          Navigator.pushNamed(context, 'edificioDetalle',
              arguments: edificio[i]);
        },
      ),
    );
  }
}
