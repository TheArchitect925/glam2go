import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../domain/models/booking_models.dart';

class BookingTimeSlotPicker extends StatelessWidget {
  const BookingTimeSlotPicker({
    super.key,
    required this.slots,
    required this.selectedValue,
    required this.onSelected,
  });

  final List<BookingTimeSelection> slots;
  final BookingTimeSelection? selectedValue;
  final ValueChanged<BookingTimeSelection> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: slots
          .map((slot) {
            final selected = slot.time24h == selectedValue?.time24h;
            return ChoiceChip(
              label: Text(slot.label),
              selected: selected,
              showCheckmark: false,
              onSelected: (_) => onSelected(slot),
            );
          })
          .toList(growable: false),
    );
  }
}
