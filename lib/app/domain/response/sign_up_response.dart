import 'package:firebase_auth/firebase_auth.dart';

class SignUpResponse {
  final SignUpError? error;
  final User? user;

  SignUpResponse(this.error, this.user);
}

parStringToSogmUpError(String text) {
  switch (text) {
    case "too-many-request":
      return SignUpError.tooManyRequest;

    case "email-alredy-in-use":
      return SignUpError.emailAlredyInuse;

    case "weak-password":
      return SignUpError.weakPassword;
    case "network-request-faile":
      return SignUpError.networkRequestFailed;
    default:
      return SignUpError.unknown;
  }
}

enum SignUpError {
  emailAlredyInuse,
  weakPassword,
  unknown,
  networkRequestFailed,
  tooManyRequest,
}
