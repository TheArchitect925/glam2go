import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../domain/models/booking_models.dart';

class BookingPriceCard extends StatelessWidget {
  const BookingPriceCard({
    super.key,
    required this.title,
    required this.priceSummary,
    required this.subtotalLabel,
    required this.travelFeeLabel,
    required this.totalLabel,
  });

  final String title;
  final BookingPriceSummary priceSummary;
  final String subtotalLabel;
  final String travelFeeLabel;
  final String totalLabel;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      tone: AppCardTone.muted,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const AppGap.v(AppSpacing.md),
          _PriceLine(
            label: subtotalLabel,
            value: formatCurrency(priceSummary.subtotal),
          ),
          const AppGap.v(AppSpacing.xs),
          _PriceLine(
            label: travelFeeLabel,
            value: formatCurrency(priceSummary.travelFee),
          ),
          const Divider(height: 24),
          _PriceLine(
            label: totalLabel,
            value: formatCurrency(priceSummary.total),
            emphasize: true,
          ),
        ],
      ),
    );
  }
}

class _PriceLine extends StatelessWidget {
  const _PriceLine({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final String label;
  final String value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final style = emphasize
        ? Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: AppColors.primary)
        : Theme.of(context).textTheme.bodyMedium;

    return Row(
      children: [
        Expanded(child: Text(label, style: style)),
        Text(value, style: style),
      ],
    );
  }
}
