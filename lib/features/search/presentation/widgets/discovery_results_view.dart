import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_router.dart';
import '../../../../core/l10n/localization.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/loading_state.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../application/discovery_providers.dart';
import 'artist_summary_card.dart';
import 'occasion_filter_chips.dart';

class DiscoveryResultsView extends ConsumerStatefulWidget {
  const DiscoveryResultsView({
    super.key,
    this.showIntro = false,
    this.limitResults,
  });

  final bool showIntro;
  final int? limitResults;

  @override
  ConsumerState<DiscoveryResultsView> createState() =>
      _DiscoveryResultsViewState();
}

class _DiscoveryResultsViewState extends ConsumerState<DiscoveryResultsView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: ref.read(searchQueryProvider))
      ..addListener(_handleQueryChanged);
  }

  void _handleQueryChanged() {
    ref.read(searchQueryProvider.notifier).state = _controller.text;
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_handleQueryChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final selectedOccasion = ref.watch(selectedOccasionProvider);
    final occasionsAsync = ref.watch(occasionOptionsProvider);
    final artistsAsync = ref.watch(filteredArtistsProvider);

    return artistsAsync.when(
      data: (artists) {
        final occasions = occasionsAsync.valueOrNull ?? const <String>[];
        final visibleArtists = widget.limitResults == null
            ? artists
            : artists.take(widget.limitResults!).toList(growable: false);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.showIntro) ...[
              SectionHeader(
                title: l10n.searchHeadline,
                subtitle: l10n.searchDescription,
              ),
              const AppGap.v(AppSpacing.lg),
            ],
            TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search_rounded),
                hintText: l10n.searchInputHint,
                suffixIcon: _controller.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () => _controller.clear(),
                        icon: const Icon(Icons.close_rounded),
                      ),
              ),
              onSubmitted: (_) => context.go(AppRoutePaths.searchResults),
            ),
            const AppGap.v(AppSpacing.md),
            OccasionFilterChips(
              options: occasions,
              selectedValue: selectedOccasion,
              onSelected: (value) {
                ref.read(selectedOccasionProvider.notifier).state = value;
              },
            ),
            const AppGap.v(AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.searchResultsCount(artists.length),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (widget.limitResults != null)
                  TextButton(
                    onPressed: () => context.go(AppRoutePaths.searchResults),
                    child: Text(l10n.actionExploreResults),
                  ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.tune_rounded, size: 18),
                  label: Text(l10n.sortPlaceholderLabel),
                ),
              ],
            ),
            const AppGap.v(AppSpacing.md),
            if (visibleArtists.isEmpty)
              Expanded(
                child: EmptyState(
                  title: l10n.searchEmptyTitle,
                  message: l10n.searchEmptyMessage,
                  actionLabel: l10n.searchEmptyReset,
                  onAction: () {
                    _controller.clear();
                    ref.read(selectedOccasionProvider.notifier).state = null;
                  },
                ),
              )
            else
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final artist = visibleArtists[index];
                    return ArtistSummaryCard(
                      artist: artist,
                      viewProfileLabel: l10n.actionViewArtistProfile,
                      onViewProfile: () => context.go('/artists/${artist.id}'),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const AppGap.v(AppSpacing.md),
                  itemCount: visibleArtists.length,
                ),
              ),
          ],
        );
      },
      loading: () => LoadingState(label: l10n.discoveryLoadingMessage),
      error: (error, stackTrace) => ErrorState(
        title: l10n.discoveryLoadErrorTitle,
        message: l10n.discoveryLoadErrorMessage,
        actionLabel: l10n.actionRetry,
        onAction: () => ref.read(discoveryCatalogProvider.notifier).refresh(),
      ),
    );
  }
}
