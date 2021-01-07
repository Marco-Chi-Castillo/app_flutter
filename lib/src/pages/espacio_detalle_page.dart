//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservaciones_app/src/models/espacios_model.dart';
import 'package:reservaciones_app/src/providers/espacio_list_provider.dart';

class EspacioDetalle extends StatelessWidget {
  /*File foto = new File('assets/im.jpg');
  String fotoUrl;*/
  @override
  Widget build(BuildContext context) {
    final EspaciosModel espacio = ModalRoute.of(context).settings.arguments;

    return Container(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, 'formEspacio', arguments: espacio);
              },
            ),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _alertDelete(context, espacio.id))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: _detallesEspacio(espacio),
          ),
        ),
      ),
    );
  }

  List<Widget> _detallesEspacio(EspaciosModel espacio) {
    final List<Widget> items = [
      Container(
        child: Column(
          children: <Widget>[
            Image.asset(espacio.imagen, //'assets/im2.jpg',
                height: 300.0,
                fit: BoxFit.cover), //_mostrarFotod(),
          ],
        ),
      ),
      //Image.asset('assets/im$url.jpg'),
      SizedBox(
        height: 30.0,
      ),
      ListTile(
        leading: Icon(Icons.apartment),
        title: Text(espacio.nombre),
        subtitle: Text('Nombre del Edificio'),
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.title),
        title: Text(espacio.descripcion),
        subtitle: Text('Descripción '),
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.account_box),
        title: Text(espacio.capacidad.toString()),
        subtitle: Text('Capacidad de personas'),
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.radio_button_checked),
        title: Text(espacio.estatus == 1 ? 'Disponible' : 'No disponible'),
        subtitle: Text('Estado del edifcio'),
      ),
    ];

    return items;
  }

  void _alertDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Eliminar'),
          content: Text('¿Desea eliminar el registro?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            FlatButton(
              onPressed: () {
                Provider.of<EspacioListProvider>(context, listen: false)
                    .deleteEspacioById(id);
                Navigator.pushNamed(context, 'espacios');
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
