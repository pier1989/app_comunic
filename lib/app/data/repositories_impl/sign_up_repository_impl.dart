import 'package:app_comunic/app/domain/imput/sign_up.dart';
import 'package:app_comunic/app/domain/repositories/sign_up_repository.dart';
import 'package:app_comunic/app/domain/response/sign_up_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpRepositoryimpl implements SignUpRepository {
  final FirebaseAuth _auth;
  SignUpRepositoryimpl(this._auth);

  @override
  Future<SignUpResponse> register(SignUpData data) async {
    // TODO: implement register
    //throw UnimplementedError();

// se pasan las variables
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: data.email, password: data.password);
      // definir nombre y apellido
      await userCredential.user!.updateDisplayName(
        "${data.name} ${data.lastname}",
      );
      return SignUpResponse(null, userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return SignUpResponse(
        parStringToSogmUpError(e.code),
        null,
      );
    }
  }
}
