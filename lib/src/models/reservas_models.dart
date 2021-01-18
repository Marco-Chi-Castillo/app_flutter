import 'dart:convert';

ReservasModel scanModelFromJson(String str) =>
    ReservasModel.fromJson(json.decode(str));

String scanModelToJson(ReservasModel data) => json.encode(data.toJson());

class ReservasModel {
  ReservasModel({
    this.id,
    this.fechaReservacion= '',
    this.detalle = '',
    this.horaInicio = '',
    this.horaFinal='',
    this.numAsistentes = 0,
    this.idUsuario,
    this.idEspacio,
  });

  int id;
  String fechaReservacion;
  String detalle;
  String horaInicio;
  String horaFinal;
  int numAsistentes;
  int idUsuario;
  int idEspacio;

  factory ReservasModel.fromJson(Map<String, dynamic> json) => ReservasModel(
        id: json["id"],
        fechaReservacion: json["fechaReservacion"],
        detalle: json["detalle"],
        horaInicio: json["horaInicio"],
        horaFinal: json["horaFinal"],
        numAsistentes: json["numAsistentes"],
        idUsuario: json["idUsuario"],
        idEspacio: json["idEspacio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fechaReservacion": fechaReservacion,
        "detalle": detalle,
        "horaInicio": horaInicio,
        "horaFinal": horaFinal,
        "numAsistentes": numAsistentes,
        "idUsuario": idUsuario,
        "idEspacio": idEspacio,
      };
}
