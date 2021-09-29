import 'package:app_comunic/app/ui/pages/home/home_pages.dart';
import 'package:app_comunic/app/ui/pages/home/tabs/sidebar/sidebar.dart';
import 'package:flutter/material.dart';

class SideBarLayout extends StatelessWidget {
  //const ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //  SideBar(),
          HomePage(),
        ],
      ),
    );
  }
}
