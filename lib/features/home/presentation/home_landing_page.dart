import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../app/network_status.dart';
import '../../../app/repository_providers.dart';
import '../../../core/presentation/catalog_state.dart';
import '../../../core/presentation/offline_banner.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/presentation/session_controller.dart';
import 'home_data.dart';
import 'home_header.dart';
import 'home_sections.dart';

class HomeLandingPage extends ConsumerStatefulWidget {
  const HomeLandingPage({super.key, required this.session});

  final SessionController session;

  @override
  ConsumerState<HomeLandingPage> createState() => _HomeLandingPageState();
}

class _HomeLandingPageState extends ConsumerState<HomeLandingPage> {
  void _refreshCatalog() {
    ref.invalidate(memberProfileProvider);
    ref.invalidate(homeBannersProvider);
    ref.invalidate(homeSectionsProvider);
    ref.invalidate(homeShopsProvider);
  }

  Future<void> _refresh() async {
    ref.invalidate(networkOnlineProvider);
    _refreshCatalog();
    await Future.wait<Object?>([
      ref.read(memberProfileProvider.future),
      ref.read(homeBannersProvider.future),
      ref.read(homeSectionsProvider.future),
      ref.read(homeShopsProvider.future),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final online = ref.watch(networkOnlineProvider);
    ref.listen(networkOnlineProvider, (previous, next) {
      if (previous?.value == false && next.value == true) _refreshCatalog();
    });
    return Scaffold(
      backgroundColor: AppColors.warm,
      body: SafeArea(
        bottom: false,
        child: ColoredBox(
          color: AppColors.catalogSurface,
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              key: const Key('homeScroll'),
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                if (online.value == false)
                  OfflineBanner(label: strings.offlineMessage),
                _header(),
                _sections(),
                const SizedBox(height: AppSpacing.lg),
                _shops(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() => ColoredBox(
    color: AppColors.warm,
    child: Column(
      children: [
        CatalogState(
          value: ref.watch(memberProfileProvider),
          isEmpty: (member) => member == null,
          retry: () => ref.invalidate(memberProfileProvider),
          height: 85,
          buildData: (member) => HomeMemberHeader(
            member: member!,
            name: widget.session.user?.firstName ?? member.name,
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
    ),
  );

  Widget _sections() => CatalogState(
    value: ref.watch(homeSectionsProvider),
    isEmpty: (sections) => sections.isEmpty,
    retry: () => ref.invalidate(homeSectionsProvider),
    height: 160,
    buildData: (sections) => HomeProductSections(sections: sections),
  );

  Widget _shops() => CatalogState(
    value: ref.watch(homeShopsProvider),
    isEmpty: (shops) => shops.isEmpty,
    retry: () => ref.invalidate(homeShopsProvider),
    height: 160,
    buildData: (shops) =>
        EnterMotion(index: 4, child: NearbyShops(shops: shops)),
  );
}
