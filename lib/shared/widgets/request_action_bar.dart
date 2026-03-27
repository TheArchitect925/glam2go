import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import 'app_button.dart';

class RequestActionBar extends StatelessWidget {
  const RequestActionBar({
    super.key,
    required this.acceptLabel,
    required this.declineLabel,
    required this.onAccept,
    required this.onDecline,
  });

  final String acceptLabel;
  final String declineLabel;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            label: declineLabel,
            onPressed: onDecline,
            tone: AppButtonTone.secondary,
          ),
        ),
        const AppGap.h(AppSpacing.sm),
        Expanded(
          child: AppButton(label: acceptLabel, onPressed: onAccept),
        ),
      ],
    );
  }
}
