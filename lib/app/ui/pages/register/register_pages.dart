import 'package:app_comunic/app/ui/global_controllers/session_controller.dart';
import 'package:app_comunic/app/ui/globald_widgets/custom_imput_field.dart';
import 'package:app_comunic/app/ui/pages/register/utils/send_register_form.dart';
//mport 'package:app_comunic/app/ui/pages/register/controller/register_controller.dart';
import 'package:app_comunic/app/utils/email_validator.dart';
import 'package:app_comunic/app/utils/name_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/state.dart';

import 'controller/register_controller.dart';
import 'controller/register_state.dart';

//clase q extiende
final registerProvider = StateProvider<RegisterController, RegisterState>(
  (_) => RegisterController(sessionProvider.read),
);

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<RegisterController>(
      provider: registerProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: AppBar(),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
                width: double.infinity,
                //  padding: const EdgeInsets.all(15),
                height: double.infinity, //ocupar toa la altura
                color: Colors.transparent,
                child: Form(
                  // asignar un key
                  key: controller.formkey, // trabaja con controller
                  child: ListView(
                    //PARA los txt hacermargen
                    padding: const EdgeInsets.all(15),
                    children: [
                      CustomInputField(
                        label: "Name",
                        onChanged: controller.onNameChange,
                        validator: (text) {
                          // EN CASODE NULO
                          //print("isValidName(text) ${(isValidName(text))}");
                          return isValidName(text!) ? null : "Invalid Name";
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomInputField(
                        label: "Last Name",
                        onChanged:
                            controller.onLastNameChange, //llamamos al conroler
                        validator: (text) {
                          // EN CASODE NULO
                          //print("isValidName(text) ${(isValidName(text))}");
                          return isValidName(text!)
                              ? null
                              : "Invalid Last Name";
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomInputField(
                        label: "E-mail",
                        inputType: TextInputType.emailAddress,
                        onChanged: controller.onEmailChange,
                        validator: (text) {
                          print("text $text");
                          if (text == null) return "Invalid Email";
                          // EN CASODE NULO
                          return isValidEmail(text) ? null : "Invalid Email";
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomInputField(
                        label: "Password",
                        onChanged: controller.onPasswordChange,
                        isPassword: true,
                        validator: (text) {
                          // if (text == null) return "invalid Password";
                          if (text!.trim().length >= 6) {
                            return null;
                          }
                          return "invalid password";
                        },
                      ),
                      const SizedBox(height: 15),
                      //defini widget consumer
                      Consumer(
                        builder: (_, watch, __) {
                          // renderizar para que cambie e l estado
                          watch(
                            registerProvider.select(
                              (_) => _.password,
                            ),
                          );
                          return CustomInputField(
                            label: "Verification Password",
                            onChanged: controller.onVPasswordChange,
                            isPassword: true,
                            validator: (text) {
                              //if (text == null) return "invslid password";
                              //validadcion de campos diferentes
                              if (controller.state.password != text) {
                                return "ássword dont match";
                              }
                              if (text!.trim().length >= 6) {
                                return null;
                              }

                              return "invalid password";
                            },
                          );
                        },
                      ),
                      // const SizedBox(height: 15),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        child: const Text("Register"),
                        // color: Colors.blue,
                        onPressed: () => sendRegisterForm(
                            context), //pasamosy llmamos la clasedomde se guarda
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
