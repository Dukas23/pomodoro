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

List<DestinationEntity> appDestionation = [
  DestinationEntity(title: "Pomodoro", icon: Icons.home, path: AppRoutes.home),

  DestinationEntity(
    title: "Reports",
    icon: Icons.analytics,
    path: AppRoutes.reports,
  ),

  DestinationEntity(
    title: "Settings",
    icon: Icons.settings,
    path: AppRoutes.settings,
  ),
];
