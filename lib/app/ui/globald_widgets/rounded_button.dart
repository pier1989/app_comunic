import 'package:flutter/material.dart';

class RoundedButtom extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const RoundedButtom({
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
          const TextStyle(
            fontSize: 18,
          ),
        ),
        elevation: MaterialStateProperty.all(7),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
