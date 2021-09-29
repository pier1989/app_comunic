import 'dart:async';

import 'package:app_comunic/app/domain/repositories/authentication_repository.dart';
import 'package:app_comunic/app/domain/response/reset_password_response.dart';
import 'package:app_comunic/app/domain/response/sign_in_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepositoryimpl implements AuthenticationRepository {
  final FirebaseAuth _auth;
  User? _user;

  final Completer<void> _completer = Completer();

  AuthenticationRepositoryimpl(this._auth) {
    print("👀");
    _init();
  }

  @override
  Future<User?> get user async {
    await _completer.future;
    return _user;
  }

  void _init() async {
    _auth.authStateChanges().listen(
      (User? user) {
        if (!_completer.isCompleted) {
          _completer.complete();
        }
        _user = user;
      },
    );
  }

// para deslogearse
  @override
  Future<void> signOut() {
    // TODO: implement signOut
    return _auth.signOut();
  }

  @override
  Future<SignInResponse> signInWithEmailAndPassword(
      String email, String password) async {
    try {
//usuario o contraseña no exste
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user!;
      return SignInResponse(null, user);
    } on FirebaseAuthException catch (e) {
      return SignInResponse(stringToSignInError(e.code), null);
    }
  }

  @override
  Future<ResetPasswordResponse> sendResetPasswordLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return ResetPasswordResponse.ok;
    } on FirebaseAuthException catch (e) {
      // print(e.code);
      return stringToResetPasswordRespose(e.code);
    }
  }
}
