import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../artist_management/domain/models/artist_management_models.dart';

class AvailabilityDayRow extends StatelessWidget {
  const AvailabilityDayRow({
    super.key,
    required this.day,
    required this.availableLabel,
    required this.unavailableLabel,
    required this.addWindowLabel,
    required this.onToggle,
    required this.onAddWindow,
    this.onEditWindow,
    this.onRemoveWindow,
    this.isMutating = false,
  });

  final ArtistAvailabilityDay day;
  final String availableLabel;
  final String unavailableLabel;
  final String addWindowLabel;
  final ValueChanged<bool> onToggle;
  final VoidCallback onAddWindow;
  final ValueChanged<ArtistTimeWindow>? onEditWindow;
  final ValueChanged<ArtistTimeWindow>? onRemoveWindow;
  final bool isMutating;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day.dayLabel,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const AppGap.v(AppSpacing.xxs),
                    Text(
                      day.isAvailable ? availableLabel : unavailableLabel,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Switch.adaptive(
                value: day.isAvailable,
                onChanged: isMutating ? null : onToggle,
              ),
            ],
          ),
          if (day.isAvailable) ...[
            const AppGap.v(AppSpacing.sm),
            ...day.windows.map(
              (window) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        window.summary,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    IconButton(
                      onPressed: isMutating || onEditWindow == null
                          ? null
                          : () => onEditWindow!(window),
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      onPressed: isMutating || onRemoveWindow == null
                          ? null
                          : () => onRemoveWindow!(window),
                      icon: const Icon(Icons.delete_outline_rounded),
                    ),
                  ],
                ),
              ),
            ),
            AppButton(
              label: addWindowLabel,
              onPressed: isMutating ? null : onAddWindow,
              tone: AppButtonTone.secondary,
            ),
          ],
        ],
      ),
    );
  }
}
