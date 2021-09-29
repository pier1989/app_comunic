import 'package:app_comunic/app/ui/global_controllers/session_controller.dart';
import 'package:app_comunic/app/ui/globald_widgets/custom_imput_field.dart';
import 'package:app_comunic/app/ui/globald_widgets/rounded_button.dart';
import 'package:app_comunic/app/ui/pages/login/utils/send_login_form.dart';
import 'package:app_comunic/app/ui/routes/routes.dart';
import 'package:app_comunic/app/utils/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/state.dart';
import 'package:flutter_svg/svg.dart';

import 'controller/login_controller.dart';
import 'package:flutter_meedu/screen_utils.dart';

final loginProvider = SimpleProvider(
  (_) => LoginController(sessionProvider.read),
);

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;
    //quita oveflow
    // MediaQuery.of(context).size;
    //altura
    //MediaQuery.of(context).padding.bottom;
    final padding = context.mediaQueryPadding;
    final height = context.height - padding.top - padding.bottom;

    return ProviderListener<LoginController>(
      provider: loginProvider,
      builder: (_, controller) {
        return Scaffold(
          body: ListView(
            children: [
              SizedBox(
                height: height,
                child: GestureDetector(
                  // envolver dentro para que no este pegado y desaparesca teclado
                  onTap: () => Focus.of(context).unfocus(),
                  child: Container(
                    color: Colors.transparent, // color para minimizar
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    child: Form(
                      key: controller.formKey,
                      //para ajustar los textos
                      child: Align(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 360,
                          ),
                          child: Column(
                            mainAxisAlignment: context.isTablet
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.end, //alinear abjao
                            children: [
                              //   SvgPicture
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: SvgPicture.asset(
                                  'assets/images/${isDarkMode ? 'dark' : 'light'}/welcome.svg',
                                  //width: 200,
                                ),
                              ),
                              const SizedBox(height: 20), // separacion
                              //definir el diseño de email y contraseña
                              CustomInputField(
                                label: "Email",

                                //GUARDAR EL TEXTO QUE DIGITAMOIS
                                onChanged: controller.onEmailChanged,
                                inputType: TextInputType.emailAddress,

                                //validaciones
                                validator: (text) {
                                  if (isValidEmail(text!)) {
                                    return null;
                                  }
                                  return "Invalid Email";
                                },
                              ),
                              const SizedBox(height: 20), // separacion

                              CustomInputField(
                                label: "Password",
                                //GUARDAR EL TEXTO QUE DIGITAMOIS
                                onChanged: controller.onPasswordChanged,
                                isPassword: true,

                                //validacion
                                validator: (text) {
                                  if (text!.trim().length >= 6) {
                                    return null;
                                  }
                                  return "Invalid Password";
                                },
                              ),
                              const SizedBox(height: 20), // separacion
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: ()
                                        //activa la funcion para llmar
                                        =>
                                        router.pushNamed(Routes.RESET_PASSWORD),
                                    child: const Text("Forgot Password?"),
                                  ),
                                  const SizedBox(height: 10),
                                  RoundedButtom(
                                    text: "Sign In",
                                    onPressed: () => sendLoginForm(context),
                                  ),
                                ],
                              ),
                              //crear boton y llmar a clase
                              const SizedBox(height: 20), // separacion
                              Row(
                                //centrado
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Dont Have an Account?",
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        router.pushNamed(Routes.REGISTER),
                                    child: const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (!context.isTablet) const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
