import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.headlineMedium),
              if (subtitle != null) ...[
                const AppGap.v(AppSpacing.xs),
                Text(subtitle!, style: textTheme.bodyMedium),
              ],
            ],
          ),
        ),
        ...switch (trailing) {
          final trailingWidget? => [trailingWidget],
          null => const <Widget>[],
        },
      ],
    );
  }
}
