import 'package:reservaciones_app/src/models/edificios_model.dart';
import 'db_provider.dart';

class EdificioProvider {
  static final EdificioProvider epro = EdificioProvider._();
  EdificioProvider._();

  Future<int> insertEdificio(EdificiosModel nuevoEdificio) async {
    final db = await DBProvider.db.database;
    final resp = await db.insert('Edificios', nuevoEdificio.toJson());
    print(resp);
    return (resp);
  }

  Future<EdificiosModel> getEdificioById(int id) async {
    final db = await DBProvider.db.database;
    final res = await db.query('Edificios', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? EdificiosModel.fromJson(res.first) : null;
  }

  Future<List<EdificiosModel>> getAllEdificios() async {
    final db = await DBProvider.db.database;
    final res = await db.query('Edificios');

    return res.isNotEmpty
        ? res.map((edificio) => EdificiosModel.fromJson(edificio)).toList()
        : [];
  }

  Future<int> updateEdificio(EdificiosModel edificio) async {
    final db = await DBProvider.db.database;
    final res = await db.update('Edificios', edificio.toJson(),
        where: 'id = ?', whereArgs: [edificio.id]);
    return res;
  }

  Future<int> deleteEdificioByid(int id) async {
    final db = await DBProvider.db.database;
    final res = await db.delete('Edificios', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllEdificios() async {
    final db = await DBProvider.db.database;
    final res = await db.delete('Edificios');
    return res;
  }
}
