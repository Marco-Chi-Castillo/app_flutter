import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:reservaciones_app/src/components/menu_drawer.dart';
import 'package:reservaciones_app/src/providers/reserva_list_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reservasListProvider = Provider.of<ReservaListProvider>(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('ITSVA'),
        ),
        drawer: Drawer(
          child: menuDrawer.menuDrawer(),
        ),
        body: Center(
          child: _listaReservas(context, reservasListProvider),
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
