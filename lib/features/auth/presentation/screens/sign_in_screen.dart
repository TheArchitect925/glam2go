import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/result/app_result.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../artist_management/application/artist_management_providers.dart';
import '../../../profile/application/account_providers.dart';
import '../../../session/application/session_providers.dart';
import '../../../session/domain/models/session_models.dart';

const _defaultCustomerName = 'Sana Malik';
const _defaultCustomerEmail = 'sana.malik@example.com';
const _defaultArtistName = 'Aaliyah Noor';
const _defaultArtistEmail = 'artist@glam2go.example';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _defaultCustomerName);
    _emailController = TextEditingController(text: _defaultCustomerEmail);
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
    final config = ref.watch(appConfigProvider);

    return AppScaffoldWrapper(
      title: l10n.authSignInTitle,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: l10n.authSignInTitle,
              subtitle: l10n.authSignInDescription,
            ),
            const AppGap.v(AppSpacing.xl),
            AppCard(
              child: Text(
                _pendingMessage(l10n, session.pendingProtectedAction),
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
                      l10n.authCredentialsTitle,
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
                      label: l10n.authContinueAsCustomer,
                      onPressed: _isSubmitting
                          ? null
                          : () => _submit(mode: AppUserMode.customer),
                    ),
                    const AppGap.v(AppSpacing.sm),
                    AppButton(
                      label: l10n.authContinueAsArtist,
                      onPressed: _isSubmitting
                          ? null
                          : () => _submit(mode: AppUserMode.artist),
                      tone: AppButtonTone.secondary,
                    ),
                  ],
                ),
              ),
            ),
            const AppGap.v(AppSpacing.md),
            if (config.enableDebugDefaultAccounts) ...[
              AppCard(
                tone: AppCardTone.muted,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.authDevShortcutTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const AppGap.v(AppSpacing.xs),
                    Text(
                      l10n.authDevShortcutSubtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const AppGap.v(AppSpacing.md),
                    AppButton(
                      label: l10n.authUseDefaultCustomer,
                      onPressed: _isSubmitting
                          ? null
                          : () => _submit(
                              mode: AppUserMode.customer,
                              useDefaultAccount: true,
                            ),
                      tone: AppButtonTone.text,
                    ),
                    const AppGap.v(AppSpacing.xs),
                    AppButton(
                      label: l10n.authUseDefaultArtist,
                      onPressed: _isSubmitting
                          ? null
                          : () => _submit(
                              mode: AppUserMode.artist,
                              useDefaultAccount: true,
                            ),
                      tone: AppButtonTone.text,
                    ),
                  ],
                ),
              ),
              const AppGap.v(AppSpacing.lg),
            ],
            Center(
              child: AppButton(
                label: l10n.authCreateAccountInlineCta,
                onPressed: () => context.go(AppRoutePaths.signUp),
                tone: AppButtonTone.text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit({
    required AppUserMode mode,
    bool useDefaultAccount = false,
  }) async {
    if (!useDefaultAccount && !_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    final pendingAction = ref
        .read(sessionControllerProvider)
        .pendingProtectedAction;
    final displayName = useDefaultAccount
        ? (mode == AppUserMode.artist
              ? _defaultArtistName
              : _defaultCustomerName)
        : _nameController.text.trim();
    final email = useDefaultAccount
        ? (mode == AppUserMode.artist
              ? _defaultArtistEmail
              : _defaultCustomerEmail)
        : _emailController.text.trim();
    final shouldUseDebugDefaultAccount =
        useDefaultAccount ||
        _matchesDebugDefaultAccount(
          mode: mode,
          displayName: displayName,
          email: email,
        );

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
            fallbackPath: AppRoutePaths.home,
            useDebugDefaultAccount: shouldUseDebugDefaultAccount,
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
      final readiness = ref.read(artistReadinessProvider);
      authResult = await ref
          .read(sessionControllerProvider.notifier)
          .signInAsArtist(
            displayName: displayName,
            email: email,
            fallbackPath: readiness.progress >= 1
                ? AppRoutePaths.artistDashboard
                : AppRoutePaths.artistOnboarding,
            artistProfileId: artistState.publicArtistId,
            useDebugDefaultAccount: shouldUseDebugDefaultAccount,
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

  String _pendingMessage(
    AppLocalizations l10n,
    PendingProtectedAction? pendingAction,
  ) {
    if (pendingAction == null) {
      return l10n.authSignInHelper;
    }

    return switch (pendingAction.requirement) {
      ProtectedActionRequirement.bookingSubmission =>
        l10n.authBookingResumeMessage,
      ProtectedActionRequirement.favorites => l10n.authFavoritesResumeMessage,
      ProtectedActionRequirement.artistTools => l10n.authArtistResumeMessage,
      ProtectedActionRequirement.customerAccount =>
        l10n.authAccountResumeMessage,
    };
  }

  bool _matchesDebugDefaultAccount({
    required AppUserMode mode,
    required String displayName,
    required String email,
  }) {
    final config = ref.read(appConfigProvider);
    if (!config.enableDebugDefaultAccounts) {
      return false;
    }

    final normalizedEmail = email.trim().toLowerCase();
    final normalizedName = displayName.trim().toLowerCase();

    return switch (mode) {
      AppUserMode.customer =>
        normalizedEmail == _defaultCustomerEmail &&
            normalizedName == _defaultCustomerName.toLowerCase(),
      AppUserMode.artist =>
        normalizedEmail == _defaultArtistEmail &&
            normalizedName == _defaultArtistName.toLowerCase(),
      AppUserMode.guest => false,
    };
  }
}
