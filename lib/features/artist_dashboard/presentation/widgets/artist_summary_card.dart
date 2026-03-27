import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';

class ArtistSummaryCard extends StatelessWidget {
  const ArtistSummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          const AppGap.v(AppSpacing.md),
          Text(value, style: Theme.of(context).textTheme.displayMedium),
          const AppGap.v(AppSpacing.xxs),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const AppGap.v(AppSpacing.xxs),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
