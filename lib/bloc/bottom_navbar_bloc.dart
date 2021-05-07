// import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/app_states.dart';
import 'package:news_app/screens/tabs/home_screen.dart';
import 'package:news_app/screens/tabs/search_screen.dart';
import 'package:news_app/screens/tabs/sources_screen.dart';
import 'events.dart';

class BottomNavBarBloc extends Bloc<NavBarItem, AppStates> {
  BottomNavBarBloc() : super(AppInitialState());

  int currentIndex = 0;
  List<Widget> screens = [
      HomeScreen(),
    SourcesScreen(),
    SearchScreen(),

  ];

  static BottomNavBarBloc get(context) => BlocProvider.of(context);

  @override
  Stream<AppStates> mapEventToState(NavBarItem event) async* {
    switch (event) {
      case NavBarItem.HOME:
        yield ShowHome();
        currentIndex = 0;
        break;
      case NavBarItem.SOURCES:
        currentIndex = 1;
        yield ShowSources();
        break;
      case NavBarItem.SEARCH:
        yield ShowSearch();
        currentIndex = 2;

        break;
    }
  }

//  final StreamController<NavBarItem> _navBarController =
//      StreamController<NavBarItem>.broadcast();
//  NavBarItem defaultItem = NavBarItem.HOME;
// Stream<NavBarItem> get itemStream => _navBarController.stream;
// void pickItem(int index){
//   switch(index){
//     case 0:
//       _navBarController.sink.add(NavBarItem.HOME);
//       break;
//     case 1:
//       _navBarController.sink.add(NavBarItem.SOURCES);
//       break;
//     case 2:
//       _navBarController.sink.add(NavBarItem.SEARCH);
//       break;
//   }
// }
// close(){
//   _navBarController?.close();
// }
}
