import 'dart:convert';

EdificiosModel edificiosModelFromJson(String str) =>
    EdificiosModel.fromJson(json.decode(str));

String edificiosModelToJson(EdificiosModel data) => json.encode(data.toJson());

class EdificiosModel {
  EdificiosModel({
    this.id,
    this.nombre = '',
  });

  int id;
  String nombre;

  factory EdificiosModel.fromJson(Map<String, dynamic> json) => EdificiosModel(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
