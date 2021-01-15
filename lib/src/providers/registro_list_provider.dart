import 'package:flutter/cupertino.dart';
import 'package:reservaciones_app/src/models/registro_model.dart';
import 'package:reservaciones_app/src/providers/registro_provider.dart';

class RegistroListProvider extends ChangeNotifier {
  List<RegistroModel> usuarios = [];

  insertUsuario(RegistroModel usuario) async {
    final id = await RegistroProvider.p.insertUsuario(usuario);
    usuario.id = id;
    this.usuarios.add(usuario);
    notifyListeners();
  }

  getEspacioById(int id) async {
    final usuario = await RegistroProvider.p.getUsuarioById(id);
    this.usuarios.add(usuario);
    notifyListeners();
  }

  getAllEspacios() async {
    final usuarios = await RegistroProvider.p.getAllEspacios();
    this.usuarios = [...usuarios];
    notifyListeners();
  }
}
