import 'package:flutter/material.dart';
import 'package:pomodoro/core/router/router.dart';
import 'package:pomodoro/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Pomodoro timer',
      theme: themeProvider.theme,
      routerConfig: router,
    );
  }
}
