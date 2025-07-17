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
  PomodoroType _currentPomodoroType = PomodoroType.working;
  int _seconds = 1500;
  bool _isActive = false;
  Timer? _timer;

  // Getters públicos para pruebas
  int get seconds => _seconds;
  bool get isActive => _isActive;
  PomodoroType get currentPomodoroType => _currentPomodoroType;
  void _toggleTimer() {
    setState(() {
      _isActive = !_isActive;
      if (_isActive) {
        _startTimer();
      } else {
        _timer?.cancel();
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer?.cancel();
          // Aquí: Reproducir sonido y mostrar notificación
          _handleTimerEnd(); // Agregamos una función para manejar el final del tiempo
        }
      });
    });
  }

  // Nueva función para manejar el final del tiempo según el tipo
  void _handleTimerEnd() {
    switch (_currentPomodoroType) {
      case PomodoroType.working:
        // Lógica cuando termina el tiempo de trabajo
        // Aquí podrías cambiar a shortBreak o longBreak según la lógica de tu app
        _currentPomodoroType = PomodoroType.shortBreak;
        _seconds = 300; // Tiempo para el descanso corto

        break;
      case PomodoroType.shortBreak:
        // Lógica cuando termina el descanso corto
        _currentPomodoroType = PomodoroType.working;
        _seconds = 1500; // Volver al tiempo de trabajo

        break;
      case PomodoroType.longBreak:
        // Lógica cuando termina el descanso largo
        _currentPomodoroType = PomodoroType.working;
        _seconds = 1500; // Volver al tiempo de trabajo

        break;
    }
    _isActive = false;
    _timer = null;
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
              _currentPomodoroType.name.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.w900),
            ),

            SizedBox(height: 20.0),

            CircularProgressWithContex(
              value: _seconds / 1500,
              text: Text(
                '${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              strokeWidth: 10.0,
              size: 300.0,
            ),

            SizedBox(height: 10.0),

            FloatingActionButton(
              onPressed: _toggleTimer,
              child: Icon(_isActive ? Icons.pause : Icons.play_arrow),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
