import 'package:flutter/material.dart';
// Importamos la utilidad de tamaño para la restricción de ancho máximo
import 'package:pomodoro/core/utils/screen_size_util.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos ScreenSizeUtil para decisiones de layout si es necesario
    final sizeUtil = ScreenSizeUtil(context);

    // Generamos datos de ejemplo para la grilla
    final List<String> reportItems = List.generate(
      15,
      (index) => 'Reporte ${index + 1}: Sesión Pomodoro',
    );

    // 1. Aplicamos la restricción de ancho máximo del contenido
    return Center(
      // Si es una pantalla grande, restringimos a un ancho máximo de 900.
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: sizeUtil.isLargeScreen ? 900 : double.infinity,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // 2. Usamos el GridView Unificado
          child: GridView.builder(
            itemCount: reportItems.length,
            // 3. El delegado clave para la adaptabilidad
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400.0, // Ancho deseado de cada ítem
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio:
                  4 / 1, // Relación ancho/alto para que se vea como una lista
            ),
            itemBuilder: (context, index) {
              return Card(
                elevation: 2,
                child: Center(
                  child: ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text(reportItems[index]),
                    subtitle: const Text('Completado el 2024-10-10'),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
