import 'package:app_comunic/app/ui/utils/colors.dart';
import 'package:flutter/material.dart';

class RoundedButtomForm extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const RoundedButtomForm({
    //color: Colors.deepPurpleAccent,
    backgroundColor: primaryFormColor,
    Key? key,
    this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      //bpto redondeado
      style: ButtonStyle(
        //tamaño de texto dentro de vboton
        textStyle: MaterialStateProperty.all(
          // ackgr

          const TextStyle(
            // height: 45,

            fontSize: 18,
          ),
        ),
        elevation: MaterialStateProperty.all(7),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
