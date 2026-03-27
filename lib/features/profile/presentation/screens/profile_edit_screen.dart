import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/protected_feature_gate.dart';
import '../../application/account_providers.dart';
import '../../../session/application/session_providers.dart';
import '../../../session/domain/models/session_models.dart';

class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(customerProfileProvider);
    _nameController = TextEditingController(text: profile.displayName);
    _emailController = TextEditingController(text: profile.email);
    _phoneController = TextEditingController(text: profile.phoneNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final session = ref.watch(sessionControllerProvider);

    if (!session.isCustomer) {
      return AppScaffoldWrapper(
        title: l10n.profileEditTitle,
        child: ProtectedFeatureGate(
          title: l10n.guestProfileGateTitle,
          message: session.isGuest
              ? l10n.guestProfileGateMessage
              : l10n.customerModeRequiredMessage,
          primaryLabel: session.isGuest
              ? l10n.authSignInTitle
              : l10n.actionSwitchToCustomer,
          onPrimary: () {
            if (session.isGuest) {
              ref
                  .read(sessionControllerProvider.notifier)
                  .setPendingProtectedPath(
                    '/profile/edit',
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
      title: l10n.profileEditTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.profileEditHeadline,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const AppGap.v(AppSpacing.sm),
            Text(
              l10n.profileEditDescription,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const AppGap.v(AppSpacing.xl),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: l10n.profileEditNameField),
            ),
            const AppGap.v(AppSpacing.md),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: l10n.profileEditEmailField,
              ),
            ),
            const AppGap.v(AppSpacing.md),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: l10n.profileEditPhoneField,
              ),
            ),
            const AppGap.v(AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: l10n.profileEditCancelCta,
                    onPressed: () => context.pop(),
                    tone: AppButtonTone.secondary,
                  ),
                ),
                const AppGap.h(AppSpacing.md),
                Expanded(
                  child: AppButton(
                    label: l10n.profileEditSaveCta,
                    onPressed: () {
                      ref
                          .read(customerProfileProvider.notifier)
                          .updateProfile(
                            displayName: _nameController.text,
                            email: _emailController.text,
                            phoneNumber: _phoneController.text,
                          );
                      context.pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
