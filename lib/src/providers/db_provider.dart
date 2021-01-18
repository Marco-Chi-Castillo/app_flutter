import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:reservaciones_app/src/models/registro_model.dart';
import 'package:reservaciones_app/src/providers/reservas_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {

  int _idUsuarioLogueado;
  static Database _database;
  static final DBProvider _instance = new DBProvider.internal();
  factory DBProvider() => _instance;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  final String tableUsarios = "Usuario";
  final String columnNombre = "nombre";
  final String columnEmail = "email";
  final String columnPassword = "password";

  /*Declaración de la estructura de cada tabla*/
  static const tablaRoles = '''
      CREATE TABLE Roles(
        id	INTEGER NOT NULL,
        rol	TEXT NOT NULL,
        PRIMARY KEY(id)
      );
  ''';

  static const tablaUsuarios = '''
      CREATE TABLE Usuarios(
        id	INTEGER NOT NULL,
        nombre TEXT NOT NULL,
        apellido TEXT,
        email TEXT NOT NULL,
        password TEXT NOT NULL,
        flaglogged TEXT,
        PRIMARY KEY(id)
      );
  ''';

  static const tablaEdificios = '''
      CREATE TABLE Edificios (
      	id	INTEGER PRIMARY KEY,
	      nombre	TEXT NOT NULL
      );
  ''';

  static const tablaEspacios = '''
      CREATE TABLE Espacios(
        id INTEGER PRIMARY KEY,
        nombre TEXT NOT NULL,
        descripcion TEXT,
        capacidad INTEGER,
        estatus INTEGER NOT NULL,
        imagen TEXT,
        idEdificio INTEGER NOT NULL,
        FOREIGN KEY(idEdificio) REFERENCES Edificios(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
      );
  ''';

  static const tablaReservas = '''
      CREATE TABLE Reservas(
        id INTEGER PRIMARY KEY,
        fechaReservacion DATE NOT NULL,
        detalle TEXT,
        horaInicio TIME NOT NULL,
        horaFinal TIME NOT NULL,
        numAsistentes INTEGER NOT NULL,
        idUsuario INTEGER NOT NULL,
        idEspacio INTEGER NOT NULL,
        FOREIGN KEY(idUsuario) REFERENCES Usuarios(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
        
        FOREIGN KEY(idEspacio) REFERENCES Espacios(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
      );
  ''';

  static const triggerBeforeInsertReservas = '''
      CREATE TRIGGER before_reservas_insert BEFORE INSERT ON Reservas
      FOR EACH ROW
      BEGIN
      SELECT RAISE (ABORT, 'There is already a reservation on that date and time.') 
      WHERE  EXISTS (SELECT 1 FROM Reservas 
          WHERE 
          NEW.id <> Reservas.id AND NEW.fechaReservacion= Reservas.fechaReservacion
          AND NEW.idEspacio = Reservas.idEspacio AND
          (NEW.horaInicio BETWEEN Reservas.horaInicio AND Reservas.horaFinal OR
          NEW.horaFinal BETWEEN Reservas.horaInicio AND Reservas.horaFinal OR
          (NEW.horaInicio <= Reservas.horaInicio AND NEW.horaFinal >= Reservas.horaFinal)));
      END;
  ''';

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();

    return _database;
  }

  DBProvider.internal();

  Future<Database> initDatabase() async {
    //Path de la DB
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Reservaciones.db');
    print(path);

    //Creacion de la base de datos
    return await openDatabase(path, version: 8,
        onCreate: (Database db, int version) async {
      await db.execute(tablaRoles);
      await db.execute(tablaUsuarios);
      await db.execute(tablaEdificios);
      await db.execute(tablaEspacios);
      await db.execute(tablaReservas);
      await db.execute(triggerBeforeInsertReservas);
    });
  }

  Future<int> saveUser(RegistroModel user) async {
    var dbClient = await database;
    //print(user.nombre);
    int res = await dbClient.insert("Usuarios", user.toMap());
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Usuarios');
    //print(list);
    print(res);
    return res;
  }

  Future<RegistroModel> selectUser(RegistroModel user) async {
    //("Select User");
    //print(user.email);
    //(user.password);
    var dbClient = await database;
    List<Map> maps = await dbClient.query("Usuarios ",
        columns: [columnEmail, columnPassword],
        where: "$columnEmail = ? and $columnPassword = ?",
        whereArgs: [ user.email, user.password]);
     //print(maps);   
    String email2 =user.email.toString();
    String pass = user.password;   
    List<Map> list = await dbClient.rawQuery('SELECT id FROM Usuarios WHERE email = "$email2" AND password = $pass');
    
    Map id = list[0];
    _idUsuarioLogueado = int.parse(id["id"].toString());
    ReservasProvider.rpro.setUsuarioId(_idUsuarioLogueado);
     
  
    if (maps.length > 0) {
      //print("User Exist !!!");
      return user;
    } else {
      return null;
    }
    
  }
}
