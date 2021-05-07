import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/app_states.dart';
import 'package:news_app/bloc/bottom_navbar_bloc.dart';
import 'package:news_app/bloc/events.dart';
import 'package:news_app/style/theme.dart' as Style;

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavBarBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var bottomState = BottomNavBarBloc.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              backgroundColor: Style.Colors.mainColor,
              centerTitle: true,
              title: Text(
                'NewsApp',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          body: SafeArea(
            child: bottomState.screens[bottomState.currentIndex],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 10)
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.grey.shade900,
                iconSize: 20,
                unselectedItemColor: Style.Colors.grey,
                unselectedFontSize: 9.5,
                selectedFontSize: 9.5,
                type: BottomNavigationBarType.fixed,
                fixedColor: Style.Colors.accentColor,
                currentIndex: bottomState.currentIndex,
                onTap: (index) {
                  if (index == 0) bottomState.add(NavBarItem.HOME);
                  if (index == 1) bottomState.add(NavBarItem.SOURCES);
                  if (index == 2) bottomState.add(NavBarItem.SEARCH);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(EvaIcons.homeOutline),
                      activeIcon: Icon(EvaIcons.home) ,label: 'Home'),
                    BottomNavigationBarItem(
                      icon: Icon(EvaIcons.gridOutline),
                      activeIcon: Icon(EvaIcons.grid),label: 'Sources'),
                  BottomNavigationBarItem(
                      icon: Icon(EvaIcons.searchOutline)
                      ,activeIcon: Icon(EvaIcons.search), label: 'Search'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
