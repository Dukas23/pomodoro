import 'package:flutter/material.dart';
import 'package:pomodoro/core/utils/screen_size_util.dart';
import 'package:pomodoro/domain/entities/destination_entity.dart';
import 'package:pomodoro/presentation/pages/home/widgets/Menu_mobile.dart';
import 'package:pomodoro/presentation/pages/home/widgets/menu_desktop.dart';

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

    // Para pantallas grandes, usamos un Row para el sidebar + contenido
    if (sizeUtil.isLargeScreen) {
      return Scaffold(
        body: Row(
          children: [
            // 1. Sidebar Navigation (Ancho fijo o Flexible/Expanded)
            SizedBox(
              width: 100, // <-- Define un ancho fijo para el sidebar
              child: MyNavigationRail(),
            ),
            const VerticalDivider(thickness: 1, width: 1),

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
        bottomNavigationBar: MenuMobile(),
        body: SafeArea(
          // Ya no necesitamos GridView.count(crossAxisCount: 1) aquí,
          // el child (el PomodoroScreen, etc.) es el contenido principal
          child: child,
        ),
      );
    }
  }
}
