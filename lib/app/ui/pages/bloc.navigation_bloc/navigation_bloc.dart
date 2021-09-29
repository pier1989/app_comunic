import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyAccountClickedEvent,
  MyOrdersClickedEvent,
}

abstract class NavigationStates {}

mixin NavigationBloc implements Bloc<NavigationEvents, NavigationStates> {
  @override
  //NavigationStates get initialState => MyAccountsPage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        //  yield HomePage();
        break;
      case NavigationEvents.MyAccountClickedEvent:
        //   yield MyAccountsPage();
        break;
      case NavigationEvents.MyOrdersClickedEvent:
        //yield MyOrdersPage();
        break;
    }
  }
}
