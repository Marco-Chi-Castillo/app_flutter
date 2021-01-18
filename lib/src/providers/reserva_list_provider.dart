import 'package:flutter/material.dart';
import 'package:reservaciones_app/src/models/reservas_models.dart';
import 'package:reservaciones_app/src/providers/reservas_provider.dart';

class ReservaListProvider extends ChangeNotifier {
  List<ReservasModel> reserva = [];

  insertReserva(ReservasModel reserva) async {
    final id = await ReservasProvider.rpro.insertReserva(reserva);
    reserva.id = id;
    this.reserva.add(reserva);
    notifyListeners();
    return id;
    
  }

  getReservaById(int id) async {
    final reserva = await ReservasProvider.rpro.getReservaById(id);
    this.reserva.add(reserva);
    notifyListeners();
  }

  getAllReservas() async {
    final reserva = await ReservasProvider.rpro.getAllReservas();
    this.reserva = [...reserva];
    notifyListeners();
  }

  updateReserva(ReservasModel reserva) async {
    await ReservasProvider.rpro.updateReserva(reserva);
    this.getAllReservas();
  }

  deleteReservaById(int id) async {
    await ReservasProvider.rpro.deleteReservaByid(id);
    this.getAllReservas();
  }

  deleteReserva() async {
    await ReservasProvider.rpro.deleteAllReservas();
    this.getAllReservas();
  }
}
