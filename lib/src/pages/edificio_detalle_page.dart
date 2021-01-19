import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservaciones_app/src/models/edificios_model.dart';
import 'package:reservaciones_app/src/providers/edificio_list_provider.dart';

class EdificioDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EdificiosModel edificio = ModalRoute.of(context).settings.arguments;

    return Container(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'formEdificio',
                    arguments: edificio);
              },
            ),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _alertDelete(context, edificio.id))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: _detallesEspacio(edificio),
          ),
        ),
      ),
    );
  }

  List<Widget> _detallesEspacio(EdificiosModel edificio) {
    final List<Widget> items = [
      Container(
        child: Column(),
      ),
      SizedBox(
        height: 30.0,
      ),
      ListTile(
        leading: Icon(Icons.apartment),
        title: Text(edificio.nombre),
        subtitle: Text('Nombre del Edificio'),
      ),
      Divider(),
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
              onPressed: () async {
               await Provider.of<EdificioListProvider>(context, listen: false)
                    .deleteEdificioById(id);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
