import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../search/application/discovery_providers.dart';
import '../../application/booking_flow_controller.dart';
import '../../domain/models/booking_models.dart';
import '../widgets/booking_step_header.dart';

class BookingDetailsScreen extends ConsumerStatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  ConsumerState<BookingDetailsScreen> createState() =>
      _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends ConsumerState<BookingDetailsScreen> {
  late final TextEditingController _notesController;
  late String _occasion;
  late int _partySize;

  @override
  void initState() {
    super.initState();
    final draft = ref.read(bookingFlowControllerProvider);
    _occasion = draft.eventDetails?.occasion ?? '';
    _partySize = draft.eventDetails?.partySize ?? 1;
    _notesController = TextEditingController(
      text: draft.eventDetails?.notes ?? '',
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final occasions =
        ref.watch(occasionOptionsProvider).valueOrNull ?? const [];
    final draft = ref.watch(bookingFlowControllerProvider);

    return AppScaffoldWrapper(
      title: l10n.bookingDetailsTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookingStepHeader(
              currentStep: BookingFlowStep.details,
              title: l10n.bookingDetailsHeadline,
              subtitle: l10n.bookingDetailsDescription,
            ),
            const AppGap.v(AppSpacing.xl),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.bookingOccasionField,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const AppGap.v(AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: occasions
                        .map((occasion) {
                          return ChoiceChip(
                            label: Text(occasion),
                            selected: _occasion == occasion,
                            showCheckmark: false,
                            onSelected: (_) =>
                                setState(() => _occasion = occasion),
                          );
                        })
                        .toList(growable: false),
                  ),
                  const AppGap.v(AppSpacing.xl),
                  Text(
                    l10n.bookingPartySizeField,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const AppGap.v(AppSpacing.sm),
                  Row(
                    children: [
                      IconButton(
                        onPressed: _partySize > 1
                            ? () => setState(() => _partySize--)
                            : null,
                        icon: const Icon(Icons.remove_circle_outline_rounded),
                      ),
                      Text(
                        l10n.bookingPartySizeValue(_partySize),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        onPressed: () => setState(() => _partySize++),
                        icon: const Icon(Icons.add_circle_outline_rounded),
                      ),
                    ],
                  ),
                  const AppGap.v(AppSpacing.xl),
                  TextField(
                    controller: _notesController,
                    minLines: 3,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: l10n.bookingNotesField,
                      hintText: l10n.bookingNotesHint,
                    ),
                  ),
                ],
              ),
            ),
            const AppGap.v(AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: l10n.bookingBackToService,
                    onPressed: () => context.go(AppRoutePaths.bookingStart),
                    tone: AppButtonTone.secondary,
                  ),
                ),
                const AppGap.h(AppSpacing.md),
                Expanded(
                  child: AppButton(
                    label: l10n.actionChooseDateTime,
                    onPressed: _occasion.isEmpty
                        ? null
                        : () {
                            ref
                                .read(bookingFlowControllerProvider.notifier)
                                .updateEventDetails(
                                  occasion: _occasion,
                                  partySize: _partySize,
                                  notes: _notesController.text,
                                );
                            ref
                                .read(bookingFlowControllerProvider.notifier)
                                .setStep(BookingFlowStep.date);
                            context.go(AppRoutePaths.bookingDate);
                          },
                  ),
                ),
              ],
            ),
            if (!draft.canContinueFromService) ...[
              const AppGap.v(AppSpacing.md),
              Text(
                l10n.bookingMissingServiceMessage,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
