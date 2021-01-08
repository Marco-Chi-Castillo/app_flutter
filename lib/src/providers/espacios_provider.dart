import 'package:reservaciones_app/src/models/espacios_model.dart';
import 'db_provider.dart';

class EspacioProvider {
  static final EspacioProvider pro = EspacioProvider._();

  EspacioProvider._();

  Future<int> insertEspacio(EspaciosModel nuevoEspacio) async {
    final db = await DBProvider.db.database;
    final res = await db.insert('Espacios', nuevoEspacio.toJson());
    print(res);
    return res;
  }

  Future<EspaciosModel> getEspacioById(int id) async {
    final db = await DBProvider.db.database;
    final res = await db.query('Espacios', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? EspaciosModel.fromJson(res.first) : null;
  }

  Future<List<EspaciosModel>> getAllEspacios() async {
    final db = await DBProvider.db.database;
    final res = await db.query('Espacios');

    return res.isNotEmpty
        ? res.map((espacio) => EspaciosModel.fromJson(espacio)).toList()
        : [];
  }

  Future<int> updateEspacio(EspaciosModel espacio) async {
    final db = await DBProvider.db.database;
    final res = await db.update('Espacios', espacio.toJson(),
        where: 'id = ?', whereArgs: [espacio.id]);

    return res;
  }

  Future<int> deleteEspacioById(int id) async {
    final db = await DBProvider.db.database;
    final res = await db.delete('Espacios', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future<int> deleteAllEspacios() async {
    final db = await DBProvider.db.database;
    final res = await db.delete('Espacios');

    return res;
  }
}
