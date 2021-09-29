// definir un widget si actualizo los datos de usurio esto se reconstruye

import 'package:app_comunic/app/ui/global_controllers/session_controller.dart';
import 'package:app_comunic/app/ui/global_controllers/theme_controller.dart';
import 'package:app_comunic/app/ui/globald_widgets/dialogs/dialogs.dart';
import 'package:app_comunic/app/ui/globald_widgets/dialogs/progress_dialogs.dart';
import 'package:app_comunic/app/ui/globald_widgets/dialogs/show_input_dialog.dart';
import 'package:app_comunic/app/ui/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:flutter_meedu/screen_utils.dart';

import 'package:flutter_meedu/router.dart' as router;

import 'widgedts/label_button.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({Key? key}) : super(key: key);

  void _updateDisplayName(BuildContext context) async {
    final SessionController = sessionProvider.read;
    final value = await showInputDialog(
      context,
      initialValue: SessionController.user!.displayName ?? "",
    );
    if (value != null) {
      //para que no demore
      ProgressDialogs.swow(context);
      final user = await SessionController.updateDisplayName(value);
      if (user == null) {
        Navigator.pop(context);

        Dialogs.alert(
          context,
          title: "ERROR",
          content: "Chek your internet Connection",
        );
      }
    }
    //  print(" $value");
  }

  @override
  Widget build(BuildContext context, watch) {
    final sessionController = watch(sessionProvider);
    // escuche boton de cambio
    final isDark = context.isDarkMode;
    // final theme = watch(themeProvider);
    // definir tab para user
    final user = sessionController.user!;
    //m mostrar primer caracter de nombre en circle
    final displayName = user.displayName ?? '';
    final letter = displayName.isNotEmpty ? displayName[0] : "";

    // DEFINIR FOTO DE PERFIL
    return ListView(
      children: [
        const SizedBox(height: 20), //separacioon
        CircleAvatar(
          radius: 75,
          //pasar letra ydefinir color
          child: user.photoURL == null
              ? Text(
                  letter,
                  style: const TextStyle(fontSize: 65),
                )
              : null,
          backgroundImage:
              user.photoURL != null ? NetworkImage(user.photoURL!) : null,
        ),
        // separa la imgen del texto
        const SizedBox(height: 10),
        Center(
          child: Text(
            displayName, // para nombre
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(child: Text(user.email ?? '')), //center 2
        const SizedBox(height: 50),
        // const Text("user data"),
        LabelButton(
          label: "Display Name",
          value: displayName,
          onPressed: () => _updateDisplayName(context),
        ),
        LabelButton(
          label: "Email",
          value: user.email ?? '',
        ),

        LabelButton(
          label: "Email verified",
          value: user.emailVerified ? "YES" : "NO",
        ),
        // lamar boton para cambiar elmdo
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Dark Mode"),
              CupertinoSwitch(
                value: isDark,
                activeColor: isDark ? Colors.pinkAccent : Colors.blue,
                onChanged: (_) {
                  themeProvider.read.toggle();
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
        LabelButton(
          label: "Sign Out",
          value: "",
          onPressed: () async {
            await sessionProvider.read.signOut();
            // navegar
            router.pushNamedAndRemoveUntil(Routes.LOGIN);
          },
        ),
      ],
    );
  }
}

// es reutilizablle
