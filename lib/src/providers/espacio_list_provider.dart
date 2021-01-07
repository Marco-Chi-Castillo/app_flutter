import 'package:flutter/material.dart';
import 'package:reservaciones_app/src/providers/db_provider.dart';

class EspacioListProvider extends ChangeNotifier {
  List<EspaciosModel> espacios = [];

  insertEspacio(EspaciosModel espacio) async {
    final id = await DBProvider.db.insertEspacio(espacio);
    espacio.id = id;
    this.espacios.add(espacio);
    notifyListeners();
  }

  getEspacioById(int id) async {
    final espacio = await DBProvider.db.getEspacioById(id);
    this.espacios.add(espacio);
    notifyListeners();
  }

  getAllEspacios() async {
    final espacios = await DBProvider.db.getAllEspacios();
    this.espacios = [...espacios];
    notifyListeners();
  }

  updateEspacio(EspaciosModel espacio) async {
    await DBProvider.db.updateEspacio(espacio);
    this.getAllEspacios();
  }

  deleteEspacioById(int id) async {
    await DBProvider.db.deleteEspacioById(id);
    this.getAllEspacios();
  }

  deleteEspacios() async {
    await DBProvider.db.deleteAllEspacios();
    this.getAllEspacios();
  }
}
