import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/presentation/pages/home/home_screen.dart';

class MenuMobile extends StatelessWidget {
  final String? currentRoute;

  const MenuMobile({super.key, this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: appDestination.map((destination) {
        return BottomNavigationBarItem(
          icon: Icon(destination.icon),
          label: destination.title,
        );
      }).toList(),
      currentIndex: _getCurrentIndex(currentRoute),
      onTap: (index) => _onNavItemTapped(context, index),
    );
  }

  int _getCurrentIndex(String? currentRoute) {
    for (int i = 0; i < appDestination.length; i++) {
      if (appDestination[i].path == currentRoute) {
        return i;
      }
    }
    return 0;
  }

  void _onNavItemTapped(BuildContext context, int index) {
    _navigateTo(context, appDestination[index].path);
  }

  void _navigateTo(BuildContext context, String route) {
    context.go(route);
  }
}
