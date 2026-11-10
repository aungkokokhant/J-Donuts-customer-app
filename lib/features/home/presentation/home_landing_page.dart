import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../app/network_status.dart';
import '../../../app/repository_providers.dart';
import '../../../core/domain/result.dart';
import '../../../core/presentation/catalog_state.dart';
import '../../../core/presentation/offline_banner.dart';
import '../../../l10n/app_localizations.dart';
import 'home_banner_carousel.dart';
import 'home_data.dart';
import 'home_header.dart';
import 'home_sections.dart';
import 'nearby_shops.dart';

class HomeLandingPage extends ConsumerStatefulWidget {
  const HomeLandingPage({super.key, required this.memberName});

  final String? memberName;

  @override
  ConsumerState<HomeLandingPage> createState() => _HomeLandingPageState();
}

class _HomeLandingPageState extends ConsumerState<HomeLandingPage> {
  late final _scrollController = ScrollController()..addListener(_onScroll);
  var _scrolled = false;

  void _onScroll() {
    final scrolled = _scrollController.offset > AppSpacing.lg;
    if (scrolled != _scrolled) setState(() => _scrolled = scrolled);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _refreshCatalog() {
    ref.invalidate(memberProfileProvider);
    ref.invalidate(homeBannersProvider);
    ref.invalidate(homeSectionsProvider);
    ref.invalidate(homeSectionProductsProvider);
    ref.invalidate(homeShopsProvider);
  }

  Future<void> _refresh() async {
    ref.invalidate(networkOnlineProvider);
    _refreshCatalog();
    await Future.wait<Object?>([
      ref.read(memberProfileProvider.future),
      ref.read(homeBannersProvider.future),
      _refreshSectionProducts(),
      ref.read(homeShopsProvider.future),
    ]);
  }

  Future<void> _refreshSectionProducts() async {
    final result = await ref.read(homeSectionsProvider.future);
    if (!mounted) return;
    if (result case Success(:final value)) {
      await Future.wait(
        value.map((section) {
          return ref.read(homeSectionProductsProvider(section.id).future);
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final online = ref.watch(networkOnlineProvider);
    ref.listen(networkOnlineProvider, (previous, next) {
      if (previous?.value == false && next.value == true) _refreshCatalog();
    });
    return Scaffold(
      body: AnimatedContainer(
        duration: AppMotion.duration(context, AppMotion.step),
        curve: AppMotion.curve,
        color: _scrolled ? AppColors.white : AppColors.warm,
        child: SafeArea(
          bottom: false,
          child: ColoredBox(
            color: AppColors.catalogSurface,
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: CustomScrollView(
                key: const Key('homeScroll'),
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  if (online.value == false)
                    SliverToBoxAdapter(
                      child: OfflineBanner(label: strings.offlineMessage),
                    ),
                  SliverToBoxAdapter(child: _header()),
                  _sections(),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: AppSpacing.lg),
                  ),
                  SliverToBoxAdapter(
                    child: _shops(MediaQuery.paddingOf(context).bottom),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() => ClipRRect(
    borderRadius: const BorderRadius.vertical(
      bottom: Radius.circular(AppSpacing.lg),
    ),
    child: ColoredBox(
      color: AppColors.warm,
      child: Stack(
        children: [
          const Positioned(
            top: AppSpacing.lg,
            right: -AppSpacing.xl,
            width: 224,
            height: 215,
            child: HomeMemberBackdrop(),
          ),
          _headerContent(),
        ],
      ),
    ),
  );

  Widget _headerContent() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      CatalogState(
        value: ref.watch(memberProfileProvider),
        isEmpty: (member) => member == null,
        retry: () => ref.invalidate(memberProfileProvider),
        height: 85,
        buildData: (member) => HomeMemberHeader(
          member: member!,
          name: widget.memberName ?? member.name,
        ),
      ),
      CatalogState(
        value: ref.watch(homeBannersProvider),
        isEmpty: (banners) => banners.isEmpty,
        retry: () => ref.invalidate(homeBannersProvider),
        height: 170,
        buildData: (banners) =>
            EnterMotion(child: HomeBannerCarousel(banners: banners)),
      ),
    ],
  );

  Widget _sections() => CatalogState.sliver(
    value: ref.watch(homeSectionsProvider),
    isEmpty: (sections) => sections.isEmpty,
    retry: () => ref.invalidate(homeSectionsProvider),
    height: 160,
    buildData: (sections) => HomeProductSections(sections: sections),
  );

  Widget _shops(double bottomInset) => CatalogState(
    value: ref.watch(homeShopsProvider),
    isEmpty: (shops) => shops.isEmpty,
    retry: () => ref.invalidate(homeShopsProvider),
    height: 160,
    buildData: (shops) => EnterMotion(
      index: 4,
      child: NearbyShops(shops: shops, bottomInset: bottomInset),
    ),
  );
}
