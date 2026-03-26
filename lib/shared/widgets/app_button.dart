import 'package:flutter/material.dart';

enum AppButtonTone { primary, secondary, text }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.tone = AppButtonTone.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonTone tone;

  @override
  Widget build(BuildContext context) {
    return switch (tone) {
      AppButtonTone.primary => FilledButton(
        onPressed: onPressed,
        child: Text(label),
      ),
      AppButtonTone.secondary => OutlinedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
      AppButtonTone.text => TextButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    };
  }
}
