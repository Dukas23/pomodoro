import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/core/utils/screen_size_util.dart';
import 'package:pomodoro/domain/entities/destination_entity.dart';
import 'package:pomodoro/presentation/pages/home/widgets/Menu_mobile.dart';

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

    // Para pantallas grandes, usamos un Row para el sidebar + contenido
    if (sizeUtil.isLargeScreen) {
      return Scaffold(
        body: Row(
          // <-- Usamos Row para el diseño horizontal
          children: [
            // 1. Sidebar Navigation (Ancho fijo o Flexible/Expanded)
            SizedBox(
              width: 250, // <-- Define un ancho fijo para el sidebar
              child: _buildDesktopSidebar(context, currentRoute),
            ),

            // 2. Main Content Area (Ocupa el resto del espacio disponible)
            Expanded(
              // <-- Usa Expanded para que ocupe el espacio restante
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: child,
              ),
            ),
          ],
        ),
      );
    } else {
      // Para mobile/tablet, mantenemos el Scaffold con bottom nav
      return Scaffold(
        // Remueve el AppBar() si quieres el diseño de la imagen
        // appBar: AppBar(),
        bottomNavigationBar: MenuMobile(currentRoute: currentRoute),
        body: SafeArea(
          // Ya no necesitamos GridView.count(crossAxisCount: 1) aquí,
          // el child (el PomodoroScreen, etc.) es el contenido principal
          child: child,
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
