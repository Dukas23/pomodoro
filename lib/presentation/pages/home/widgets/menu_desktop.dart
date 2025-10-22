import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/domain/entities/destination_entity.dart';

class MyNavigationRail extends StatefulWidget {
  const MyNavigationRail({super.key});

  @override
  State<MyNavigationRail> createState() => _MyNavigationRailState();
}

class _MyNavigationRailState extends State<MyNavigationRail> {
  // 1. Variable para guardar el índice seleccionado
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      // 2. Asigna el índice seleccionado
      selectedIndex: _selectedIndex,

      // 3. Define qué hacer cuando se selecciona un destino
      onDestinationSelected: (int index) {
        // Actualiza el estado visual del Rail
        setState(() {
          _selectedIndex = index;
        });

        // 💡 Aquí manejas la navegación usando el path
        //    Obtienes el path del destino seleccionado
        final String routePath = appDestinations[index].path;
        _navigateTo(context, routePath);
      },

      // Opcional: Muestra siempre las etiquetas (títulos)
      labelType: NavigationRailLabelType.all,

      destinations: appDestinations.map((destination) {
        return NavigationRailDestination(
          icon: Icon(destination.icon),
          label: Text(destination.title),
        );
      }).toList(),
    );
  }

  void _navigateTo(BuildContext context, String route) {
    context.go(route);
  }
}
