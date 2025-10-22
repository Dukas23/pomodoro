// lib/domain/entities/destination_entity.dart
import 'package:flutter/material.dart';
import 'package:pomodoro/core/router/app_routes.dart';

class DestinationEntity {
  final String title;
  final IconData icon;
  final String path;

  DestinationEntity({
    required this.title,
    required this.icon,
    required this.path,
  });
}

// ⚠️ Usamos el nombre corregido y exportamos la lista.
final List<DestinationEntity> appDestinations = [
  DestinationEntity(
    title: "Pomodoro",
    icon: Icons.schedule,
    path: AppRoutes.home,
  ), // Icono más representativo
  DestinationEntity(
    title: "Settings",
    icon: Icons.settings,
    path: AppRoutes.settings,
  ),
];
