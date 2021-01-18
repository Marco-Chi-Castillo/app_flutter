import 'package:flutter/material.dart';
import 'package:reservaciones_app/src/pages/edificio_Formulario_page.dart';
import 'package:reservaciones_app/src/pages/edificio_detalle_page.dart';
import 'package:reservaciones_app/src/pages/edificios_page.dart';
import 'package:reservaciones_app/src/pages/espacio_detalle_page.dart';
import 'package:reservaciones_app/src/pages/espacio_Formulario_page.dart';

import 'package:reservaciones_app/src/pages/home_page.dart';
import 'package:reservaciones_app/src/pages/espacios_page.dart';
import 'package:reservaciones_app/src/pages/login_page.dart';
import 'package:reservaciones_app/src/pages/registro_page.dart';
import 'package:reservaciones_app/src/pages/reserva_Formulario_page.dart';
import 'package:reservaciones_app/src/pages/reserva_detalle_page.dart';
import 'package:reservaciones_app/src/pages/reservas_page.dart';

Map<String, WidgetBuilder> getPages() {
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => LoginPage(),
    'registro': (BuildContext context) => RegistroPage(),
    'home': (BuildContext context) => HomePage(),
    'espacios': (BuildContext context) => EspaciosPage(),
    'formEspacio': (BuildContext context) => FormEspacioPage(),
    'espacioDetalle': (BuildContext context) => EspacioDetalle(),
    'edificios': (BuildContext context) => EdificiosPage(),
    'formEdificio': (BuildContext context) => FormEdificioPage(),
    'edificioDetalle': (BuildContext context) => EdificioDetalle(),
    'reservaciones': (BuildContext context)=> ReservasPage(),
    'formReserva': (BuildContext context)=> FormReservaPage(),
    'reservaDetalle': (BuildContext context) => ReservaDetalle()
  };
}
