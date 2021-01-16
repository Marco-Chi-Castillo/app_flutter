import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reservaciones_app/src/providers/db_provider.dart';
import 'package:reservaciones_app/src/providers/espacios_provider.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class EspacioListProvider extends ChangeNotifier {
  List<EspaciosModel> espacios = [];

  insertEspacio(EspaciosModel espacio) async {
    final id = await EspacioProvider.pro.insertEspacio(espacio);
    espacio.id = id;
    this.espacios.add(espacio);
    notifyListeners();
  }

  getEspacioById(int id) async {
    final espacio = await EspacioProvider.pro.getEspacioById(id);
    this.espacios.add(espacio);
    notifyListeners();
  }

  getAllEspacios() async {
    final espacios = await EspacioProvider.pro.getAllEspacios();
    this.espacios = [...espacios];
    notifyListeners();
  }

  updateEspacio(EspaciosModel espacio) async {
    await EspacioProvider.pro.updateEspacio(espacio);
    this.getAllEspacios();
  }

  deleteEspacioById(int id) async {
    await EspacioProvider.pro.deleteEspacioById(id);
    this.getAllEspacios();
  }

  deleteEspacios() async {
    await EspacioProvider.pro.deleteAllEspacios();
    this.getAllEspacios();
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dwgxedtgs/image/upload?upload_preset=p5fzlejl');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData['secure_url'];
  }
}
