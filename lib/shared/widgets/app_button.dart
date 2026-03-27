import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';

enum AppButtonTone { primary, secondary, text }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.tone = AppButtonTone.primary,
    this.icon,
    this.isEnabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonTone tone;
  final IconData? icon;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18),
          const AppGap.h(AppSpacing.xs),
        ],
        Flexible(child: Text(label, textAlign: TextAlign.center)),
      ],
    );

    final effectiveOnPressed = isEnabled ? onPressed : null;

    return switch (tone) {
      AppButtonTone.primary => FilledButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      AppButtonTone.secondary => OutlinedButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      AppButtonTone.text => TextButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
    };
  }
}
