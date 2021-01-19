import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:reservaciones_app/src/components/menu_drawer.dart';
import 'package:reservaciones_app/src/models/reservasRelaciones_model.dart';
import 'package:reservaciones_app/src/providers/reserva_list_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reservasListProvider = Provider.of<ReservaListProvider>(context);
    reservasListProvider.getAllReservasRelaciones();
    final reservas = reservasListProvider.reservaRelaciones;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('ITSVA'),
        ),
        drawer: Drawer(
          child: menuDrawer.menuDrawer(),
        ),
        body: Center(
          child: _listaReservas(context, reservas),
        ),
      ),
    );
  }

  Widget _listaReservas(
      BuildContext context, List<ReservasRelacionesModel> reservas) {
    return ListView.builder(
      itemCount: reservas.length,
      itemBuilder: (_, i) => Card(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reservas[i].nombreEspacio,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Detalle: " + reservas[i].detalle,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Fecha Reservación: " + reservas[i].fechaReservacion,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                "Hora Reservación: " +
                    reservas[i].horaInicio +
                    " - " +
                    reservas[i].horaFinal,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                "Usuario: " + reservas[i].nombreUsuario,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
