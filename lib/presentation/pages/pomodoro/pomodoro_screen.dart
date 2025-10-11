import 'package:flutter/material.dart';
import 'package:pomodoro/presentation/pages/pomodoro/widgets/circular_progress_with_contex.dart';
import 'package:provider/provider.dart';

// Asegúrate de que PomodoroTimer extienda ChangeNotifier y use notifyListeners()
import 'package:pomodoro/domain/entities/pomodoro_phase.dart';
import 'package:pomodoro/domain/uses_cases/pomodoro_timer.dart';

// ESTA ES LA VISTA DE CONTENIDO, LA QUE SE INYECTA EN EL SHELL (HomeScreen).
class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  // Helper para formatear el tiempo
  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    // 1. Escuchar el estado del temporizador a través de Provider
    // Usamos select para optimizar las reconstrucciones, solo escuchando los campos necesarios
    final pomodoroTimer = context.watch<PomodoroTimer>();

    // Determinar los segundos máximos para calcular el valor del progreso circular
    final maxSeconds = pomodoroTimer.currentType == PomodoroType.working
        ? 1500
        : 300;

    // El progreso es el tiempo restante / tiempo máximo
    final progressValue = pomodoroTimer.seconds / maxSeconds;

    // Obtener la lógica del use case sin escuchar cambios (para las llamadas a funciones)
    final timerActions = context.read<PomodoroTimer>();

    // La vista se centra y ocupa todo el espacio que le da el Shell (HomeScreen)
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 2. Indicador de Progreso Circular
          CircularProgressWithContex(
            value: 1.0 - progressValue, // El progreso desciende de 1.0 a 0.0
            strokeWidth: 15,
            size: 280,
            text: Text(
              _formatTime(pomodoroTimer.seconds),
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontSize: 72,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 40),

          // 3. Título de la Fase Actual
          Text(
            pomodoroTimer.currentType.toString().split('.').last.toUpperCase(),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 50),

          // 4. Botones de Control
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botón de Inicio/Pausa
              IconButton(
                iconSize: 60,
                icon: Icon(
                  pomodoroTimer.isActive
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                ),
                onPressed: timerActions.toggle, // Llama al use case
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 40),
              // Botón de Salto de Fase
              IconButton(
                iconSize: 50,
                icon: const Icon(Icons.skip_next_rounded),
                onPressed: timerActions.nextState, // Llama al use case
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
