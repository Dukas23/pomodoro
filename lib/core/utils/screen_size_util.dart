import 'package:flutter/material.dart';
import 'package:pomodoro/core/constants/adaptative_breakpoints.dart';

class ScreenSizeUtil {
  final BuildContext context;

  final double screenWidth;

  ScreenSizeUtil(this.context) : screenWidth = MediaQuery.sizeOf(context).width;

  bool get isMobileLayout => screenWidth < AdaptativeBreakpoints.compact;

  bool get isTabletLayout =>
      screenWidth >= AdaptativeBreakpoints.compact &&
      screenWidth < AdaptativeBreakpoints.expanded;

  // Lógica para el Contenido (cuántas columnas en el Grid)
  bool get isLargeScreen => screenWidth >= AdaptativeBreakpoints.expanded;
}
