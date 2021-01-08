import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
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
    return await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Roles(
          id	INTEGER NOT NULL,
          rol	TEXT NOT NULL,
          PRIMARY KEY(id)
        );

        CREATE TABLE Usuarios(
          id	INTEGER NOT NULL,
          nombre TEXT NOT NULL,
          apellido TEXT,
          email TEXT NOT NULL,
          contrasenia TEXT NOT NULL,
          roles_id	INTEGER NOT NULL,
          PRIMARY KEY(id)
          FOREIGN KEY(roles_id) REFERENCES roles(id)
          ON DELETE RESTRICT
          ON UPDATE CASCADE
        );

        CREATE TABLE Edificios (
          id	INTEGER NOT NULL,
          nombre	TEXT NOT NULL,
          PRIMARY KEY(id)
        );

        CREATE TABLE Espacios(
          id INTEGER PRIMARY KEY,
          nombre TEXT NOT NULL,
          descripcion TEXT,
          capacidad INTEGER,
          estatus INTEGER NOT NULL,
          imagen TEXT,
          idEdificio INTEGER NOT NULL,
          FOREIGN KEY(idEdificio) REFERENCES edificios(id)
          ON DELETE RESTRICT
          ON UPDATE CASCADE
        );

        CREATE TABLE reservas(
          id INTEGER PRIMARY KEY,
          fechaReservacion DATE NOT NULL,
          detalle TEXT,
          horaInicio TIME NOT NULL,
          horaFinal TIME NOT NULL,
          numAsistentes INTEGER NOT NULL,
          idUsuario INTEGER NOT NULL,
          idEspacio INTEGER NOT NULL,
          FOREIGN KEY(idUsuario) REFERENCES usuarios(id)
          ON DELETE RESTRICT
          ON UPDATE CASCADE
          
          FOREIGN KEY(idEspacio) REFERENCES espacios(id)
          ON DELETE RESTRICT
          ON UPDATE CASCADE
        );
      ''');
    });
  }
}
