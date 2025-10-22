import 'package:flutter/material.dart';
import 'package:pomodoro/core/utils/screen_size_util.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro/core/theme/theme_provider.dart';
import 'package:pomodoro/core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeUtil = ScreenSizeUtil(context);
    final themeProvider = context.watch<ThemeProvider>();

    return GridView.count(
      crossAxisCount: sizeUtil.isLargeScreen ? 2 : 1,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      padding: const EdgeInsets.all(20),
      childAspectRatio: sizeUtil.isLargeScreen ? 2 : 1.5,
      children: [
        // Theme Settings
        Card(
          child: GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 6,
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Text(
                'Apariencia',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SwitchListTile(
                title: const Text('Modo Oscuro'),
                value: themeProvider.isDarkMode,
                onChanged: (value) => themeProvider.setDarkMode(value),
              ),
              const Divider(),
              Text('Colores', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),

        // Color Selection
        Card(
          child: GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 1,
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ...allowedColorSkins.map(
                (color) => GestureDetector(
                  onTap: () => themeProvider.setColorSkin(color),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: themeProvider.colorSkin == color
                          ? Border.all(color: Colors.black, width: 3)
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
