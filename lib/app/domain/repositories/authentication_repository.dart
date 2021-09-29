import 'package:app_comunic/app/domain/response/reset_password_response.dart';
import 'package:app_comunic/app/domain/response/sign_in_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<User?> get user;
  // para deslogear autenticacion
  Future<void> signOut();
  Future<SignInResponse> signInWithEmailAndPassword(
    String email,
    String password,
  );
// funcion que retorna future

  Future<ResetPasswordResponse> sendResetPasswordLink(String email);
}
