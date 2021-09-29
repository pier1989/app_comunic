import 'package:app_comunic/app/domain/response/sign_in_response.dart';
import 'package:app_comunic/app/ui/globald_widgets/dialogs/dialogs.dart';
import 'package:app_comunic/app/ui/globald_widgets/dialogs/progress_dialogs.dart';
import 'package:app_comunic/app/ui/pages/login/login_page.dart';
import 'package:app_comunic/app/ui/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;

Future<void> sendLoginForm(BuildContext context) async {
  // recuperar login controlle
  final controller = loginProvider.read;
  final isValidForm = controller.formKey.currentState!.validate();
  if (isValidForm) {
    ProgressDialogs.swow(context);

    final response = await controller.submit();
    // minimizar e dialogo
    router.pop();
    if (response.error != null) {
      String errorMessage = "";
      switch (response.error) {
        case SignInError.networkRequestFaild:
          errorMessage = "networkRequestFaild";
          break;
        case SignInError.userDisabled:
          errorMessage = "userDisabled";
          break;
        case SignInError.userNotFound:
          errorMessage = "userNotFound";
          break;
        case SignInError.wrongpassword:
          errorMessage = "wrongpassword";
          break;
        case SignInError.tooManyRequests:
          errorMessage = "too Many Request";
          break;

        case SignInError.unknow:

        default:
          errorMessage = "unknow error";
          break;
      }

      print(" ${response.error}");
      Dialogs.alert(
        context,
        title: "ERROR",
        content: errorMessage,
        // content: response.error,
      );
    } else {
      //al estar todo ok llama
      router.pushReplacementNamed(
        Routes.HOME, //canmvio
        // Routes.NAVIGATION,
      );
    }
  }
}
