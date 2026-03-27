import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../artist_management/application/artist_management_providers.dart';

class ArtistServiceAreaScreen extends ConsumerStatefulWidget {
  const ArtistServiceAreaScreen({super.key});

  @override
  ConsumerState<ArtistServiceAreaScreen> createState() =>
      _ArtistServiceAreaScreenState();
}

class _ArtistServiceAreaScreenState
    extends ConsumerState<ArtistServiceAreaScreen> {
  late final TextEditingController _areaController;
  late final TextEditingController _includedRadiusController;
  late final TextEditingController _extraFeeController;
  late final TextEditingController _maxDistanceController;
  late final TextEditingController _notesController;
  String? _validationMessage;

  @override
  void initState() {
    super.initState();
    final policy = ref.read(artistManagementControllerProvider).travelPolicy;
    _areaController = TextEditingController(text: policy.primaryServiceArea);
    _includedRadiusController = TextEditingController(
      text: '${policy.includedRadiusKm}',
    );
    _extraFeeController = TextEditingController(
      text: '${policy.extraTravelFee}',
    );
    _maxDistanceController = TextEditingController(
      text: '${policy.maxTravelDistanceKm}',
    );
    _notesController = TextEditingController(text: policy.travelNotes);
  }

  @override
  void dispose() {
    _areaController.dispose();
    _includedRadiusController.dispose();
    _extraFeeController.dispose();
    _maxDistanceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final controller = ref.read(artistManagementControllerProvider.notifier);
    final isSaving = ref
        .watch(artistManagementMutationKeysProvider)
        .contains('travel');

    return AppScaffoldWrapper(
      title: l10n.artistTravelTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.artistTravelHeadline,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const AppGap.v(AppSpacing.sm),
            Text(
              l10n.artistTravelDescription,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const AppGap.v(AppSpacing.xl),
            TextField(
              controller: _areaController,
              decoration: InputDecoration(
                labelText: l10n.artistTravelAreaField,
                errorText: _validationMessage,
              ),
            ),
            const AppGap.v(AppSpacing.md),
            TextField(
              controller: _includedRadiusController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: l10n.artistTravelRadiusField,
              ),
            ),
            const AppGap.v(AppSpacing.md),
            TextField(
              controller: _extraFeeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: l10n.artistTravelFeeField),
            ),
            const AppGap.v(AppSpacing.md),
            TextField(
              controller: _maxDistanceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: l10n.artistTravelMaxDistanceField,
              ),
            ),
            const AppGap.v(AppSpacing.md),
            TextField(
              controller: _notesController,
              minLines: 3,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: l10n.artistTravelNotesField,
              ),
            ),
            const AppGap.v(AppSpacing.xl),
            AppButton(
              label: isSaving
                  ? l10n.artistMutationSavingLabel
                  : l10n.artistTravelSaveCta,
              isEnabled: !isSaving,
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                final includedRadius =
                    int.tryParse(_includedRadiusController.text) ?? 0;
                final extraTravelFee =
                    int.tryParse(_extraFeeController.text) ?? 0;
                final maxDistance =
                    int.tryParse(_maxDistanceController.text) ?? 0;
                setState(() {
                  _validationMessage =
                      _areaController.text.trim().isEmpty ||
                          includedRadius <= 0 ||
                          maxDistance <= 0
                      ? l10n.artistTravelValidationMessage
                      : null;
                });
                if (_validationMessage != null) {
                  return;
                }

                final result = await controller.updateTravelPolicy(
                  primaryServiceArea: _areaController.text,
                  includedRadiusKm: includedRadius,
                  extraTravelFee: extraTravelFee,
                  maxTravelDistanceKm: maxDistance,
                  travelNotes: _notesController.text,
                );
                if (!mounted) {
                  return;
                }
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      result.isSuccess
                          ? l10n.artistTravelSavedMessage
                          : (result.failureOrNull?.message ??
                                l10n.artistMutationFailedMessage),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
