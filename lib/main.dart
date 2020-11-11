import 'package:flutter/material.dart';

import 'package:reservaciones_app/src/pages/error_page.dart';
import 'package:reservaciones_app/src/routes/routes.dart';
import 'package:reservaciones_app/src/utils/paletaColor_util.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservaciones_app',
      theme: ThemeData(
        primaryColor: Thema.colorPrimary,
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: getPages(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => ErrorPage());
      },
    );
  }
}
