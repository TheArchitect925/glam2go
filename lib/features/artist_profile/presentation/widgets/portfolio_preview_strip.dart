import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../search/domain/models/discovery_models.dart';

class PortfolioPreviewStrip extends StatelessWidget {
  const PortfolioPreviewStrip({super.key, required this.items});

  final List<PortfolioItem> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 156,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = items[index];

          return SizedBox(
            width: 150,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.large),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [item.startColor, item.endColor],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      item.title,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: AppColors.white),
                    ),
                    const AppGap.v(AppSpacing.xxs),
                    Text(
                      item.styleLabel,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.white.withValues(alpha: 0.88),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const AppGap.h(AppSpacing.md),
        itemCount: items.length,
      ),
    );
  }
}
