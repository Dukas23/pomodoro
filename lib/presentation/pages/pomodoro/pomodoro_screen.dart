import 'package:flutter/material.dart';
import 'package:pomodoro/domain/uses_cases/pomodoro_timer.dart';
import 'package:pomodoro/presentation/pages/pomodoro/widgets/circular_progress_with_contex.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro/domain/entities/pomodoro_phase.dart';

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  //   @override
  //   Widget build(BuildContext context) {
  //     final pomodoroTimer = context.watch<PomodoroTimer>();
  //     final maxSeconds = pomodoroTimer.currentType == PomodoroType.working ? 1500 : 300;
  //     final progressValue = pomodoroTimer.seconds / maxSeconds;
  //     final timerActions = context.read<PomodoroTimer>();

  //     return LayoutBuilder(
  //       builder: (context, constraints) {
  //         final screenWidth = constraints.maxWidth;
  //         final isWideScreen = screenWidth > 600;

  //         return GridView.count(
  //           crossAxisCount: isWideScreen ? 2 : 1,
  //           mainAxisSpacing: 20,
  //           crossAxisSpacing: 20,
  //           padding: const EdgeInsets.all(20),
  //           childAspectRatio: isWideScreen ? 1.2 : 1.8,
  //           children: [
  //             // Progress Circle
  //             Container(
  //               alignment: Alignment.center,
  //               child: CircularProgressWithContext(
  //                 value: 1.0 - progressValue,
  //                 strokeWidth: 15,
  //                 size: isWideScreen ? 280 : 220,
  //                 text: Text(
  //                   _formatTime(pomodoroTimer.seconds),
  //                   style: Theme.of(context).textTheme.displayLarge!.copyWith(
  //                     fontSize: isWideScreen ? 72 : 54,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //             ),

  //             // Controls Section
  //             Container(
  //               alignment: Alignment.center,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   // Phase Title
  //                   Text(
  //                     pomodoroTimer.currentType.toString().split('.').last.toUpperCase(),
  //                     style: Theme.of(context).textTheme.headlineSmall!.copyWith(
  //                       color: Theme.of(context).colorScheme.primary,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),

  //                   const SizedBox(height: 40),

  //                   // Control Buttons
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       IconButton(
  //                         iconSize: isWideScreen ? 60 : 50,
  //                         icon: Icon(
  //                           pomodoroTimer.isActive
  //                               ? Icons.pause_circle_filled
  //                               : Icons.play_circle_filled,
  //                         ),
  //                         onPressed: timerActions.toggle,
  //                         color: Theme.of(context).colorScheme.primary,
  //                       ),
  //                       const SizedBox(width: 40),
  //                       IconButton(
  //                         iconSize: isWideScreen ? 50 : 40,
  //                         icon: const Icon(Icons.skip_next_rounded),
  //                         onPressed: timerActions.nextState,
  //                         color: Theme.of(context).colorScheme.onSurface,
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    final pomodoroTimer = context.watch<PomodoroTimer>();
    final maxSeconds = pomodoroTimer.currentType == PomodoroType.working
        ? 1500
        : 300;
    final progressValue = pomodoroTimer.seconds / maxSeconds;
    final timerActions = context.read<PomodoroTimer>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isWideScreen = screenWidth > 600;

        // 1. Definimos el widget del Círculo de Progreso
        final progressCircle = Container(
          alignment: Alignment.center,
          padding: isWideScreen ? const EdgeInsets.only(right: 20) : null,
          child: CircularProgressWithContext(
            value: 1.0 - progressValue,
            strokeWidth: 15,
            size: isWideScreen ? 280 : 220,
            text: Text(
              _formatTime(pomodoroTimer.seconds),
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontSize: isWideScreen ? 72 : 54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );

        // 2. Definimos el widget de la Sección de Controles
        final controlsSection = Container(
          alignment: Alignment.center,
          padding: isWideScreen ? const EdgeInsets.only(left: 20) : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Phase Title
              Text(
                pomodoroTimer.currentType
                    .toString()
                    .split('.')
                    .last
                    .toUpperCase(),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 40),

              // Control Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: isWideScreen ? 60 : 50,
                    icon: Icon(
                      pomodoroTimer.isActive
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                    ),
                    onPressed: timerActions.toggle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 40),
                  IconButton(
                    iconSize: isWideScreen ? 50 : 40,
                    icon: const Icon(Icons.skip_next_rounded),
                    onPressed: timerActions.nextState,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ],
              ),
            ],
          ),
        );

        // 3. Aplicamos la lógica de layout condicional (la clave)
        if (isWideScreen) {
          // Layout de Escritorio (WideScreen): Fila y Centrado
          return Center(
            // Centra el contenido en el medio de la pantalla
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: progressCircle,
                  ), // Cada sección toma el 50% del espacio horizontal
                  Expanded(child: controlsSection),
                ],
              ),
            ),
          );
        } else {
          // Layout de Móvil (SmallScreen): Columna (como lo hacía GridView antes)
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                progressCircle, // En móvil no necesitan Expanded si quieres que se dimensionen automáticamente
                const SizedBox(height: 40), // Espacio entre elementos en móvil
                controlsSection,
              ],
            ),
          );
        }

        // Cierra la función builder y el LayoutBuilder correctamente
      },
    );
  }
}
