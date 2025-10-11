import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/core/router/app_routes.dart';
import 'package:pomodoro/presentation/pages/home/home_screen.dart';
import 'package:pomodoro/presentation/pages/reports/reports_screen.dart';
import 'package:pomodoro/presentation/pages/pomodoro/pomodoro_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.home,
  routes: <RouteBase>[
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return HomeScreen(child: child);
      },
      routes: <RouteBase>[
        // Home route (root) — required because initialLocation is AppRoutes.home ('/')
        GoRoute(
          path: AppRoutes.home,
          builder: (BuildContext context, GoRouterState state) {
            return PomodoroScreen();
          },
        ),

        GoRoute(
          path: AppRoutes.reports,
          builder: (BuildContext context, GoRouterState state) {
            return ReportsScreen();
          },
        ),

        GoRoute(
          path: AppRoutes.settings,
          builder: (BuildContext context, GoRouterState state) {
            return const Placeholder(child: Text("Settings view"));
          },
        ),
      ],
    ),
  ],
);
