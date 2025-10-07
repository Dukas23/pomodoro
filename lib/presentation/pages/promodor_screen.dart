import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/core/theme/app_theme.dart';
import 'package:pomodoro/core/theme/theme_provider.dart';
import 'package:pomodoro/core/utils/pomodoro_timer.dart';
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

  void toggleTimer() {
    setState(() {
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
  }

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pomodoroTimer.currentType.name.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 20.0),
            CircularProgressWithContex(
              value: pomodoroTimer.seconds / 1500,
              text: Text(
                '${(pomodoroTimer.seconds ~/ 60).toString().padLeft(2, '0')}:${(pomodoroTimer.seconds % 60).toString().padLeft(2, '0')}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              strokeWidth: 10.0,
              size: 300.0,
            ),
            const SizedBox(height: 10.0),
            FloatingActionButton(
              onPressed: toggleTimer,
              child: Icon(
                pomodoroTimer.isActive ? Icons.pause : Icons.play_arrow,
              ),
            ),
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
