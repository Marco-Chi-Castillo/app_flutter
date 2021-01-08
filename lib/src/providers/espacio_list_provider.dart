import 'package:flutter/material.dart';
import 'package:reservaciones_app/src/providers/db_provider.dart';
import 'package:reservaciones_app/src/providers/espacios_provider.dart';

class EspacioListProvider extends ChangeNotifier {
  List<EspaciosModel> espacios = [];

  insertEspacio(EspaciosModel espacio) async {
    final id = await EspacioProvider.pro.insertEspacio(espacio);
    espacio.id = id;
    this.espacios.add(espacio);
    notifyListeners();
  }

  getEspacioById(int id) async {
    final espacio = await EspacioProvider.pro.getEspacioById(id);
    this.espacios.add(espacio);
    notifyListeners();
  }

  getAllEspacios() async {
    final espacios = await EspacioProvider.pro.getAllEspacios();
    this.espacios = [...espacios];
    notifyListeners();
  }

  updateEspacio(EspaciosModel espacio) async {
    await EspacioProvider.pro.updateEspacio(espacio);
    this.getAllEspacios();
  }

  deleteEspacioById(int id) async {
    await EspacioProvider.pro.deleteEspacioById(id);
    this.getAllEspacios();
  }

  deleteEspacios() async {
    await EspacioProvider.pro.deleteAllEspacios();
    this.getAllEspacios();
  }
}
