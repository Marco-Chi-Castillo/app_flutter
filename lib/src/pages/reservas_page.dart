import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservaciones_app/src/components/menu_drawer.dart';
import 'package:reservaciones_app/src/providers/reserva_list_provider.dart';
import 'package:reservaciones_app/src/utils/paletaColor_util.dart';

class ReservasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reservasListProvider = Provider.of<ReservaListProvider>(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Reservas ITSVA'),
        ),
        drawer: Drawer(
          child: menuDrawer.menuDrawer(),
        ),
        body: _listaReservas(context, reservasListProvider),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'formReserva');
          },
          child: Icon(Icons.add),
          backgroundColor: Style.colorPrimary,
        ),
      ),
    );
  }

  Widget _listaReservas(
      BuildContext context, ReservaListProvider reservasListProvider) {
    reservasListProvider.getAllReservas();
    final reservas = reservasListProvider.reserva;

    return ListView.builder(
      itemCount: reservas.length,
      itemBuilder: (_, i) => ListTile(
        leading: Icon(Icons.apartment),
        trailing: Icon(Icons.keyboard_arrow_right),
        title: Text(reservas[i].detalle),
        //subtitle: Text(reservas[i].descripcion),
        onTap: () {
          Navigator.pushNamed(context, 'reservaDetalle',
              arguments: reservas[i]);
        },
      ),
    );
  }
}
