import 'package:app_comunic/app/domain/response/reset_password_response.dart';
import 'package:app_comunic/app/ui/globald_widgets/custom_imput_field.dart';
import 'package:app_comunic/app/ui/globald_widgets/dialogs/dialogs.dart';
import 'package:app_comunic/app/ui/globald_widgets/dialogs/progress_dialogs.dart';
import 'package:app_comunic/app/ui/pages/reset_password/controller/reset_password_controller.dart';
import 'package:app_comunic/app/utils/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/state.dart';

final resetPasswordProider = SimpleProvider(
  (_) => ResetPasswordController(),
);

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<ResetPasswordController>(
      provider: resetPasswordProider,
      builder: (_, controller) => Scaffold(
        appBar: AppBar(),
        // cosntriu form
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomInputField(
                    label: "Email",
                    onChanged: controller.onEmailChanged,
                    inputType: TextInputType.emailAddress,
                  ),
                  ElevatedButton(
                    onPressed: () => _submit(context),
                    child: const Text("send"),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _submit(BuildContext context) async {
    final controller = resetPasswordProider.read;
    if (isValidEmail(controller.email)) {
      ProgressDialogs.swow(context);
      //
      final response = await controller.submit();
      Navigator.pop(context);
      if (response == ResetPasswordResponse.ok) {
        Dialogs.alert(
          context,
          title: "GOOD",
          content: "Email Sent",
        );
      } else {
        String errorMessage = "";
        switch (response) {
          case ResetPasswordResponse.networkRequestFaild:
            errorMessage = "networkRequestFaild";
            break;
          case ResetPasswordResponse.userDisabled:
            errorMessage = "userDisabled";
            break;
          case ResetPasswordResponse.userNotFound:
            errorMessage = "userNotFound";
            break;
          case ResetPasswordResponse.wrongpassword:
            errorMessage = "wrongpassword";
            break;
          case ResetPasswordResponse.tooManyReqest:
            errorMessage = "tooManyReqest";
            break;
          case ResetPasswordResponse.unknow:
          default:
            errorMessage = "unknow error ";
            break;
        }
        Dialogs.alert(
          context,
          title: "ERROR",
          content: errorMessage,
        );
      }
    } else {
      Dialogs.alert(context, content: "Invalid Email");
    }
  }
}
