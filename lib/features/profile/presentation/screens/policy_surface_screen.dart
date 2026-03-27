import 'package:flutter/material.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/profile_section_group.dart';
import '../../../../shared/widgets/section_header.dart';

enum PolicySurfaceType { privacy, terms, cancellation, booking }

class PolicySurfaceScreen extends StatelessWidget {
  const PolicySurfaceScreen({super.key, required this.surface});

  final PolicySurfaceType surface;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final content = _PolicySurfaceContent.fromType(surface, l10n);

    return AppScaffoldWrapper(
      title: content.title,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: content.headline,
              subtitle: content.description,
            ),
            const AppGap.v(AppSpacing.lg),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.policyDraftNoticeTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const AppGap.v(AppSpacing.xxs),
                  Text(
                    l10n.policyDraftNoticeMessage,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const AppGap.v(AppSpacing.lg),
            ...content.sections.map(
              (section) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: ProfileSectionGroup(
                  title: section.title,
                  children: [AppCard(child: Text(section.body))],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PolicySurfaceContent {
  const _PolicySurfaceContent({
    required this.title,
    required this.headline,
    required this.description,
    required this.sections,
  });

  factory _PolicySurfaceContent.fromType(
    PolicySurfaceType type,
    AppLocalizations l10n,
  ) {
    return switch (type) {
      PolicySurfaceType.privacy => _PolicySurfaceContent(
        title: l10n.policyPrivacyTitle,
        headline: l10n.policyPrivacyHeadline,
        description: l10n.policyPrivacyDescription,
        sections: [
          _PolicySection(
            title: l10n.policyPrivacyCollectionTitle,
            body: l10n.policyPrivacyCollectionBody,
          ),
          _PolicySection(
            title: l10n.policyPrivacyUseTitle,
            body: l10n.policyPrivacyUseBody,
          ),
          _PolicySection(
            title: l10n.policyPrivacyContactTitle,
            body: l10n.policyPrivacyContactBody,
          ),
        ],
      ),
      PolicySurfaceType.terms => _PolicySurfaceContent(
        title: l10n.policyTermsTitle,
        headline: l10n.policyTermsHeadline,
        description: l10n.policyTermsDescription,
        sections: [
          _PolicySection(
            title: l10n.policyTermsMarketplaceTitle,
            body: l10n.policyTermsMarketplaceBody,
          ),
          _PolicySection(
            title: l10n.policyTermsAccountsTitle,
            body: l10n.policyTermsAccountsBody,
          ),
          _PolicySection(
            title: l10n.policyTermsEditsTitle,
            body: l10n.policyTermsEditsBody,
          ),
        ],
      ),
      PolicySurfaceType.cancellation => _PolicySurfaceContent(
        title: l10n.policyCancellationTitle,
        headline: l10n.policyCancellationHeadline,
        description: l10n.policyCancellationDescription,
        sections: [
          _PolicySection(
            title: l10n.policyCancellationRequestsTitle,
            body: l10n.policyCancellationRequestsBody,
          ),
          _PolicySection(
            title: l10n.policyCancellationAcceptedTitle,
            body: l10n.policyCancellationAcceptedBody,
          ),
          _PolicySection(
            title: l10n.policyCancellationSupportTitle,
            body: l10n.policyCancellationSupportBody,
          ),
        ],
      ),
      PolicySurfaceType.booking => _PolicySurfaceContent(
        title: l10n.policyBookingTitle,
        headline: l10n.policyBookingHeadline,
        description: l10n.policyBookingDescription,
        sections: [
          _PolicySection(
            title: l10n.policyBookingRequestsTitle,
            body: l10n.policyBookingRequestsBody,
          ),
          _PolicySection(
            title: l10n.policyBookingTravelTitle,
            body: l10n.policyBookingTravelBody,
          ),
          _PolicySection(
            title: l10n.policyBookingSupportTitle,
            body: l10n.policyBookingSupportBody,
          ),
        ],
      ),
    };
  }

  final String title;
  final String headline;
  final String description;
  final List<_PolicySection> sections;
}

class _PolicySection {
  const _PolicySection({required this.title, required this.body});

  final String title;
  final String body;
}
