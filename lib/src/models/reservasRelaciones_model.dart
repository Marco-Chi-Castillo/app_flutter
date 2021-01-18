import 'dart:convert';

ReservasRelacionesModel scanModelFromJson(String str) =>
    ReservasRelacionesModel.fromJson(json.decode(str));

String scanModelToJson(ReservasRelacionesModel data) =>
    json.encode(data.toJson());

class ReservasRelacionesModel {
  ReservasRelacionesModel({
    this.id,
    this.fechaReservacion = '',
    this.detalle = '',
    this.horaInicio = '',
    this.horaFinal = '',
    this.numAsistentes = 0,
    this.idUsuario,
    this.idEspacio,
    this.nombreUsuario,
    this.nombreEspacio,
  });

  int id;
  String fechaReservacion;
  String detalle;
  String horaInicio;
  String horaFinal;
  int numAsistentes;
  int idUsuario;
  int idEspacio;
  String nombreUsuario;
  String nombreEspacio;

  factory ReservasRelacionesModel.fromJson(Map<String, dynamic> json) =>
      ReservasRelacionesModel(
        id: json["id"],
        fechaReservacion: json["fechaReservacion"],
        detalle: json["detalle"],
        horaInicio: json["horaInicio"],
        horaFinal: json["horaFinal"],
        numAsistentes: json["numAsistentes"],
        idUsuario: json["idUsuario"],
        idEspacio: json["idEspacio"],
        nombreUsuario: json["nombreUsuario"],
        nombreEspacio: json["nombreEspacio"],
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
