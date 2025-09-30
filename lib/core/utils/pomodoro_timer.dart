import 'dart:async';
import 'package:pomodoro/features/pomodoro/models/pomodoro_type.dart';

class PomodoroTimer {
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
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds > 0) {
        seconds--;
      }
      if (seconds == 0) {
        nextState();
        t.cancel();
        isActive = false;
        timer = null;
      }
    });
  }

  void pause() {
    if (!isActive) return;
    timer?.cancel();
    isActive = false;
    timer = null;
  }

  void toggle() {
    if (isActive) {
      pause();
    } else {
      start();
    }
  }

  void nextState() {
    if (currentType == PomodoroType.working) {
      currentType = PomodoroType.shortBreak;
      seconds = 300;
    } else if (currentType == PomodoroType.shortBreak) {
      currentType = PomodoroType.working;
      seconds = 1500;
    }
    // Puedes agregar lógica para longBreak aquí
  }
}
