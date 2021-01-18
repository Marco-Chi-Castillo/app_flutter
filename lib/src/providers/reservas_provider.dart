import 'package:reservaciones_app/src/models/reservas_models.dart';
import 'db_provider.dart';

class ReservasProvider {
  static final ReservasProvider rpro = ReservasProvider._();
  ReservasProvider._();
  int _idUser;
  Future<int> insertReserva(ReservasModel nuevaReserva) async {
    try {
       final db = await DBProvider.db.database;
       final resp = await db.insert('Reservas', nuevaReserva.toJson());
       print(resp);
       return (resp);
      
    } catch (e) {
      
       return null;
       
    }
   
  }

  Future<ReservasModel> getReservaById(int id) async {
    final db = await DBProvider.db.database;
    final res = await db.query('Reservas', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ReservasModel.fromJson(res.first) : null;
  }

  int getUsuarioId(){
     
      return _idUser;
  }
  void setUsuarioId(int id){
     _idUser=id;
  }

  Future<List<ReservasModel>> getAllReservas() async {
    final db = await DBProvider.db.database;
    final res = await db.query('Reservas');

    return res.isNotEmpty
        ? res.map((reserva) => ReservasModel.fromJson(reserva)).toList()
        : [];
  }

  Future<int> updateReserva(ReservasModel reserva) async {
    final db = await DBProvider.db.database;
    final res = await db.update('Reservas', reserva.toJson(),
        where: 'id = ?', whereArgs: [reserva.id]);
    return res;
  }

  Future<int> deleteReservaByid(int id) async {
    final db = await DBProvider.db.database;
    final res = await db.delete('Reservas', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllReservas() async {
    final db = await DBProvider.db.database;
    final res = await db.delete('Reservas');
    return res;
  }
}
