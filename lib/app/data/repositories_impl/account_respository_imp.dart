import 'package:app_comunic/app/domain/repositories/account_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

// TRAE LOS VALORES DE FIREBASE PARA LOS DATOS
class AccountRepositoryImpl implements AccountRepository {
  final FirebaseAuth _auth;

  AccountRepositoryImpl(this._auth);

  @override
  Future<User?> updateDisplayName(String value) async {
    try {
      final user = _auth.currentUser;
      assert(user != null);
      await user!.updateDisplayName(value);
      // laultima cambio
      user.reload();
      return _auth.currentUser;
    } catch (e) {
      return null;
    }
  }
}
