import 'package:app_comunic/app/domain/repositories/authentication_repository.dart';
import 'package:app_comunic/app/domain/response/reset_password_response.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class ResetPasswordController extends SimpleNotifier {
  String _email = '';
  // acceder al valor
  String get email => _email;

  final _authenticationRepository = Get.i.find<AuthenticationRepository>();

  void onEmailChanged(String text) {
    _email = text;
  }

  Future<ResetPasswordResponse?> submit() {
    return _authenticationRepository.sendResetPasswordLink(email);
  }
}
