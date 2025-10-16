import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/core/utils/screen_size_util.dart';
import 'package:pomodoro/domain/entities/destination_entity.dart';

// Define your app destinations here
final List<DestinationEntity> appDestination = [
  DestinationEntity(title: 'Home', icon: Icons.home, path: '/home'),
  DestinationEntity(title: 'Tasks', icon: Icons.list, path: '/tasks'),
  DestinationEntity(title: 'Settings', icon: Icons.settings, path: '/settings'),
];

class HomeScreen extends StatelessWidget {
  final Widget child;

  const HomeScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final sizeUtil = ScreenSizeUtil(context);
    final currentRoute = ModalRoute.of(context)?.settings.name;

    // Para pantallas grandes, usamos GridView con sidebar + contenido
    if (sizeUtil.isLargeScreen) {
      return Scaffold(
        body: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.3, // Sidebar más angosto
          children: [
            // Sidebar Navigation
            _buildDesktopSidebar(context, currentRoute),

            // Main Content Area
            Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: child,
            ),
          ],
        ),
      );
    } else {
      // Para mobile/tablet, GridView con contenido principal + bottom nav
      return Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: _buildMobileBottomNav(context, currentRoute),
        body: SafeArea(
          child: GridView.count(
            crossAxisCount: 1,
            children: [
              // Main Content
              child,
            ],
          ),
        ),
      );
    }
  }

  Widget _buildDesktopSidebar(BuildContext context, String? currentRoute) {
    return Container(
      width: 150,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: GridView.count(
        crossAxisCount: 1,
        childAspectRatio: 6, // Para items de navegación más altos
        padding: const EdgeInsets.all(16),
        children: [
          // Header
          ListTile(
            title: Text(
              'Pomodoro App',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),

          // Navigation Items
          ...appDestination.map(
            (destination) => _buildNavItem(context, destination, currentRoute),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileBottomNav(BuildContext context, String? currentRoute) {
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

  Widget _buildNavItem(
    BuildContext context,
    DestinationEntity destination,
    String? currentRoute,
  ) {
    return Card(
      elevation: currentRoute == destination.path ? 2 : 0,
      color: currentRoute == destination.path
          ? Theme.of(context).colorScheme.primary.withValues()
          : Colors.transparent,
      child: ListTile(
        leading: Icon(destination.icon),
        title: Text(destination.title),
        selected: currentRoute == destination.path,
        onTap: () => _navigateTo(context, destination.path),
      ),
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
