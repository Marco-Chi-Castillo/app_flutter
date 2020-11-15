import 'package:flutter/material.dart';

class EspacioDetalle extends StatelessWidget {
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
        body: Column(
          children: _detallesEspacio(espacio),
        ),
      ),
    );
  }

  List<Widget> _detallesEspacio(dynamic espacio) {
    final List<Widget> items = [
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
