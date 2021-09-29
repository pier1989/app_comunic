// pagina que tenga tabs en la parte inferior

import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class HomeController extends SimpleNotifier {
  late TabController tabController;
  HomeController() {
    tabController = TabController(
      length: 2,
      vsync: NavigatorState(),
    );
  }

  //liberar home controler cuando se destruido
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
