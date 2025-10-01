import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro/features/pomodoro/promodor_screen.dart';
import 'package:pomodoro/core/theme/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pomodoro timer',
      theme: themeProvider.theme,
      home: const PomodoroScreen(),
    );
  }
}
