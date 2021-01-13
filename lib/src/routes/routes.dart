import 'package:flutter/material.dart';
import 'package:reservaciones_app/src/pages/espacio_detalle_page.dart';
import 'package:reservaciones_app/src/pages/espacio_Formulario_page.dart';

import 'package:reservaciones_app/src/pages/home_page.dart';
import 'package:reservaciones_app/src/pages/espacios_page.dart';
import 'package:reservaciones_app/src/pages/login_page.dart';
import 'package:reservaciones_app/src/pages/registro_page.dart';

Map<String, WidgetBuilder> getPages() {
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => LoginPage(),
    'registro': (BuildContext context) => RegistroPage(),
    'home': (BuildContext context) => HomePage(),
    'espacios': (BuildContext context) => EspaciosPage(),
    'formEspacio': (BuildContext context) => FormEspacioPage(),
    'espacioDetalle': (BuildContext context) => EspacioDetalle(),
  };
}
