import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import 'app_card.dart';

class ProfileSectionGroup extends StatelessWidget {
  const ProfileSectionGroup({
    super.key,
    required this.title,
    this.subtitle,
    required this.children,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      tone: AppCardTone.muted,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          if (subtitle != null) ...[
            const AppGap.v(AppSpacing.xs),
            Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium),
          ],
          const AppGap.v(AppSpacing.sm),
          ...children.indexed.map((entry) {
            final index = entry.$1;
            final child = entry.$2;
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == children.length - 1 ? 0 : AppSpacing.xs,
              ),
              child: child,
            );
          }),
        ],
      ),
    );
  }
}
