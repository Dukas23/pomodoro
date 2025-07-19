import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/enums/pomodoro_type.dart';
import 'package:pomodoro/widgets/circular_progress_with_contex.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  PomodoroScreenState createState() => PomodoroScreenState();
}

class PomodoroScreenState extends State<PomodoroScreen> {
  PomodoroType getCurrentPomodoroType = PomodoroType.working;
  int getSeconds = 1500;
  bool _isActive = false;
  Timer? timer;

  // Getters públicos para pruebas
  int get seconds => getSeconds;
  bool get isActive => _isActive;
  PomodoroType get currentPomodoroType => getCurrentPomodoroType;
  void toggleTimer() {
    setState(() {
      _isActive = !_isActive;
      if (_isActive) {
        startTimer();
      } else {
        timer?.cancel();
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (getSeconds > 0) {
          getSeconds--;
        } else {
          timer.cancel();
          // Aquí: Reproducir sonido y mostrar notificación
          _handleTimerEnd(); // Agregamos una función para manejar el final del tiempo
        }
      });
    });
  }

  // Nueva función para manejar el final del tiempo según el tipo
  void _handleTimerEnd() {
    switch (getCurrentPomodoroType) {
      case PomodoroType.working:
        // Lógica cuando termina el tiempo de trabajo
        // Aquí podrías cambiar a shortBreak o longBreak según la lógica de tu app
        getCurrentPomodoroType = PomodoroType.shortBreak;
        getSeconds = 300; // Tiempo para el descanso corto

        break;
      case PomodoroType.shortBreak:
        // Lógica cuando termina el descanso corto
        getCurrentPomodoroType = PomodoroType.working;
        getSeconds = 1500; // Volver al tiempo de trabajo

        break;
      case PomodoroType.longBreak:
        // Lógica cuando termina el descanso largo
        getCurrentPomodoroType = PomodoroType.working;
        getSeconds = 1500; // Volver al tiempo de trabajo

        break;
    }
    _isActive = false;
    timer = null;
    // Iniciar el nuevo ciclo automáticamente si lo deseas
    // _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              getCurrentPomodoroType.name.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.w900),
            ),

            SizedBox(height: 20.0),

            CircularProgressWithContex(
              value: getSeconds / 1500,
              text: Text(
                '${(getSeconds ~/ 60).toString().padLeft(2, '0')}:${(getSeconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              strokeWidth: 10.0,
              size: 300.0,
            ),

            SizedBox(height: 10.0),

            FloatingActionButton(
              onPressed: toggleTimer,
              child: Icon(_isActive ? Icons.pause : Icons.play_arrow),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
