import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:reservaciones_app/src/models/espacios_model.dart';
export 'package:reservaciones_app/src/models/espacios_model.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();

    return _database;
  }

  Future<Database> initDatabase() async {
    //Path de la DB
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Reservaciones.db');
    print(path);

    //Creacion de la base de datos
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Espacios(
          id INTEGER PRIMARY KEY,
          nombre TEXT,
          descripcion TEXT,
          capacidad INTEGER,
          estatus INTEGER,
          imagen TEXT,
          idEdificio INTEGER
        )
      ''');
    });
  }

  Future<int> insertEspacio(EspaciosModel nuevoEspacio) async {
    final db = await database;
    final res = await db.insert('Espacios', nuevoEspacio.toJson());
    print(res);
    return res;
  }

  Future<EspaciosModel> getEspacioById(int id) async {
    final db = await database;
    final res = await db.query('Espacios', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? EspaciosModel.fromJson(res.first) : null;
  }

  Future<List<EspaciosModel>> getAllEspacios() async {
    final db = await database;
    final res = await db.query('Espacios');

    return res.isNotEmpty
        ? res.map((espacio) => EspaciosModel.fromJson(espacio)).toList()
        : [];
  }

  Future<int> updateEspacio(EspaciosModel espacio) async {
    final db = await database;
    final res = await db.update('Espacios', espacio.toJson(),
        where: 'id = ?', whereArgs: [espacio.id]);

    return res;
  }

  Future<int> deleteEspacioById(int id) async {
    final db = await database;
    final res = await db.delete('Espacios', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future<int> deleteAllEspacios() async {
    final db = await database;
    final res = await db.delete('Espacios');

    return res;
  }
}
