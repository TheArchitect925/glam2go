import 'package:flutter/widgets.dart';

class AppSpacing {
  const AppSpacing._();

  static const xxs = 4.0;
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 20.0;
  static const xl = 24.0;
  static const xxl = 32.0;
  static const xxxl = 40.0;
  static const section = 48.0;
}

class AppGap extends SizedBox {
  const AppGap.v(double value, {super.key}) : super(height: value);

  const AppGap.h(double value, {super.key}) : super(width: value);
}
