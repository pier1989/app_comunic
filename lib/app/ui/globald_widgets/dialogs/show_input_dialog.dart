import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/screen_utils.dart';

Future<String?> showInputDialog(
  BuildContext context, {
  String? title,
  // que tenga el valor actual enla caja de texto
  String? initialValue,
}) async {
  String value = initialValue ?? '';
  //TextEditingController controller = TextEditingController();
  //controller.text = value;
  final isdarkMode = context.isDarkMode;

  final result = await showCupertinoDialog<String>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: title != null ? Text(title) : null,
            content: CupertinoTextField(
              controller: TextEditingController()..text = initialValue ?? '',
              // cambiar color de texto
              style:
                  TextStyle(color: isdarkMode ? Colors.white : Colors.black87),
              //modificar cuadro de texo de dialog para editar nmbre
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: isdarkMode ? const Color(0xff37474f) : Colors.black12,
              ),
              onChanged: (text) {
                value = text;
              },
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  //llamara navigator minimizar dialog
                  Navigator.pop(context, value);
                },
                child: const Text("SAVE"),
                isDefaultAction: true,
              ),
              CupertinoDialogAction(
                onPressed: () {
                  //llamara navigator minimizar dialog
                  Navigator.pop(context);
                },
                child: const Text("CANCEL"),
                isDestructiveAction: true,
              )
            ],
          ));

  //controller.dispose();

  // validar que no acepte nulop
  if (result != null && result.trim().isEmpty) {
    return null;
  }
  return result;
}
