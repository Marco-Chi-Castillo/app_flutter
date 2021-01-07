import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservaciones_app/src/providers/espacio_list_provider.dart';

import 'package:reservaciones_app/src/routes/routes.dart';
import 'package:reservaciones_app/src/utils/paletaColor_util.dart';
import 'package:reservaciones_app/src/pages/error_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new EspacioListProvider()),
      ],
      child: MaterialApp(
        title: 'Reservaciones_app',
        theme: ThemeData(
          primaryColor: Style.colorPrimary,
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
      ),
    );
  }
}
