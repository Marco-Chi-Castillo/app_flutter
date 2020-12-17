//import 'dart:io';

import 'package:flutter/material.dart';

class EspacioDetalle extends StatelessWidget {
  /*File foto = new File('assets/im.jpg');
  String fotoUrl;*/
  @override
  Widget build(BuildContext context) {
    final dynamic espacio = ModalRoute.of(context).settings.arguments;

    return Container(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, 'formEspacio');
              },
            ),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _alertDelete(context))
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

  List<Widget> _detallesEspacio(dynamic espacio) {
    final List<Widget> items = [
      Container(
        child: Column(
          children: <Widget>[
            Image.asset(espacio['fotoUrl'], //'assets/im2.jpg',
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
        title: Text(espacio['edificio']),
        subtitle: Text('Nombre del Edificio'),
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.title),
        title: Text(espacio['Descripcion']),
        subtitle: Text('Descripción '),
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.calendar_today),
        title: Text(espacio['fecha']),
        subtitle: Text('Fecha de creación'),
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.account_box),
        title: Text(espacio['capacidad']),
        subtitle: Text('Capacidad de personas'),
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.radio_button_checked),
        title: Text(espacio['estado']),
        subtitle: Text('Estado del edifcio'),
      ),
    ];

    return items;
  }

  void _alertDelete(BuildContext context) {
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
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
