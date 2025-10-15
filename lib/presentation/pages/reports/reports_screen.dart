import 'package:flutter/material.dart';
import 'package:pomodoro/core/utils/screen_size_util.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeUtil = ScreenSizeUtil(context);
    final List<String> reportItems = List.generate(
      15,
      (index) => 'Reporte ${index + 1}: Sesión Pomodoro',
    );

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: sizeUtil.isLargeScreen ? 400.0 : 600.0,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: sizeUtil.isLargeScreen ? 4 / 1 : 3 / 1,
      ),
      padding: const EdgeInsets.all(16.0),
      itemCount: reportItems.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          child: GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: Text(reportItems[index]),
                subtitle: const Text('Completado el 2024-10-10'),
              ),
            ],
          ),
        );
      },
    );
  }
}