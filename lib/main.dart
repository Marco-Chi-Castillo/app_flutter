import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:reservaciones_app/src/pages/error_page.dart';
import 'package:reservaciones_app/src/providers/edificio_list_provider.dart';
import 'package:reservaciones_app/src/providers/espacio_list_provider.dart';
import 'package:reservaciones_app/src/providers/reserva_list_provider.dart';

import 'package:reservaciones_app/src/routes/routes.dart';
import 'package:reservaciones_app/src/utils/paletaColor_util.dart';
//import 'package:reservaciones_app/src/pages/error_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_) => new EspacioListProvider()),
        ChangeNotifierProvider(create: (_) => new EdificioListProvider()),
        ChangeNotifierProvider(create: (_)=> new ReservaListProvider())
      ],
      child: MaterialApp(
        localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('es')
      ],
        title: 'Reservaciones_app',
        theme: ThemeData(
          primaryColor: Style.colorPrimary,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: getPages(),
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ErrorPage());
        },
      ),
    );
  }
}
