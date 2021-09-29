import 'package:firebase_auth/firebase_auth.dart';

abstract class AccountRepository {
// actualizar valor del campo nombre
  Future<User?> updateDisplayName(String value);
}
