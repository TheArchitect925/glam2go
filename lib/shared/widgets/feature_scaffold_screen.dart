import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import 'app_button.dart';
import 'app_card.dart';
import 'app_shell.dart';
import 'section_header.dart';

class FeatureScaffoldScreen extends StatelessWidget {
  const FeatureScaffoldScreen({
    super.key,
    required this.title,
    required this.headline,
    required this.description,
    required this.statusLabel,
    this.primaryActionLabel,
    this.onPrimaryAction,
  });

  final String title;
  final String headline;
  final String description;
  final String statusLabel;
  final String? primaryActionLabel;
  final VoidCallback? onPrimaryAction;

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWrapper(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: headline, subtitle: description),
          const AppGap.v(AppSpacing.xl),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusLabel,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                if (primaryActionLabel != null && onPrimaryAction != null) ...[
                  const AppGap.v(AppSpacing.lg),
                  AppButton(
                    label: primaryActionLabel!,
                    onPressed: onPrimaryAction,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
