import 'dart:convert';

EspaciosModel espaciosModelFromJson(String str) =>
    EspaciosModel.fromJson(json.decode(str));

String espaciosModelToJson(EspaciosModel data) => json.encode(data.toJson());

class EspaciosModel {
  EspaciosModel({
    this.id,
    this.nombre = '',
    this.descripcion = '',
    this.capacidad = 0,
    this.estatus = 1,
    this.imagen,
    this.idEdificio,
  });

  int id;
  String nombre;
  String descripcion;
  int capacidad;
  int estatus;
  String imagen;
  int idEdificio;

  factory EspaciosModel.fromJson(Map<String, dynamic> json) => EspaciosModel(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        capacidad: json["capacidad"],
        estatus: json["estatus"],
        imagen: json["imagen"],
        idEdificio: json["idEdificio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "capacidad": capacidad,
        "estatus": estatus,
        "imagen": imagen,
        "idEdificio": idEdificio,
      };
}
