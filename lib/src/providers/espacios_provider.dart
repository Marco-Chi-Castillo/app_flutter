import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class _EspaciosProvider {
  List<dynamic> espacios = [];

  Future<List<dynamic>> cargarDatos() async {
    final resp = await rootBundle.loadString('data/lista_espacios.json');
    Map dataMap = json.decode(resp);
    espacios = dataMap['espacios'];

    return espacios;
  }
}

final espaciosProvider = new _EspaciosProvider();
