import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/result/app_result.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../artist_management/application/artist_management_providers.dart';
import '../../../profile/application/account_providers.dart';
import '../../../session/application/session_providers.dart';
import '../../../session/domain/models/session_models.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final session = ref.watch(sessionControllerProvider);

    return AppScaffoldWrapper(
      title: l10n.authSignUpTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: l10n.authSignUpTitle,
              subtitle: l10n.authSignUpDescription,
            ),
            const AppGap.v(AppSpacing.xl),
            AppCard(
              child: Text(
                session.hasPendingProtectedAction
                    ? l10n.authPendingActionMessage
                    : l10n.authCreateAccountHelper,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const AppGap.v(AppSpacing.lg),
            AppCard(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.authCreateAccountDetailsTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const AppGap.v(AppSpacing.md),
                    TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: l10n.authNameFieldLabel,
                        hintText: l10n.authNameFieldHint,
                      ),
                      validator: (value) {
                        if ((value ?? '').trim().isEmpty) {
                          return l10n.authNameValidationMessage;
                        }
                        return null;
                      },
                    ),
                    const AppGap.v(AppSpacing.md),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: l10n.authEmailFieldLabel,
                        hintText: l10n.authEmailFieldHint,
                      ),
                      validator: (value) {
                        final trimmed = (value ?? '').trim();
                        if (trimmed.isEmpty || !trimmed.contains('@')) {
                          return l10n.authEmailValidationMessage;
                        }
                        return null;
                      },
                    ),
                    if (_errorMessage != null) ...[
                      const AppGap.v(AppSpacing.md),
                      Text(
                        _errorMessage!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                    const AppGap.v(AppSpacing.lg),
                    AppButton(
                      label: l10n.authCreateCustomerAccount,
                      onPressed: _isSubmitting
                          ? null
                          : () => _submit(mode: AppUserMode.customer),
                    ),
                    const AppGap.v(AppSpacing.sm),
                    AppButton(
                      label: l10n.authCreateArtistAccount,
                      onPressed: _isSubmitting
                          ? null
                          : () => _submit(mode: AppUserMode.artist),
                      tone: AppButtonTone.secondary,
                    ),
                  ],
                ),
              ),
            ),
            const AppGap.v(AppSpacing.lg),
            Center(
              child: AppButton(
                label: l10n.authAlreadyHaveAccountCta,
                onPressed: () => context.go(AppRoutePaths.signIn),
                tone: AppButtonTone.text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit({required AppUserMode mode}) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    final pendingAction = ref
        .read(sessionControllerProvider)
        .pendingProtectedAction;
    final displayName = _nameController.text.trim();
    final email = _emailController.text.trim();

    late final String destination;
    AppResult<String> authResult;
    if (mode == AppUserMode.customer) {
      ref
          .read(customerProfileProvider.notifier)
          .applyAuthProfile(displayName: displayName, email: email);
      authResult = await ref
          .read(sessionControllerProvider.notifier)
          .signInAsCustomer(
            displayName: displayName,
            email: email,
            fallbackPath: AppRoutePaths.profile,
            intent: AuthIntent.signUp,
          );
    } else {
      final artistState = ref.read(artistManagementControllerProvider);
      ref
          .read(artistManagementControllerProvider.notifier)
          .updateProfile(
            displayName: displayName,
            bio: artistState.profileDraft.bio,
            experienceSummary: artistState.profileDraft.experienceSummary,
            instagramHandle: artistState.profileDraft.instagramHandle,
            tiktokHandle: artistState.profileDraft.tiktokHandle,
          );
      authResult = await ref
          .read(sessionControllerProvider.notifier)
          .signInAsArtist(
            displayName: displayName,
            email: email,
            fallbackPath: AppRoutePaths.artistOnboarding,
            intent: AuthIntent.joinArtist,
            artistProfileId: artistState.publicArtistId,
          );
    }

    if (!mounted) {
      return;
    }

    if (authResult.dataOrNull == null) {
      setState(() {
        _isSubmitting = false;
        _errorMessage =
            authResult.failureOrNull?.message ?? context.l10n.authRequestFailed;
      });
      return;
    }
    destination = authResult.dataOrNull!;

    if (mode == AppUserMode.customer &&
        pendingAction?.requirement == ProtectedActionRequirement.favorites &&
        pendingAction?.artistId != null) {
      ref
          .read(favoriteArtistIdsProvider.notifier)
          .toggle(pendingAction!.artistId!);
    }

    if (mounted) {
      setState(() {
        _isSubmitting = false;
      });
      context.go(destination);
    }
  }
}
