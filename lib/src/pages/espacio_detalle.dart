import 'package:flutter/material.dart';
import 'package:reservaciones_app/src/utils/paletaColor_util.dart';

class EspacioDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dynamic espacio = ModalRoute.of(context).settings.arguments;

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            espacio['edificio'],
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
          toolbarHeight: 100.0,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30.0,
            ),
            ListTile(
              leading: Icon(Icons.apartment),
              title: Text(espacio['Descripcion']),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text(espacio['fecha']),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: _buttons(context),
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: "btn1",
          backgroundColor: Thema.colorEditButton,
          onPressed: () {
            Navigator.pushNamed(context, 'formEspacio');
          },
          child: const Icon(Icons.edit),
        ),
        SizedBox(width: 10.0),
        FloatingActionButton(
          heroTag: "btn2",
          backgroundColor: Thema.colorDeleteButton,
          onPressed: () => _alertDelete(context),
          child: const Icon(Icons.delete),
        ),
      ],
    );
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
