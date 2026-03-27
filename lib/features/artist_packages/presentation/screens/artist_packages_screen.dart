import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/artist_package_card.dart';
import '../../../artist_management/application/artist_management_providers.dart';
import '../../../artist_management/domain/models/artist_management_models.dart';
import '../../../search/domain/models/discovery_models.dart';

class ArtistPackagesScreen extends ConsumerWidget {
  const ArtistPackagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final packages = ref.watch(
      artistManagementControllerProvider.select((state) => state.packages),
    );
    final controller = ref.read(artistManagementControllerProvider.notifier);
    final mutationKeys = ref.watch(artistManagementMutationKeysProvider);

    return AppScaffoldWrapper(
      title: l10n.artistPackagesTitle,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showPackageEditor(
          context,
          ref,
          controller: controller,
          l10n: l10n,
        ),
        label: Text(l10n.artistPackagesAddCta),
        icon: const Icon(Icons.add_rounded),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.artistPackagesHeadline,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const AppGap.v(AppSpacing.sm),
            Text(
              l10n.artistPackagesDescription,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const AppGap.v(AppSpacing.xl),
            ...packages.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Column(
                  children: [
                    ArtistPackageCard(artistPackage: item.toArtistPackage()),
                    const AppGap.v(AppSpacing.sm),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            label: l10n.artistPackagesEditCta,
                            onPressed: mutationKeys.contains(item.id)
                                ? null
                                : () => _showPackageEditor(
                                    context,
                                    ref,
                                    controller: controller,
                                    existing: item,
                                    l10n: l10n,
                                  ),
                            tone: AppButtonTone.secondary,
                          ),
                        ),
                        const AppGap.h(AppSpacing.md),
                        Expanded(
                          child: AppButton(
                            label: mutationKeys.contains(item.id)
                                ? l10n.artistMutationSavingLabel
                                : item.isActive
                                ? l10n.artistPackagesDeactivateCta
                                : l10n.artistPackagesActivateCta,
                            onPressed: mutationKeys.contains(item.id)
                                ? null
                                : () async {
                                    final result = await controller
                                        .togglePackageActive(item.id);
                                    if (!context.mounted) {
                                      return;
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          result.isSuccess
                                              ? l10n.artistPackagesSavedMessage
                                              : (result
                                                        .failureOrNull
                                                        ?.message ??
                                                    l10n.artistMutationFailedMessage),
                                        ),
                                      ),
                                    );
                                  },
                            tone: AppButtonTone.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showPackageEditor(
  BuildContext context,
  WidgetRef ref, {
  required ArtistManagementController controller,
  required AppLocalizations l10n,
  ArtistServicePackageDraft? existing,
}) async {
  final titleController = TextEditingController(text: existing?.title ?? '');
  final descriptionController = TextEditingController(
    text: existing?.description ?? '',
  );
  final priceController = TextEditingController(
    text: existing == null ? '' : '${existing.price}',
  );
  final durationController = TextEditingController(
    text: existing == null ? '' : '${existing.durationMinutes}',
  );
  final includesController = TextEditingController(
    text: existing?.includes.join(', ') ?? '',
  );
  final occasionsController = TextEditingController(
    text: existing?.suitableOccasions.join(', ') ?? '',
  );
  var isActive = existing?.isActive ?? false;
  String? errorText;
  var isSubmitting = false;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (sheetContext) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          Future<void> submit() async {
            final title = titleController.text.trim();
            final description = descriptionController.text.trim();
            final price = int.tryParse(priceController.text.trim()) ?? 0;
            final duration = int.tryParse(durationController.text.trim()) ?? 0;
            final includes = includesController.text
                .split(',')
                .map((item) => item.trim())
                .where((item) => item.isNotEmpty)
                .toList(growable: false);
            final occasions = occasionsController.text
                .split(',')
                .map((item) => item.trim())
                .where((item) => item.isNotEmpty)
                .toList(growable: false);

            if (title.isEmpty ||
                description.isEmpty ||
                price <= 0 ||
                duration <= 0 ||
                includes.isEmpty ||
                occasions.isEmpty) {
              setModalState(() {
                errorText = l10n.artistPackageValidationMessage;
              });
              return;
            }

            final package = ArtistServicePackageDraft(
              id:
                  existing?.id ??
                  '__package_${DateTime.now().millisecondsSinceEpoch}',
              title: title,
              description: description,
              price: price,
              durationMinutes: duration,
              includes: includes,
              suitableOccasions: occasions,
              isActive: isActive,
            );

            setModalState(() {
              isSubmitting = true;
            });
            final result = await controller.savePackage(package);
            setModalState(() {
              isSubmitting = false;
            });

            if (!context.mounted) {
              return;
            }
            if (result.isSuccess) {
              Navigator.of(sheetContext).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.artistPackagesSavedMessage)),
              );
            } else {
              setModalState(() {
                errorText =
                    result.failureOrNull?.message ??
                    l10n.artistMutationFailedMessage;
              });
            }
          }

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                MediaQuery.of(sheetContext).viewInsets.bottom + AppSpacing.lg,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      existing == null
                          ? l10n.artistPackagesAddCta
                          : l10n.artistPackagesEditCta,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const AppGap.v(AppSpacing.md),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: l10n.artistPackageTitleField,
                        errorText: errorText,
                      ),
                    ),
                    const AppGap.v(AppSpacing.md),
                    TextField(
                      controller: descriptionController,
                      minLines: 3,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: l10n.artistPackageDescriptionField,
                      ),
                    ),
                    const AppGap.v(AppSpacing.md),
                    TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: l10n.artistPackagePriceField,
                      ),
                    ),
                    const AppGap.v(AppSpacing.md),
                    TextField(
                      controller: durationController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: l10n.artistPackageDurationField,
                      ),
                    ),
                    const AppGap.v(AppSpacing.md),
                    TextField(
                      controller: includesController,
                      decoration: InputDecoration(
                        labelText: l10n.artistPackageIncludesField,
                      ),
                    ),
                    const AppGap.v(AppSpacing.md),
                    TextField(
                      controller: occasionsController,
                      decoration: InputDecoration(
                        labelText: l10n.artistPackageOccasionsField,
                      ),
                    ),
                    const AppGap.v(AppSpacing.md),
                    SwitchListTile.adaptive(
                      value: isActive,
                      onChanged: isSubmitting
                          ? null
                          : (value) {
                              setModalState(() {
                                isActive = value;
                              });
                            },
                      title: Text(l10n.artistPackagesActiveField),
                    ),
                    const AppGap.v(AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            label: l10n.profileEditCancelCta,
                            onPressed: isSubmitting
                                ? null
                                : () => Navigator.of(sheetContext).pop(),
                            tone: AppButtonTone.secondary,
                          ),
                        ),
                        const AppGap.h(AppSpacing.md),
                        Expanded(
                          child: AppButton(
                            label: isSubmitting
                                ? l10n.artistMutationSavingLabel
                                : l10n.artistPackagesSaveCta,
                            onPressed: isSubmitting ? null : submit,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

extension on ArtistServicePackageDraft {
  ArtistPackage toArtistPackage() {
    return ArtistPackage(
      id: id,
      title: title,
      description: description,
      price: price,
      durationMinutes: durationMinutes,
      includes: includes,
      suitableFor: suitableOccasions,
      isFeatured: false,
    );
  }
}
