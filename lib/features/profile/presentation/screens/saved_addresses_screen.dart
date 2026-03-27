import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/address_card.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/info_policy_card.dart';
import '../../../../shared/widgets/protected_feature_gate.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../application/account_providers.dart';
import '../../../session/application/session_providers.dart';
import '../../../session/domain/models/session_models.dart';

class SavedAddressesScreen extends ConsumerWidget {
  const SavedAddressesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final session = ref.watch(sessionControllerProvider);
    final addresses = ref.watch(savedAddressesProvider);

    if (!session.isCustomer) {
      return AppScaffoldWrapper(
        title: l10n.savedAddressesTitle,
        child: ProtectedFeatureGate(
          title: l10n.guestAddressesGateTitle,
          message: session.isGuest
              ? l10n.guestAddressesGateMessage
              : l10n.customerModeRequiredMessage,
          primaryLabel: session.isGuest
              ? l10n.authSignInTitle
              : l10n.actionSwitchToCustomer,
          onPrimary: () {
            if (session.isGuest) {
              ref
                  .read(sessionControllerProvider.notifier)
                  .setPendingProtectedPath(
                    AppRoutePaths.profileAddresses,
                    ProtectedActionRequirement.customerAccount,
                  );
              context.go(AppRoutePaths.signIn);
            } else {
              ref.read(sessionControllerProvider.notifier).switchToCustomer();
            }
          },
        ),
      );
    }

    return AppScaffoldWrapper(
      title: l10n.savedAddressesTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: l10n.savedAddressesHeadline,
              subtitle: l10n.savedAddressesDescription,
            ),
            const AppGap.v(AppSpacing.lg),
            ...addresses.map(
              (address) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: AddressCard(
                  address: address,
                  defaultLabel: l10n.savedAddressesDefaultLabel,
                  onTap: () {
                    ref
                        .read(savedAddressesProvider.notifier)
                        .setDefault(address.id);
                  },
                ),
              ),
            ),
            InfoPolicyCard(
              title: l10n.savedAddressesFutureTitle,
              message: l10n.savedAddressesFutureMessage,
              icon: Icons.home_work_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
