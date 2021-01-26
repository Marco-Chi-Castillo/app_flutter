import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservaciones_app/src/models/reservas_models.dart';
import 'package:reservaciones_app/src/providers/reserva_list_provider.dart';
import 'package:intl/intl.dart';

class ReservaDetalle extends StatelessWidget {
  final ReservasModel reserva = ReservasModel();

  @override
  Widget build(BuildContext context) {
    final ReservasModel reserva = ModalRoute.of(context).settings.arguments;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            /*IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, 'formReserva', arguments: reserva);
              },
            ),*/
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _alertDelete(context, reserva.id))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: _detallesReserva(reserva),
          ),
        ),
      ),
    );
  }

  List<Widget> _detallesReserva(ReservasModel reserva) {
    final List<Widget> items = [
      Container(),
      SizedBox(
        height: 30.0,
      ),
      ListTile(
        leading: Icon(Icons.apartment),
        title: Text(reserva.detalle),
        subtitle: Text('Reserva'),
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.calendar_today_sharp),
        title: Text(reserva.fechaReservacion),
        subtitle: Text('Fecha de reservación'),
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.access_time_outlined),
        title: Text(reserva.horaInicio),
        subtitle: Text('Hora de inicio'),
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.access_time_rounded),
        title: Text(reserva.horaFinal),
        subtitle: Text('Hora de finalización'),
      ),
    ];

    return items;
  }

  String convertStringFromDate(DateTime fecha) {
    //  DateTime fecha =
    String formattedDate = DateFormat('yyyy-MM-dd').format(fecha);
    return formattedDate;
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
                await Provider.of<ReservaListProvider>(context, listen: false)
                    .deleteReservaById(id);
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
