import 'package:app_comunic/app/inject_dependences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await injectDependencies();

  runApp(
    const MyApp(),

    /*
    BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(InitState(), SearchRepository()),
      child: MaterialApp(home: const MyApp()),
      */
    //   ),
  );
}
