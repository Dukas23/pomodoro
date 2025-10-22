import 'package:flutter/material.dart';
import 'package:pomodoro/core/router/router.dart';
import 'package:pomodoro/core/theme/theme_provider.dart';
import 'package:pomodoro/domain/uses_cases/pomodoro_timer.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // 1. ThemeProvider (Ya estaba)
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        // 2. ¡EL TIMER QUE FALTABA!
        ChangeNotifierProvider(create: (_) => PomodoroTimer()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Pomodoro timer',
      theme: themeProvider.theme,
      routerConfig: router,
    );
  }
}
