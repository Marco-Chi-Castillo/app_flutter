import 'package:reservaciones_app/src/providers/db_provider.dart';
import 'package:reservaciones_app/src/models/registro_model.dart';

class RegistroProvider {
  static final RegistroProvider p = RegistroProvider._();
  RegistroProvider._();

  Future<int> insertUsuario(RegistroModel nuevoUsuario) async {
    final db = await DBProvider.db.database;
    final res = await db.insert('Usuarios', nuevoUsuario.toJson());
    print(res);
    return res;
  }

  Future<RegistroModel> getUsuarioById(int id) async {
    final db = await DBProvider.db.database;
    final res = await db.query('Usuarios', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? RegistroModel.fromJson(res.first) : null;
  }

  Future<List<RegistroModel>> getAllEspacios() async {
    final db = await DBProvider.db.database;
    final res = await db.query('Usuarios');

    return res.isNotEmpty
        ? res.map((usuario) => RegistroModel.fromJson(usuario)).toList()
        : [];
  }
}
