//import 'package:flutter/material.dart';
//import 'package:flutter_meedu/meedu.dart';

// ESTABLECER MODO OSCURO

import 'package:app_comunic/app/domain/repositories/preferences_repository.dart';
import 'package:app_comunic/app/ui/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:google_fonts/google_fonts.dart';

//constatnte

//const primaryDarkColor = Color(0xffd81b60);

class ThemeController extends SimpleNotifier {
  late ThemeMode _mode;
  ThemeController() {
    _mode = _preferences.IsdarkModes ? ThemeMode.dark : ThemeMode.light;
  }

  final PreferencesRepository _preferences = Get.i.find();

  ThemeMode get mode => _mode;
  bool get isDark => _mode == ThemeMode.dark;

  TextTheme get _textTheme {
    return GoogleFonts.nunitoSansTextTheme();
  }

//DEFINIR THEMA CLARO
  ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      brightness: Brightness.light,
      //cambiar color del app bar
      appBarTheme: const AppBarTheme(
        //iconos del appbar
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),

      primaryColorLight: primaryLightColor,
      colorScheme: ColorScheme.fromSwatch(
          //definir
          brightness: Brightness.light,
          primarySwatch: MaterialColor(primaryLightColor.value, swatch)),
      //borde
      inputDecorationTheme: InputDecorationTheme(
          //labelStyle: TextStyle(color: Colors),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: primaryLightColor.withOpacity(0.5),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
            ),
          )),
    );
  }

  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
        //cambiar color del app bar
        appBarTheme: const AppBarTheme(
          //iconos del appbar
          brightness: Brightness.dark,
          backgroundColor: primaryDarkColor,
        ),
        textTheme: _textTheme
            .merge(
              ThemeData.dark().textTheme,
            )
            .apply(
              fontFamily: _textTheme.bodyText1!.fontFamily,
            ),
        scaffoldBackgroundColor: const Color(0xff102027),
        primaryColorDark: primaryDarkColor,
        //cambiar color del cursor en mododark
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primaryDarkColor,
          //borde
        ),
        //cambiar color del label de caja de texto
        colorScheme: ColorScheme.fromSwatch(
            //definir
            brightness: Brightness.dark,
            primarySwatch: MaterialColor(primaryDarkColor.value, swatch)),

        //borde
        inputDecorationTheme: const InputDecorationTheme(
            //labelStyle: TextStyle(color: Colors),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryDarkColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white54,
              ),
            )));
  }

  void toggle() {
    if (_mode == ThemeMode.light) {
      _mode = ThemeMode.dark;
      // guardar cambio en preferencias
      _preferences.darkMode(true);
      //
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light,
      );
    } else {
      _mode = ThemeMode.light;
      // guardar cambio en preferencias
      _preferences.darkMode(false);
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark,
      );
    }
    notify();
  }
}

//import 'package:flutter_meedu/meedu.dart';
final themeProvider = SimpleProvider(
  (_) => ThemeController(),
  autoDispose: false,
);
