import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const AppGap.v(AppSpacing.md),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
