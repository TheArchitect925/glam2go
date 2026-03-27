import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import 'app_button.dart';
import 'app_card.dart';

class ProtectedFeatureGate extends StatelessWidget {
  const ProtectedFeatureGate({
    super.key,
    required this.title,
    required this.message,
    required this.primaryLabel,
    required this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
  });

  final String title;
  final String message;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const AppGap.v(AppSpacing.sm),
            Text(message, style: Theme.of(context).textTheme.bodyLarge),
            const AppGap.v(AppSpacing.lg),
            AppButton(label: primaryLabel, onPressed: onPrimary),
            if (secondaryLabel != null && onSecondary != null) ...[
              const AppGap.v(AppSpacing.sm),
              AppButton(
                label: secondaryLabel!,
                onPressed: onSecondary,
                tone: AppButtonTone.secondary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

Future<void> showProtectedActionPrompt({
  required BuildContext context,
  required String title,
  required String message,
  required String primaryLabel,
  required VoidCallback onPrimary,
  String? secondaryLabel,
  VoidCallback? onSecondary,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (sheetContext) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: ProtectedFeatureGate(
            title: title,
            message: message,
            primaryLabel: primaryLabel,
            onPrimary: () {
              Navigator.of(sheetContext).pop();
              onPrimary();
            },
            secondaryLabel: secondaryLabel,
            onSecondary: onSecondary == null
                ? null
                : () {
                    Navigator.of(sheetContext).pop();
                    onSecondary();
                  },
          ),
        ),
      );
    },
  );
}
