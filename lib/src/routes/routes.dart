import 'package:flutter/material.dart';
import 'package:reservaciones_app/src/pages/espacio_detalle.dart';
import 'package:reservaciones_app/src/pages/formEspacios_page.dart';

import 'package:reservaciones_app/src/pages/home_page.dart';
import 'package:reservaciones_app/src/pages/espacios_page.dart';

Map<String, WidgetBuilder> getPages() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'espacios': (BuildContext context) => EspaciosPage(),
    'formEspacio': (BuildContext context) => FormEspacioPage(),
    'espacioDetalle': (BuildContext context) => EspacioDetalle(),
  };
}
