import 'package:app_comunic/app/ui/pages/home/tabs/sidebar/sidebar.dart';
import 'package:flutter/material.dart';

import '../../home_pages.dart';

class sideBarTab extends StatelessWidget {
  const sideBarTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //llama al parea las dos paginas
          ///
          // SideBar(),
          SideBar(),
          //const HomePage(),
        ],
      ),
    );
  }
}
