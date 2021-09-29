import 'package:app_comunic/app/domain/imput/sign_up.dart';
import 'package:app_comunic/app/domain/response/sign_in_response.dart';
import 'package:app_comunic/app/domain/response/sign_up_response.dart';
import 'package:app_comunic/app/ui/globald_widgets/dialogs/dialogs.dart';
import 'package:app_comunic/app/ui/globald_widgets/dialogs/progress_dialogs.dart';
import 'package:app_comunic/app/ui/routes/routes.dart';

import '../register_pages.dart' show registerProvider;
import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter_meedu/router.dart' as router;

//va a recivir contexto para recibir un dialogo
Future<void> sendRegisterForm(BuildContext context) async {
  //acceder alcontrolador vinculado llmado a red
  final controller = registerProvider.read;
  final isValidForm =
      controller.formkey.currentState!.validate(); //recupera el from key

  if (isValidForm) {
    ProgressDialogs.swow(context);
    final response = await controller.submit();
    // destruir dialogo
    router.pop();

    if (response.error != null) {
      // print(" 🤑 error ${response.error}");
      late String content = "";
      switch (response.error) {
        case SignUpError.emailAlredyInuse:
          content = "email already -in -use";
          break;
        case SignUpError.weakPassword:
          content = "weak Password";
          break;
        case SignUpError.networkRequestFailed:
          content = "network Request Failed";
          break;
        case SignUpError.tooManyRequest:
          content = "too Many Request";
          break;

        case SignUpError.unknown:
        default:
          content = "unknown";
          break;
      }

      Dialogs.alert(
        context,
        title: "ERROR",
        content: content,
      );
    } else {
      // para remover toas la paginas
      router.pushNamedAndRemoveUntil(Routes.HOME);
    }
  } else {
    Dialogs.alert(context, title: "ERROR", content: "invalid Fields");
  }
}
// me quede en el video13