import 'dart:async';
import 'package:flutter/material.dart'; // Necesario para ChangeNotifier
import 'package:pomodoro/domain/entities/pomodoro_phase.dart';

// 1. Debe extender ChangeNotifier
class PomodoroTimer extends ChangeNotifier {
  PomodoroType currentType;
  int seconds;
  bool isActive;
  Timer? timer;

  PomodoroTimer({
    this.currentType = PomodoroType.working,
    this.seconds = 1500,
    this.isActive = false,
  });

  void start() {
    if (isActive) return;
    isActive = true;

    // 2. Crear el Timer que Notifica a cada tick
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds > 0) {
        seconds--;
        notifyListeners(); // <-- ¡CLAVE! Notificar a la UI a cada segundo
      }

      if (seconds == 0) {
        t.cancel();
        nextState();
        // nextState ya llama a notifyListeners
      }
    });

    notifyListeners(); // Notificar que isActive cambió de false a true
  }

  void pause() {
    if (!isActive) return;

    // 3. Cancelar el recurso
    timer?.cancel();
    isActive = false;
    timer = null;

    notifyListeners(); // Notificar que isActive cambió de true a false
  }

  void toggle() {
    if (isActive) {
      pause();
    } else {
      start();
    }
  }

  void nextState() {
    // Lógica de cambio de fase
    if (currentType == PomodoroType.working) {
      currentType = PomodoroType.shortBreak;
      seconds = 300;
    } else if (currentType == PomodoroType.shortBreak) {
      currentType = PomodoroType.working;
      seconds = 1500;
    }
    isActive = false;
    timer?.cancel();
    timer = null;

    notifyListeners(); // Notificar que el tipo y los segundos han cambiado
  }

  // 4. Implementación del Dispose (Limpieza de Recursos)
  // Este método se llama automáticamente cuando el Provider es destruido.
  @override
  void dispose() {
    timer?.cancel(); // Limpiar el Timer para evitar fugas de memoria
    super.dispose();
  }
}
