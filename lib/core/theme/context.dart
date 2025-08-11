import 'package:flutter/material.dart';

extension DarkModeExtension on BuildContext {
  bool get isDark {
    return Theme.of(this).brightness == Brightness.dark;
  }
}
