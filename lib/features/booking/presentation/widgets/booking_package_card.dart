import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../shared/widgets/artist_package_card.dart';
import '../../../search/domain/models/discovery_models.dart';

class BookingPackageCard extends StatelessWidget {
  const BookingPackageCard({
    super.key,
    required this.artistPackage,
    required this.isSelected,
    required this.onTap,
  });

  final ArtistPackage artistPackage;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.extraLarge),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.transparent,
          width: 1.5,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.extraLarge),
        onTap: onTap,
        child: Stack(
          children: [
            ArtistPackageCard(artistPackage: artistPackage),
            Positioned(
              top: 16,
              right: 16,
              child: Icon(
                isSelected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_off_rounded,
                color: isSelected ? AppColors.primary : AppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
