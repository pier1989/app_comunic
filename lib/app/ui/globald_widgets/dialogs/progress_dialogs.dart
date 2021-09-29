import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ProgressDialogs {
  static void swow(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (_) => WillPopScope(
        //pasar contexto para qno se puda minimizar
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black12,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
        onWillPop: () async => false, //paraque no se minimeze eldialogo
      ), // pasar contexto y no pueda minimizar ni regresa
    );
  }
}
