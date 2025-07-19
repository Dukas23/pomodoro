import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro/enums/pomodoro_type.dart';
import 'package:pomodoro/screens/promodor_screen.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/circular_progress_with_contex.dart';

void main() {
  group('PomodoroScreenState', () {
    late PomodoroScreenState pomodoroScreenState;

    setUp(() {
      pomodoroScreenState = PomodoroScreenState();
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
      expect(pomodoroScreenState.currentPomodoroType, PomodoroType.working);
      expect(pomodoroScreenState.seconds, 1500);
      expect(pomodoroScreenState.isActive, false);
    });

    test(
      'Al iniciar el temporizador, isActive cambia a verdadero y los segundos disminuyen',
      () async {
        pomodoroScreenState.toggleTimer();
        expect(pomodoroScreenState.isActive, true);
        // Esperar un breve momento para que los segundos disminuyan
        await Future.delayed(const Duration(milliseconds: 1100));
        expect(pomodoroScreenState.seconds, lessThan(1500));
        pomodoroScreenState
            .toggleTimer(); // Detener el temporizador para no interferir con otras pruebas
      },
    );

    test('Al pausar el temporizador, isActive cambia a falso', () {
      pomodoroScreenState.toggleTimer();
      pomodoroScreenState.toggleTimer();
      expect(pomodoroScreenState.isActive, false);
    });

    test(
      'Al finalizar el tiempo de trabajo, cambia a descanso corto',
      () async {
        pomodoroScreenState.getSeconds =
            1; // Establecer segundos a 1 para una prueba rápida
        pomodoroScreenState.startTimer();
        await Future.delayed(const Duration(milliseconds: 1100));
        expect(
          pomodoroScreenState.currentPomodoroType,
          PomodoroType.shortBreak,
        );
        expect(pomodoroScreenState.seconds, 300);
        expect(pomodoroScreenState.isActive, false);
        expect(pomodoroScreenState.timer, isNull);
      },
    );

    test(
      'Al finalizar el descanso corto, vuelve a tiempo de trabajo',
      () async {
        pomodoroScreenState.getCurrentPomodoroType = PomodoroType.shortBreak;
        pomodoroScreenState.getSeconds = 1;
        pomodoroScreenState.startTimer();
        await Future.delayed(const Duration(milliseconds: 1100));
        expect(pomodoroScreenState.currentPomodoroType, PomodoroType.working);
        expect(pomodoroScreenState.seconds, 1500);
        expect(pomodoroScreenState.isActive, false);
        expect(pomodoroScreenState.timer, isNull);
      },
    );

    // Puedes agregar más pruebas para el caso de longBreak si lo implementas.
  });
}
