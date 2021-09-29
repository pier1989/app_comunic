//import 'package:app_comunic/app/data/repositories_impl/authentication_repository_impl.dart';
//import 'package:app_comunic/app/domain/repositories/authentication_repository.dart';
import 'package:app_comunic/app/data/repositories_impl/account_respository_imp.dart';
import 'package:app_comunic/app/data/repositories_impl/authentication_repository_impl.dart';
import 'package:app_comunic/app/data/repositories_impl/preferences_repository_impl.dart';
import 'package:app_comunic/app/data/repositories_impl/sign_up_repository_impl.dart';
import 'package:app_comunic/app/domain/repositories/account_repository.dart';
//import 'package:app_comunic/app/domain/imput/sign_up.dart';
import 'package:app_comunic/app/domain/repositories/authentication_repository.dart';
import 'package:app_comunic/app/domain/repositories/preferences_repository.dart';
import 'package:app_comunic/app/domain/repositories/sign_up_repository.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> injectDependencies() async {
  final preference = await SharedPreferences.getInstance();
  Get.i.lazyPut<AuthenticationRepository>(
    () => AuthenticationRepositoryimpl(FirebaseAuth.instance),
  );

  Get.i.lazyPut<SignUpRepository>(
    () => SignUpRepositoryimpl(
      FirebaseAuth.instance,
    ),
  );
// AGREGAR ARA TRAER E NOMBRE
  Get.i.lazyPut<AccountRepository>(
    () => AccountRepositoryImpl(
      FirebaseAuth.instance,
    ),
  );
  Get.i.lazyPut<PreferencesRepository>(
    () => PreferencesRepositoryImpl(preference),
  );
}
