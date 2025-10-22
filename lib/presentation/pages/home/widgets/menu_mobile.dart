import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/domain/entities/destination_entity.dart';

class MenuMobile extends StatefulWidget {
  const MenuMobile({super.key});

  @override
  State<MenuMobile> createState() => _MenuMobileState();
}

class _MenuMobileState extends State<MenuMobile> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });

        final String routePath = appDestinations[index].path;
        _navigateTo(context, routePath);
      },
      selectedIndex: currentPageIndex,
      destinations: appDestinations.map((destination) {
        return NavigationDestination(
          icon: Icon(destination.icon),
          label: destination.title,
        );
      }).toList(),
    );
  }

  void _navigateTo(BuildContext context, String route) {
    context.go(route);
  }
}
