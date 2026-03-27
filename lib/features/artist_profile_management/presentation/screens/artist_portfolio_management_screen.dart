import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../artist_management/application/artist_management_providers.dart';
import '../../../artist_management/domain/models/artist_management_models.dart';

class ArtistPortfolioManagementScreen extends ConsumerWidget {
  const ArtistPortfolioManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final items = ref.watch(
      artistManagementControllerProvider.select(
        (state) => state.profileDraft.portfolioItems,
      ),
    );

    return AppScaffoldWrapper(
      title: l10n.artistPortfolioTitle,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openPortfolioEditor(context, ref),
        label: Text(l10n.artistPortfolioAddCta),
        icon: const Icon(Icons.add_photo_alternate_outlined),
      ),
      child: items.isEmpty
          ? EmptyState(
              title: l10n.artistPortfolioEmptyTitle,
              message: l10n.artistPortfolioEmptyMessage,
              actionLabel: l10n.artistPortfolioAddCta,
              onAction: () => _openPortfolioEditor(context, ref),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
                childAspectRatio: 0.84,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isLoading = ref.watch(
                  artistManagementMutationKeysProvider.select(
                    (keys) => keys.contains('portfolio:${item.id}'),
                  ),
                );
                return AppCard(
                  padding: EdgeInsets.zero,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppRadius.large),
                    onTap: isLoading
                        ? null
                        : () => _openPortfolioEditor(context, ref, item: item),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(AppRadius.large),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(item.startColorValue),
                                  Color(item.endColorValue),
                                ],
                              ),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Icon(
                                    Icons.photo_camera_back_outlined,
                                    color: AppColors.white.withValues(
                                      alpha: 0.92,
                                    ),
                                    size: 32,
                                  ),
                                ),
                                Positioned(
                                  top: AppSpacing.sm,
                                  right: AppSpacing.sm,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: AppColors.white.withValues(
                                        alpha: 0.18,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        AppRadius.pill,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppSpacing.sm,
                                        vertical: AppSpacing.xxs,
                                      ),
                                      child: Text(
                                        item.mediaUrl == null
                                            ? l10n.artistPortfolioMediaPending
                                            : l10n.artistPortfolioMediaReady,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(color: AppColors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                if (isLoading)
                                  const Positioned.fill(
                                    child: ColoredBox(
                                      color: Color(0x44000000),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const AppGap.v(AppSpacing.xxs),
                              Text(
                                item.category,
                                style: Theme.of(context).textTheme.labelMedium
                                    ?.copyWith(color: AppColors.primary),
                              ),
                              const AppGap.v(AppSpacing.xxs),
                              Text(
                                item.caption,
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const AppGap.v(AppSpacing.sm),
                              Text(
                                l10n.artistPortfolioMediaStatusNote,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppColors.textMuted),
                              ),
                              const AppGap.v(AppSpacing.sm),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  onPressed: isLoading
                                      ? null
                                      : () => _confirmDelete(
                                          context,
                                          ref,
                                          itemId: item.id,
                                        ),
                                  icon: const Icon(
                                    Icons.delete_outline_rounded,
                                  ),
                                  label: Text(l10n.artistPortfolioRemoveCta),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref, {
    required String itemId,
  }) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.artistPortfolioRemoveTitle),
          content: Text(l10n.artistPortfolioRemoveMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.actionContinue),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(l10n.artistPortfolioRemoveCta),
            ),
          ],
        );
      },
    );
    if (confirmed != true || !context.mounted) {
      return;
    }

    final result = await ref
        .read(artistManagementControllerProvider.notifier)
        .removePortfolioItem(itemId);
    if (result.failureOrNull != null && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.failureOrNull!.message)));
    }
  }

  Future<void> _openPortfolioEditor(
    BuildContext context,
    WidgetRef ref, {
    ArtistPortfolioItemDraft? item,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _PortfolioEditorSheet(item: item),
    );
  }
}

class _PortfolioEditorSheet extends ConsumerStatefulWidget {
  const _PortfolioEditorSheet({this.item});

  final ArtistPortfolioItemDraft? item;

  @override
  ConsumerState<_PortfolioEditorSheet> createState() =>
      _PortfolioEditorSheetState();
}

class _PortfolioEditorSheetState extends ConsumerState<_PortfolioEditorSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _categoryController;
  late final TextEditingController _captionController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.item?.title ?? '');
    _categoryController = TextEditingController(
      text: widget.item?.category ?? '',
    );
    _captionController = TextEditingController(
      text: widget.item?.caption ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final itemId = widget.item?.id;
    final isLoading = itemId == null
        ? false
        : ref.watch(
            artistManagementMutationKeysProvider.select(
              (keys) => keys.contains('portfolio:$itemId'),
            ),
          );

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item == null
                  ? l10n.artistPortfolioAddSheetTitle
                  : l10n.artistPortfolioEditSheetTitle,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const AppGap.v(AppSpacing.sm),
            Text(
              l10n.artistPortfolioEditorMessage,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const AppGap.v(AppSpacing.lg),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: l10n.artistPortfolioTitleField,
              ),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? l10n.artistPortfolioValidationMessage
                  : null,
            ),
            const AppGap.v(AppSpacing.md),
            TextFormField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: l10n.artistPortfolioCategoryField,
              ),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? l10n.artistPortfolioValidationMessage
                  : null,
            ),
            const AppGap.v(AppSpacing.md),
            TextFormField(
              controller: _captionController,
              decoration: InputDecoration(
                labelText: l10n.artistPortfolioCaptionField,
              ),
              minLines: 3,
              maxLines: 4,
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? l10n.artistPortfolioValidationMessage
                  : null,
            ),
            const AppGap.v(AppSpacing.sm),
            Text(
              l10n.artistPortfolioUploadPlaceholderNote,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
            ),
            const AppGap.v(AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: isLoading ? null : _save,
                child: isLoading
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        widget.item == null
                            ? l10n.artistPortfolioAddCta
                            : l10n.artistPortfolioSaveCta,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final result = await ref
        .read(artistManagementControllerProvider.notifier)
        .savePortfolioItem(
          itemId: widget.item?.id,
          title: _titleController.text,
          category: _categoryController.text,
          caption: _captionController.text,
        );
    if (!mounted) {
      return;
    }
    if (result.failureOrNull != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.failureOrNull!.message)));
      return;
    }
    Navigator.of(context).pop();
  }
}
