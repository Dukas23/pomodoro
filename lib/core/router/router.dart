import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/core/router/app_routes.dart';
import 'package:pomodoro/presentation/pages/home/home_screen.dart';
import 'package:pomodoro/presentation/pages/reports/reports_screen.dart';
import 'package:pomodoro/presentation/pages/pomodoro/pomodoro_screen.dart';
import 'package:pomodoro/presentation/pages/settings/settings_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.home,
  routes: <RouteBase>[
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return HomeScreen(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(
              child: PomodoroScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.reports,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(
              child: ReportsScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.settings,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(
              child: SettingsScreen(),
            );
          },
        ),
      ],
    ),
  ],
);