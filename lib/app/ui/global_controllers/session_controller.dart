import 'package:app_comunic/app/domain/repositories/account_repository.dart';
import 'package:app_comunic/app/domain/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class SessionController extends SimpleNotifier {
  User? _user;
  User? get user => _user;

  //final _auth = Get.i.find<AuthenticationRepository>();
  // inferor el tipo de dato
  final AuthenticationRepository _auth = Get.i.find();

  final AccountRepository _account = Get.i.find();

  void setUser(User user) {
    _user = user;
    notify();
  }

  Future<User?> updateDisplayName(String value) async {
    final user = await _account.updateDisplayName(value);
    if (user != null) {
      _user = user;
      notify();
    }
    return user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
  }

  @override
  void dispose() {
    print("session controller dispose");
    super.dispose();
  }
}

final sessionProvider = SimpleProvider(
  (_) => SessionController(),
// para que la sesion persista y no se destruida y se traiga los valores
  autoDispose: false,
);
