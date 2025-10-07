import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro/domain/entities/pomodoro_type.dart';
import 'package:pomodoro/presentation/pages/promodor_screen.dart';
import 'package:pomodoro/core/utils/pomodoro_timer.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/presentation/widgets/circular_progress_with_contex.dart';

void main() {
  group('PomodoroTimer', () {
    late PomodoroTimer pomodoroTimer;

    setUp(() {
      pomodoroTimer = PomodoroTimer();
    });

    group('PomodoroScreen Widget', () {
      testWidgets('Muestra el tipo de Pomodoro actual en mayúsculas', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(const MaterialApp(home: PomodoroScreen()));
        expect(find.text('WORKING'), findsOneWidget);
      });

      testWidgets('Muestra el tiempo inicial correctamente', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(const MaterialApp(home: PomodoroScreen()));
        expect(
          find.text('25:00'),
          findsOneWidget,
        ); // Tiempo inicial es 1500 segundos = 25 minutos
      });

      testWidgets('Al tocar el botón, el icono cambia', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(const MaterialApp(home: PomodoroScreen()));
        expect(find.byIcon(Icons.play_arrow), findsOneWidget);

        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump(); // Reconstruir el widget después de la interacción

        expect(find.byIcon(Icons.pause), findsOneWidget);

        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump();

        expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      });

      testWidgets('El CircularProgressIndicator se muestra', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(const MaterialApp(home: PomodoroScreen()));
        expect(find.byType(CircularProgressWithContex), findsOneWidget);
      });
    });

    //Unit test
    test('El estado inicial es trabajando con 1500 segundos e inactivo', () {
      expect(pomodoroTimer.currentType, PomodoroType.working);
      expect(pomodoroTimer.seconds, 1500);
      expect(pomodoroTimer.isActive, false);
    });

    test(
      'Al iniciar el temporizador, isActive cambia a verdadero y los segundos disminuyen',
      () async {
        pomodoroTimer.toggle();
        expect(pomodoroTimer.isActive, true);
        await Future.delayed(const Duration(milliseconds: 1100));
        expect(pomodoroTimer.seconds, lessThan(1500));
        pomodoroTimer
            .toggle(); // Detener el temporizador para no interferir con otras pruebas
      },
    );

    test('Al pausar el temporizador, isActive cambia a falso', () {
      pomodoroTimer.toggle();
      pomodoroTimer.toggle();
      expect(pomodoroTimer.isActive, false);
    });

    test(
      'Al finalizar el tiempo de trabajo, cambia a descanso corto',
      () async {
        pomodoroTimer.seconds =
            1; // Establecer segundos a 1 para una prueba rápida
        pomodoroTimer.start();
        await Future.delayed(const Duration(milliseconds: 1100));
        expect(pomodoroTimer.currentType, PomodoroType.shortBreak);
        expect(pomodoroTimer.seconds, 300);
        expect(pomodoroTimer.isActive, false);
        expect(pomodoroTimer.timer, isNull);
      },
    );

    test(
      'Al finalizar el descanso corto, vuelve a tiempo de trabajo',
      () async {
        pomodoroTimer.currentType = PomodoroType.shortBreak;
        pomodoroTimer.seconds = 1;
        pomodoroTimer.start();
        await Future.delayed(const Duration(milliseconds: 1100));
        expect(pomodoroTimer.currentType, PomodoroType.working);
        expect(pomodoroTimer.seconds, 1500);
        expect(pomodoroTimer.isActive, false);
        expect(pomodoroTimer.timer, isNull);
      },
    );

    // Puedes agregar más pruebas para el caso de longBreak si lo implementas.
  });
}
