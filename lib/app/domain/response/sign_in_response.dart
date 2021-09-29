//clase va a guradar insicial un string
//import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignInResponse {
  final SignInError? error;
  final User? user;

  SignInResponse(this.error, this.user);
}

enum SignInError {
  tooManyRequests,
  networkRequestFaild,
  userDisabled,
  userNotFound,
  wrongpassword,
  unknow,
}
SignInError stringToSignInError(String code) {
  switch (code) {
    case "too-many-requests":
      return SignInError.tooManyRequests;
    case "user-disabled":
      return SignInError.userDisabled;
    case "user-not-found":
      return SignInError.userNotFound;

    case "network-request-failed":
      return SignInError.networkRequestFaild;
    case "wrong-password":
      return SignInError.unknow;
    default:
      return SignInError.wrongpassword;
  }
}
