import 'package:app_comunic/app/domain/imput/sign_up.dart';
import 'package:app_comunic/app/domain/repositories/authentication_repository.dart';
import 'package:app_comunic/app/domain/repositories/sign_up_repository.dart';
import 'package:app_comunic/app/domain/response/sign_up_response.dart';
import 'package:app_comunic/app/ui/global_controllers/session_controller.dart';
import 'package:app_comunic/app/ui/pages/register/controller/register_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class RegisterController extends StateNotifier<RegisterState> {
  final SessionController _sessionController;

  RegisterController(this._sessionController)
      : super(RegisterState.initialState);
  final GlobalKey<FormState> formkey = GlobalKey();
  // recuperar autentication repositori
  final SignUpRepository _SignUpReposity = Get.i.find();

  Future<SignUpResponse> submit() async {
    //una instacia desig data y pasar datos
    final response = await _SignUpReposity.register(
      SignUpData(
          name: state.name,
          lastname: state.lastname,
          email: state.email,
          password: state.password),
    );
    if (response.error == null) {
      _sessionController.setUser(response.user!);
    }
    return response;
  }

  //LLAMA DEL ARCHIVO STATE FREASEX CREADO
// fncion que no llame dnada creando una copia de estado origunal y amos a mod el nombre
  void onNameChange(String text) {
    state = state.copyWith(name: text);
  }

  void onLastNameChange(String text) {
    state = state.copyWith(lastname: text);
  }

  void onEmailChange(String text) {
    state = state.copyWith(email: text);
  }

  void onPasswordChange(String text) {
    state = state.copyWith(password: text);
  }

  void onVPasswordChange(String text) {
    state = state.copyWith(vpassword: text);
  }
}
