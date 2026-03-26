import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import 'app_button.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.inbox_rounded, size: 40),
          const AppGap.v(AppSpacing.md),
          Text(title, style: textTheme.titleLarge, textAlign: TextAlign.center),
          const AppGap.v(AppSpacing.xs),
          Text(
            message,
            style: textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (actionLabel != null && onAction != null) ...[
            const AppGap.v(AppSpacing.lg),
            AppButton(label: actionLabel!, onPressed: onAction),
          ],
        ],
      ),
    );
  }
}
