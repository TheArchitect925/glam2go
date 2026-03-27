import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';

class BookingSummaryCard extends StatelessWidget {
  const BookingSummaryCard({
    super.key,
    required this.title,
    required this.rows,
    this.trailing,
  });

  final String title;
  final List<BookingSummaryRowData> rows;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      tone: AppCardTone.muted,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ...switch (trailing) {
                final trailingWidget? => [trailingWidget],
                null => const <Widget>[],
              },
            ],
          ),
          const AppGap.v(AppSpacing.md),
          ...rows.indexed.map((entry) {
            final index = entry.$1;
            final row = entry.$2;
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == rows.length - 1 ? 0 : AppSpacing.md,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      row.label,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  const AppGap.h(AppSpacing.md),
                  Flexible(
                    child: Text(
                      row.value,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class BookingSummaryRowData {
  const BookingSummaryRowData({required this.label, required this.value});

  final String label;
  final String value;
}
