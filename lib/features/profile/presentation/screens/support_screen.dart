import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/info_policy_card.dart';
import '../../../../shared/widgets/profile_section_group.dart';
import '../../../../shared/widgets/section_header.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppScaffoldWrapper(
      title: l10n.supportTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: l10n.supportHeadline,
              subtitle: l10n.supportDescription,
            ),
            const AppGap.v(AppSpacing.lg),
            ProfileSectionGroup(
              title: l10n.supportEntryTitle,
              subtitle: l10n.supportEntrySubtitle,
              children: [
                InfoPolicyCard(
                  title: l10n.supportEntryChatTitle,
                  message: l10n.supportEntryChatMessage,
                  icon: Icons.chat_bubble_outline_rounded,
                ),
                InfoPolicyCard(
                  title: l10n.supportEntryPolicyTitle,
                  message: l10n.supportEntryPolicyMessage,
                  icon: Icons.policy_outlined,
                  onTap: () => context.go(AppRoutePaths.bookingPolicy),
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            ProfileSectionGroup(
              title: l10n.supportPoliciesTitle,
              subtitle: l10n.supportPoliciesSubtitle,
              children: [
                InfoPolicyCard(
                  title: l10n.policyPrivacyTitle,
                  message: l10n.supportPrivacySummary,
                  icon: Icons.privacy_tip_outlined,
                  onTap: () => context.go(AppRoutePaths.privacyPolicy),
                ),
                InfoPolicyCard(
                  title: l10n.policyTermsTitle,
                  message: l10n.supportTermsSummary,
                  icon: Icons.gavel_rounded,
                  onTap: () => context.go(AppRoutePaths.termsOfService),
                ),
                InfoPolicyCard(
                  title: l10n.policyCancellationTitle,
                  message: l10n.supportCancellationSummary,
                  icon: Icons.event_busy_outlined,
                  onTap: () => context.go(AppRoutePaths.cancellationPolicy),
                ),
                InfoPolicyCard(
                  title: l10n.policyBookingTitle,
                  message: l10n.supportBookingSummary,
                  icon: Icons.assignment_outlined,
                  onTap: () => context.go(AppRoutePaths.bookingPolicy),
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            ProfileSectionGroup(
              title: l10n.supportFaqTitle,
              subtitle: l10n.supportFaqSubtitle,
              children: [
                InfoPolicyCard(
                  title: l10n.supportFaqBookingTitle,
                  message: l10n.supportFaqBookingMessage,
                  icon: Icons.calendar_month_outlined,
                ),
                InfoPolicyCard(
                  title: l10n.supportFaqArtistTitle,
                  message: l10n.supportFaqArtistMessage,
                  icon: Icons.storefront_outlined,
                ),
                InfoPolicyCard(
                  title: l10n.supportFaqAccountTitle,
                  message: l10n.supportFaqAccountMessage,
                  icon: Icons.manage_accounts_outlined,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
