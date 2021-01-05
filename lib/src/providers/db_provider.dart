import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

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
}
