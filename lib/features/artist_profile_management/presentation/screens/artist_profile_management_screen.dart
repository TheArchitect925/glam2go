import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/profile_section_group.dart';
import '../../../artist_management/application/artist_management_providers.dart';

class ArtistProfileManagementScreen extends ConsumerStatefulWidget {
  const ArtistProfileManagementScreen({super.key});

  @override
  ConsumerState<ArtistProfileManagementScreen> createState() =>
      _ArtistProfileManagementScreenState();
}

class _ArtistProfileManagementScreenState
    extends ConsumerState<ArtistProfileManagementScreen> {
  late final TextEditingController _displayNameController;
  late final TextEditingController _bioController;
  late final TextEditingController _experienceController;
  late final TextEditingController _instagramController;
  late final TextEditingController _tiktokController;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    final draft = ref.read(artistManagementControllerProvider).profileDraft;
    _displayNameController = TextEditingController(text: draft.displayName);
    _bioController = TextEditingController(text: draft.bio);
    _experienceController = TextEditingController(
      text: draft.experienceSummary,
    );
    _instagramController = TextEditingController(text: draft.instagramHandle);
    _tiktokController = TextEditingController(text: draft.tiktokHandle);
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _bioController.dispose();
    _experienceController.dispose();
    _instagramController.dispose();
    _tiktokController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final draft = ref.watch(artistManagementControllerProvider).profileDraft;
    final controller = ref.read(artistManagementControllerProvider.notifier);
    final isSaving = ref
        .watch(artistManagementMutationKeysProvider)
        .contains('profile');

    return AppScaffoldWrapper(
      title: l10n.artistProfileManagementTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.artistProfileManagementHeadline,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const AppGap.v(AppSpacing.sm),
            Text(
              l10n.artistProfileManagementDescription,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const AppGap.v(AppSpacing.xl),
            TextField(
              controller: _displayNameController,
              decoration: InputDecoration(
                labelText: l10n.artistProfileDisplayNameField,
                errorText: _errorText,
              ),
            ),
            const AppGap.v(AppSpacing.md),
            TextField(
              controller: _bioController,
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: l10n.artistProfileBioField,
              ),
            ),
            const AppGap.v(AppSpacing.md),
            TextField(
              controller: _experienceController,
              decoration: InputDecoration(
                labelText: l10n.artistProfileExperienceField,
              ),
            ),
            const AppGap.v(AppSpacing.md),
            TextField(
              controller: _instagramController,
              decoration: InputDecoration(
                labelText: l10n.artistProfileInstagramField,
              ),
            ),
            const AppGap.v(AppSpacing.md),
            TextField(
              controller: _tiktokController,
              decoration: InputDecoration(
                labelText: l10n.artistProfileTikTokField,
              ),
            ),
            const AppGap.v(AppSpacing.xl),
            ProfileSectionGroup(
              title: l10n.artistProfileSpecialtiesTitle,
              children: [
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: draft.specialties
                      .map(
                        (item) => FilterChip(
                          label: Text(item.label),
                          selected: item.isSelected,
                          onSelected: (_) =>
                              controller.toggleSpecialty(item.label),
                        ),
                      )
                      .toList(growable: false),
                ),
              ],
            ),
            const AppGap.v(AppSpacing.xl),
            AppButton(
              label: isSaving
                  ? l10n.artistMutationSavingLabel
                  : l10n.artistProfileSaveCta,
              isEnabled: !isSaving,
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                final hasName = _displayNameController.text.trim().isNotEmpty;
                final hasBio = _bioController.text.trim().isNotEmpty;
                final hasSpecialty = draft.specialties.any(
                  (item) => item.isSelected,
                );
                setState(() {
                  _errorText = hasName && hasBio && hasSpecialty
                      ? null
                      : l10n.artistProfileValidationMessage;
                });
                if (_errorText != null) {
                  return;
                }

                final result = await controller.updateProfile(
                  displayName: _displayNameController.text,
                  bio: _bioController.text,
                  experienceSummary: _experienceController.text,
                  instagramHandle: _instagramController.text,
                  tiktokHandle: _tiktokController.text,
                );
                if (!mounted) {
                  return;
                }
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      result.isSuccess
                          ? l10n.artistProfileSavedMessage
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
