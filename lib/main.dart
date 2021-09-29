import 'package:app_comunic/app/inject_dependences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/data/data/search_repository.dart';
import 'app/domain/repositories/search_bloc.dart';
import 'app/domain/repositories/search_states.dart';
import 'app/my_app.dart';
import 'app/ui/pages/list/insert_screen.dart';

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
