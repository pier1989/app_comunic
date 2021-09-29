import 'package:app_comunic/app/ui/global_controllers/session_controller.dart';
import 'package:app_comunic/app/ui/pages/home/tabs/profile/profile_tabs.dart';
import 'package:app_comunic/app/ui/pages/home/tabs/sidebar/sidebar.dart';
import 'package:app_comunic/app/ui/pages/navigation_drawer/controler/item_image_menu.dart';
import 'package:app_comunic/app/ui/pages/navigation_drawer/widget/navigation_drawer_widget.dart';
import 'package:app_comunic/app/ui/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_svg/flutter_svg.dart';

import '../../home_pages.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      drawer: NavigationDrawerWidget(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/images/dark/fondis.jpg"), // <-- BACKGROUND IMAGE
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            //llama al parea las dos paginas
            //const HomePage(),
            // SideBar(),
            //const HomePage(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Menu Principal",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.amber),
              ),
            ),
            const SizedBox(height: 50),
            item_card(),
          ],
        ),
      ),
    );
  }
}

class item_card extends StatelessWidget {
  //final AccesMenu accesMenu;
  //final Function press,
  const item_card({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 180,
              width: 160,
              decoration: BoxDecoration(
                color: accesMenu[0].color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(accesMenu[0].image),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
            ),
            Container(
              height: 180,
              width: 160,
              decoration: BoxDecoration(
                color: accesMenu[1].color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(accesMenu[1].image),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 180,
              width: 160,
              decoration: BoxDecoration(
                color: accesMenu[2].color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(accesMenu[2].image),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
            ),
            Container(
              height: 180,
              width: 160,
              decoration: BoxDecoration(
                color: accesMenu[3].color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(accesMenu[3].image),
            ),
          ],
        ),
      ],
    );
  }
}
