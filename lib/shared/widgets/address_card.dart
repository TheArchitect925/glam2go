import 'package:flutter/material.dart';

import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../features/profile/domain/models/account_models.dart';
import 'app_card.dart';
import 'app_tag.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.address,
    required this.defaultLabel,
    this.onTap,
  });

  final SavedAddress address;
  final String defaultLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.extraLarge),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    address.label,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                if (address.isDefault)
                  AppTag(label: defaultLabel, tone: AppTagTone.accent),
              ],
            ),
            const AppGap.v(AppSpacing.sm),
            Text(
              address.addressLine1,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (address.unitDetails.isNotEmpty) ...[
              const AppGap.v(AppSpacing.xxs),
              Text(
                address.unitDetails,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            const AppGap.v(AppSpacing.xxs),
            Text(
              address.cityArea,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (address.accessNotes.isNotEmpty) ...[
              const AppGap.v(AppSpacing.md),
              Text(
                address.accessNotes,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
