import 'package:app_comunic/app/domain/imput/sign_up.dart';
import 'package:app_comunic/app/domain/response/sign_up_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SignUpRepository {
  SignUpRepository(FirebaseAuth instance);

  Future<SignUpResponse> register(SignUpData data);
}
