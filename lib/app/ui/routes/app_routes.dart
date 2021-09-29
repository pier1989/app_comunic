import 'package:app_comunic/app/ui/pages/gestionar_ubicacion/add_geolocalizacion.dart';
import 'package:app_comunic/app/ui/pages/gestionar_ubicacion/list_geolocalizacion.dart';
import 'package:app_comunic/app/ui/pages/home/home_pages.dart';
import 'package:app_comunic/app/ui/pages/list/insert_screen.dart';
import 'package:app_comunic/app/ui/pages/list/list_averia/search_screen.dart';
import 'package:app_comunic/app/ui/pages/login/login_page.dart';
import 'package:app_comunic/app/ui/pages/navigation_drawer/widget/navigation_drawer_widget.dart';
import 'package:app_comunic/app/ui/pages/register/register_pages.dart';
//import 'package:app_comunic/app/ui/pages/reset/reset_password_pages.dart';
import 'package:app_comunic/app/ui/pages/reset_password/reset_password_pages.dart';
import 'package:app_comunic/app/ui/pages/home/tabs/sidebar/sidebar.dart';
import 'package:flutter/widgets.dart' show Widget, BuildContext;
import 'package:app_comunic/app/ui/pages/Splash/splash_page.dart';

import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.SPLASH: (_) => const SplashPage(),
      Routes.LOGIN: (_) => const LoginPage(),
      Routes.REGISTER: (_) => const RegisterPage(),
      Routes.HOME: (_) => const HomePage(),
      Routes.INSERTEMPL: (_) => Insert(),
      Routes.MAPLOCATION: (_) => const MapLocation(),
      Routes.MAPLIST: (_) => SearchUi(),
      Routes.NAVIGATION: (_) => NavigationDrawerWidget(),
      Routes.RESET_PASSWORD: (_) => const ResetPasswordPage(),
    };
