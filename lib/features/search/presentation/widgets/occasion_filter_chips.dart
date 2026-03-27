import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';

class OccasionFilterChips extends StatelessWidget {
  const OccasionFilterChips({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
  });

  final List<String> options;
  final String? selectedValue;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final option = options[index];
          final isSelected = option == selectedValue;

          return ChoiceChip(
            label: Text(option),
            selected: isSelected,
            onSelected: (_) => onSelected(isSelected ? null : option),
            showCheckmark: false,
          );
        },
        separatorBuilder: (context, index) => const AppGap.h(AppSpacing.xs),
        itemCount: options.length,
      ),
    );
  }
}
