import 'package:app_comunic/app/ui/global_controllers/session_controller.dart';
import 'package:app_comunic/app/ui/pages/Splash/splash_controler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/meedu.dart';

import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_meedu/screen_utils.dart';

final splashProvider = SimpleProvider(
  (_) => SplashController(sessionProvider.read),
);

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<SplashController>(
      provider: splashProvider,
      onAfterFirstLayout: (_, __) {
        if (context.isTablet) {
          SystemChrome.setPreferredOrientations(
            [
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ],
          );
        }
      },
      onChange: (_, controller) {
        final routeName = controller.routeName;
        if (routeName != null) {
          // en vez de utilizar  Navigator.pushReplacementNamed(context, routeName);
          router.pushReplacementNamed(routeName);
        }
        //print("${controller.routeName}");
      },
      builder: (_, __) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
