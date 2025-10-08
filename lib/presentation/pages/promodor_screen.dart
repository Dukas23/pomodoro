import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/core/theme/app_theme.dart';
import 'package:pomodoro/core/utils/responsive.dart';
import 'package:pomodoro/core/theme/theme_provider.dart';
import 'package:pomodoro/domain/uses_cases/pomodoro_timer.dart';
import 'package:pomodoro/presentation/widgets/circular_progress_with_contex.dart';
import 'package:provider/provider.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  PomodoroScreenState createState() => PomodoroScreenState();
}

class PomodoroScreenState extends State<PomodoroScreen> {
  late PomodoroTimer pomodoroTimer;

  @override
  void initState() {
    super.initState();
    pomodoroTimer = PomodoroTimer();
  }

  void toggleTimer() => setState(() {
    pomodoroTimer.toggle();
    // Actualizar la UI en cada tick
    pomodoroTimer.timer?.cancel();
    pomodoroTimer.timer = pomodoroTimer.isActive
        ? Timer.periodic(const Duration(seconds: 1), (t) {
            pomodoroTimer.seconds--;
            if (pomodoroTimer.seconds == 0) {
              pomodoroTimer.timer?.cancel();
              pomodoroTimer.nextState();
              setState(() {});
            } else {
              setState(() {});
            }
          })
        : null;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro'),
        actions: [
          // Selector de colorSkin
          PopupMenuButton<Color>(
            icon: const Icon(Icons.color_lens),
            tooltip: 'Cambiar color principal',
            onSelected: (color) {
              Provider.of<ThemeProvider>(
                context,
                listen: false,
              ).setColorSkin(color);
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
                      Text(
                        color.toString().split('(')[0].replaceAll('Color', ''),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          IconButton(
            icon: Icon(
              Provider.of<ThemeProvider>(context).isDarkMode
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      // body:
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: Text("a"),
              ),

            Expanded(flex: 5, child: Text("HOla")),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    pomodoroTimer.timer?.cancel();
    super.dispose();
  }
}
