import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/features/pomodoro/widgets/circular_progress_with_contex.dart';
import 'package:pomodoro/core/utils/pomodoro_timer.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro/core/theme/theme_provider.dart';

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
