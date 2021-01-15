// To parse this JSON data, do
//
//     final rolModel = rolModelFromJson(jsonString);

import 'dart:convert';

RolModel rolModelFromJson(String str) => RolModel.fromJson(json.decode(str));

String rolModelToJson(RolModel data) => json.encode(data.toJson());

class RolModel {
  RolModel({
    this.id,
    this.rol = "Docente",
  });

  int id;
  String rol;

  factory RolModel.fromJson(Map<String, dynamic> json) => RolModel(
        id: json["id"],
        rol: json["rol"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rol": rol,
      };
}
