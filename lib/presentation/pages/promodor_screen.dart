import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/core/theme/app_theme.dart';
import 'package:pomodoro/core/utils/screen_size_util.dart';
import 'package:pomodoro/core/theme/theme_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/domain/entities/destination_entity.dart';
import 'package:pomodoro/domain/uses_cases/pomodoro_timer.dart';
// ...existing code...
import 'package:provider/provider.dart';

class PomodoroScreen extends StatefulWidget {
  final Widget? child;

  const PomodoroScreen({super.key, this.child});

  @override
  PomodoroScreenState createState() => PomodoroScreenState();
}

class PomodoroScreenState extends State<PomodoroScreen> {
  late PomodoroTimer pomodoroTimer;

  @override
  void initState() {
    super.initState();
    pomodoroTimer = PomodoroTimer();
  }

  void toggleTimer() => setState(() {
    pomodoroTimer.toggle();
    // Actualizar la UI en cada tick
    pomodoroTimer.timer?.cancel();
    pomodoroTimer.timer = pomodoroTimer.isActive
        ? Timer.periodic(const Duration(seconds: 1), (t) {
            pomodoroTimer.seconds--;
            if (pomodoroTimer.seconds == 0) {
              pomodoroTimer.timer?.cancel();
              pomodoroTimer.nextState();
              setState(() {});
            } else {
              setState(() {});
            }
          })
        : null;
  });

  @override
  Widget build(BuildContext context) {
    final sizeUtil = ScreenSizeUtil(context);

    // Compute current index from the router location (use browser URL as a reliable source)
    final String currentLocation = Uri.base.path;
    int currentIndex = appDestionation.indexWhere(
      (d) => d.path == currentLocation,
    );
    if (currentIndex < 0) currentIndex = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro'),
        actions: [
          // Selector de colorSkin
          PopupMenuButton<Color>(
            icon: const Icon(Icons.color_lens),
            tooltip: 'Cambiar color principal',
            onSelected: (color) {
              Provider.of<ThemeProvider>(
                context,
                listen: false,
              ).setColorSkin(color);
            },
            itemBuilder: (context) => [
              for (final color in allowedColorSkins)
                PopupMenuItem<Color>(
                  value: color,
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 24,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black12),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        color.toString().split('(')[0].replaceAll('Color', ''),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          IconButton(
            icon: Icon(
              Provider.of<ThemeProvider>(context).isDarkMode
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      // Responsive layout: NavigationRail for tablet/desktop, NavigationBar for mobile
      body: SafeArea(
        child: Row(
          children: [
            if (!sizeUtil.isMobileLayout)
              NavigationRail(
                selectedIndex: currentIndex,
                onDestinationSelected: (idx) {
                  final dest = appDestionation[idx];
                  context.go(dest.path);
                },
                labelType: NavigationRailLabelType.all,
                destinations: appDestionation
                    .map(
                      (d) => NavigationRailDestination(
                        icon: Icon(d.icon),
                        label: Text(d.title),
                      ),
                    )
                    .toList(),
              ),

            // Main content area
            Expanded(child: widget.child ?? const SizedBox.shrink()),
          ],
        ),
      ),

      bottomNavigationBar: sizeUtil.isMobileLayout
          ? NavigationBar(
              selectedIndex: currentIndex,
              onDestinationSelected: (idx) {
                final dest = appDestionation[idx];
                context.go(dest.path);
              },
              destinations: appDestionation
                  .map(
                    (d) => NavigationDestination(
                      icon: Icon(d.icon),
                      label: d.title,
                    ),
                  )
                  .toList(),
            )
          : null,
    );
  }
}

//   @override
//   void dispose() {
//     pomodoroTimer.timer?.cancel();
//     super.dispose();
//   }
// }
