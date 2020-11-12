import 'package:flutter/material.dart';
import 'package:reservaciones_app/src/components/menu_drawer.dart';
import 'package:reservaciones_app/src/providers/espacios_provider.dart';
import 'package:reservaciones_app/src/utils/paletaColor_util.dart';

class EspaciosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Espacios ITSVA'),
        ),
        drawer: Drawer(
          child: menuDrawer.menuDrawer(),
        ),
        body: _listaEspacios(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'formEspacio');
          },
          child: Icon(Icons.add),
          backgroundColor: Thema.colorPrimary,
        ),
      ),
    );
  }

  Widget _listaEspacios() {
    return FutureBuilder(
      future: espaciosProvider.cargarDatos(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _itemsEspacios(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> _itemsEspacios(List<dynamic> data, BuildContext context) {
    final List<Widget> items = [];
    data.forEach((element) {
      final widgetTemp = Card(
        child: ListTile(
          leading: Icon(Icons.apartment),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text(element['edificio']),
          subtitle: Text(element['Descripcion']),
          onTap: () {
            Navigator.pushNamed(context, 'espacioDetalle', arguments: element);
          },
        ),
      );

      items.add(widgetTemp);
    });

    return items;
  }
}
