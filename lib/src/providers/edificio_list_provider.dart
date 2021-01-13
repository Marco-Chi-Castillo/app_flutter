import 'package:flutter/material.dart';
import 'package:reservaciones_app/src/models/edificios_model.dart';
import 'package:reservaciones_app/src/providers/edificio_provider.dart';

class EdificioListProvider extends ChangeNotifier {
  List<EdificiosModel> edificio = [];

  insertEdificio(EdificiosModel edificio) async {
    final id = await EdificioProvider.epro.insertEdificio(edificio);
    edificio.id = id;
    this.edificio.add(edificio);
    notifyListeners();
  }

  getEdificioById(int id) async {
    final edificio = await EdificioProvider.epro.getEdificioById(id);
    this.edificio.add(edificio);
    notifyListeners();
  }

  getAllEdificios() async {
    final edificio = await EdificioProvider.epro.getAllEdificios();
    this.edificio = [...edificio];
    notifyListeners();
  }

  updateEdificio(EdificiosModel edificio) async {
    await EdificioProvider.epro.updateEdificio(edificio);
    this.getAllEdificios();
  }

  deleteEdificioById(int id) async {
    await EdificioProvider.epro.deleteEdificioByid(id);
    this.getAllEdificios();
  }

  deleteEdificios() async {
    await EdificioProvider.epro.deleteAllEdificios();
    this.getAllEdificios();
  }
}
