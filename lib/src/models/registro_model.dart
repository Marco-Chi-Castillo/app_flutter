// To parse this JSON data, do
//
//     final registroModel = registroModelFromJson(jsonString);

import 'dart:convert';

RegistroModel registroModelFromJson(String str) =>
    RegistroModel.fromJson(json.decode(str));

String registroModelToJson(RegistroModel data) => json.encode(data.toJson());

class RegistroModel {
  RegistroModel({
    this.id,
    this.nombre = "",
    this.apellido = "",
    this.email = "",
    this.contrasenia = "",
    this.rolesId,
  });

  int id;
  String nombre;
  String apellido;
  String email;
  String contrasenia;
  int rolesId;

  factory RegistroModel.fromJson(Map<String, dynamic> json) => RegistroModel(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        email: json["email"],
        contrasenia: json["contrasenia"],
        rolesId: json["roles_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "email": email,
        "contrasenia": contrasenia,
        "roles_id": rolesId,
      };
}
