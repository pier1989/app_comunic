import 'package:app_comunic/app/domain/repositories/authentication_repository.dart';
import 'package:app_comunic/app/ui/global_controllers/session_controller.dart';
import 'package:app_comunic/app/ui/pages/home/home_controller.dart';
import 'package:app_comunic/app/ui/pages/home/tabs/home/home_tab.dart';
import 'package:app_comunic/app/ui/pages/home/tabs/home/widgets/home_tab_bar.dart';
import 'package:app_comunic/app/ui/pages/home/tabs/profile/profile_tabs.dart';
import 'package:app_comunic/app/ui/pages/home/tabs/sidebar/sidebar.dart';
import 'package:app_comunic/app/ui/pages/home/tabs/sidebar/sidebar_tab.dart';
import 'package:app_comunic/app/ui/pages/navigation_drawer/widget/navigation_drawer_widget.dart';
import 'package:app_comunic/app/ui/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/meedu.dart';
// importar el modluo de rutas
import 'package:flutter_meedu/router.dart' as router;

final homeProvider = SimpleProvider(
  (_) => HomeController(),
);

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // PARTE DE DISEÑO
  Widget build(BuildContext context) {
    return ProviderListener<HomeController>(
      provider: homeProvider,
      builder: (_, controller) {
        return Scaffold(
          //   drawer: NavigationDrawerWidget(),

          //boton inferior DE PANTALLA PARA EL TAB de home
          bottomNavigationBar: HomeTabBar(),
          body: SafeArea(
            child: TabBarView(
              controller: controller.tabController,
              children: const [
                // llama  a los tabs
                HomeTab(),
                // SideBar(),
                // sideBarTab(),
                ProfileTab(),

                //SideBar(),
              ],
            ),
          ),
        );
      },
    );
  }
}
