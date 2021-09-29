import 'package:app_comunic/app/domain/repositories/authentication_repository.dart';
import 'package:app_comunic/app/ui/global_controllers/session_controller.dart';
import 'package:app_comunic/app/ui/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class SplashController extends SimpleNotifier {
//SESSION
  final SessionController _sessionController;
  final AuthenticationRepository _authRepository = Get.i.find();

  String? _routeName;
  String? get routeName => _routeName;

  SplashController(this._sessionController) {
    print("🤩");
    _int();
  }

  void _int() async {
    final user = await _authRepository.user;
// comprobar
    if (user != null) {
      _routeName = Routes.NAVIGATION;
      _sessionController.setUser(user);
    } else {
      _routeName = Routes.LOGIN;
    }
    notify();
    /*
  if(user !=null){
    print("🤩");
  }else{
    print("😵");
  }
*/
  }
}
