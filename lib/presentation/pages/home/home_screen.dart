import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:pomodoro/core/utils/screen_size_util.dart';
import 'package:pomodoro/core/theme/app_theme.dart';
import 'package:pomodoro/core/theme/theme_provider.dart';
import 'package:pomodoro/domain/entities/destination_entity.dart';
// NOTE: La lógica del temporizador se mantiene fuera de este widget de UI principal

class HomeScreen extends StatelessWidget {
  // El 'child' es la vista de la ruta actual (home, reports, settings) de GoRouter
  final Widget child;

  const HomeScreen({super.key, required this.child});

  // --- Lógica de Navegación ---
  // 1. Determina el índice de navegación basado en la ruta actual
  int _getCurrentIndex(BuildContext context) {
    // Usamos GoRouterState para obtener la ubicación actual
    final String location = GoRouterState.of(context).matchedLocation;

    // Encuentra el índice que coincide con la ruta en la lista de entidades
    final int index = appDestionation.indexWhere((d) => d.path == location);

    // Asegura que el índice siempre sea válido (por defecto 0)
    return index < 0 ? 0 : index;
  }

  // 2. Manejador para navegar usando GoRouter
  void _onNavigate(BuildContext context, int index) {
    final dest = appDestionation[index];
    context.go(dest.path);
  }

  // --- Widgets de Configuración ---
  Widget _buildColorSkinButton(BuildContext context) {
    return PopupMenuButton<Color>(
      icon: const Icon(Icons.color_lens),
      tooltip: 'Cambiar color principal',
      onSelected: (color) {
        Provider.of<ThemeProvider>(context, listen: false).setColorSkin(color);
      },
      itemBuilder: (context) => [
        for (final color in allowedColorSkins)
          PopupMenuItem<Color>(
            value: color,
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 24,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black12),
                  ),
                ),
                const SizedBox(width: 8),
                // Usar un nombre de color más amigable si es posible
                Text(color.toString().split('(')[0].replaceAll('Color', '')),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildThemeToggleButton(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return IconButton(
      icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
      onPressed: () {
        Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeUtil = ScreenSizeUtil(context);
    final currentIndex = _getCurrentIndex(context);

    // NOTA: Toda la lógica de PomodoroTimer (start, pause, nextState)
    // se ha eliminado del build para mantener la UI limpia.
    // Ahora solo se enfoca en el layout adaptable.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro'),
        actions: [
          _buildColorSkinButton(context),
          _buildThemeToggleButton(context),
        ],
      ),

      // PASO 2 & 3: MEDIR y RAMIFICAR el layout principal
      body: SafeArea(
        // BUENA PRÁCTICA: Envuelve el cuerpo en SafeArea
        child: Row(
          children: [
            // RAMIFICACIÓN 1: NavigationRail (Solo para Tablet/Desktop)
            if (!sizeUtil.isMobileLayout)
              NavigationRail(
                selectedIndex: currentIndex,
                onDestinationSelected: (idx) => _onNavigate(context, idx),
                labelType: NavigationRailLabelType.all,
                destinations: appDestionation
                    .map(
                      (d) => NavigationRailDestination(
                        icon: Icon(d.icon),
                        label: Text(d.title),
                      ),
                    )
                    .toList(),
              ),

            // Contenido Principal: Ocupa el espacio restante
            // Esto es lo que GoRouter está inyectando a través del ShellRoute
            Expanded(child: child),
          ],
        ),
      ),

      // RAMIFICACIÓN 2: NavigationBar (Solo para Mobile)
      bottomNavigationBar: sizeUtil.isMobileLayout
          ? NavigationBar(
              selectedIndex: currentIndex,
              onDestinationSelected: (idx) => _onNavigate(context, idx),
              destinations: appDestionation
                  .map(
                    (d) => NavigationDestination(
                      icon: Icon(d.icon),
                      label: d.title,
                    ),
                  )
                  .toList(),
            )
          : null, // Si no es móvil, no hay NavigationBar
    );
  }
}
