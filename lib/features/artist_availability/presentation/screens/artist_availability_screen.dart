import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../artist_management/application/artist_management_providers.dart';
import '../../../artist_management/domain/models/artist_management_models.dart';
import '../widgets/availability_day_row.dart';

class ArtistAvailabilityScreen extends ConsumerWidget {
  const ArtistAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final days = ref.watch(
      artistManagementControllerProvider.select(
        (state) => state.availabilityDays,
      ),
    );
    final controller = ref.read(artistManagementControllerProvider.notifier);
    final mutationKeys = ref.watch(artistManagementMutationKeysProvider);

    return AppScaffoldWrapper(
      title: l10n.artistAvailabilityTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.artistAvailabilityHeadline,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const AppGap.v(AppSpacing.sm),
            Text(
              l10n.artistAvailabilityDescription,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const AppGap.v(AppSpacing.xl),
            ...days.map(
              (day) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: AvailabilityDayRow(
                  day: day,
                  availableLabel: l10n.artistAvailabilityAvailableLabel,
                  unavailableLabel: l10n.artistAvailabilityUnavailableLabel,
                  addWindowLabel: l10n.artistAvailabilityAddWindowCta,
                  isMutating: mutationKeys.contains(
                    'availability:${day.dayKey}',
                  ),
                  onToggle: (_) async {
                    final result = await controller.toggleAvailability(
                      day.dayKey,
                    );
                    if (!context.mounted || result.isSuccess) {
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          result.failureOrNull?.message ??
                              l10n.artistMutationFailedMessage,
                        ),
                      ),
                    );
                  },
                  onAddWindow: () => _showAvailabilityWindowEditor(
                    context,
                    controller: controller,
                    l10n: l10n,
                    dayKey: day.dayKey,
                  ),
                  onEditWindow: (window) => _showAvailabilityWindowEditor(
                    context,
                    controller: controller,
                    l10n: l10n,
                    dayKey: day.dayKey,
                    existing: window,
                  ),
                  onRemoveWindow: (window) async {
                    final result = await controller.removeAvailabilityWindow(
                      dayKey: day.dayKey,
                      windowId: window.id,
                    );
                    if (!context.mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          result.isSuccess
                              ? l10n.artistAvailabilitySavedMessage
                              : (result.failureOrNull?.message ??
                                    l10n.artistMutationFailedMessage),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showAvailabilityWindowEditor(
  BuildContext context, {
  required ArtistManagementController controller,
  required AppLocalizations l10n,
  required String dayKey,
  ArtistTimeWindow? existing,
}) async {
  final startController = TextEditingController(
    text: existing?.startLabel ?? '9:00 AM',
  );
  final endController = TextEditingController(
    text: existing?.endLabel ?? '2:00 PM',
  );
  String? errorText;
  var isSubmitting = false;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (sheetContext) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          Future<void> submit() async {
            final startLabel = startController.text.trim();
            final endLabel = endController.text.trim();
            if (startLabel.isEmpty || endLabel.isEmpty) {
              setModalState(() {
                errorText = l10n.artistAvailabilityValidationMessage;
              });
              return;
            }

            setModalState(() {
              isSubmitting = true;
            });
            final result = await controller.saveAvailabilityWindow(
              dayKey: dayKey,
              window: ArtistTimeWindow(
                id:
                    existing?.id ??
                    '${dayKey}_${DateTime.now().millisecondsSinceEpoch}',
                startLabel: startLabel,
                endLabel: endLabel,
              ),
            );
            setModalState(() {
              isSubmitting = false;
            });

            if (!context.mounted) {
              return;
            }
            if (result.isSuccess) {
              Navigator.of(sheetContext).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.artistAvailabilitySavedMessage)),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    existing == null
                        ? l10n.artistAvailabilityAddWindowCta
                        : l10n.artistAvailabilityEditWindowCta,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const AppGap.v(AppSpacing.md),
                  TextField(
                    controller: startController,
                    decoration: InputDecoration(
                      labelText: l10n.artistAvailabilityStartField,
                      errorText: errorText,
                    ),
                  ),
                  const AppGap.v(AppSpacing.md),
                  TextField(
                    controller: endController,
                    decoration: InputDecoration(
                      labelText: l10n.artistAvailabilityEndField,
                    ),
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
                              : l10n.artistAvailabilitySaveCta,
                          onPressed: isSubmitting ? null : submit,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
