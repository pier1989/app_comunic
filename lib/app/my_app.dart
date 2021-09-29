//import 'package:flutter/cupertino.dart';

//import 'package:flutter/material.dart';

//import 'package:flutter/material.dart';

import 'package:app_comunic/app/ui/global_controllers/theme_controller.dart';
import 'package:app_comunic/app/ui/routes/app_routes.dart';
import 'package:app_comunic/app/ui/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/router.dart' as router;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, watch, __) {
      final theme = watch(themeProvider);
      return MaterialApp(
        title: 'Flutter',
//navigator para navergar por tras ventanas
        navigatorKey: router.navigatorKey,
        debugShowCheckedModeBanner: false,
        //pagina principal
        initialRoute: Routes.SPLASH,
        darkTheme: theme.darkTheme,
        theme: theme.lightTheme,
        themeMode: theme.mode,
        navigatorObservers: [router.observer],
        routes: appRoutes,
      );
    });
  }
}
