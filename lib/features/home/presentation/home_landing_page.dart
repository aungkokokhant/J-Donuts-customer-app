import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../app/network_status.dart';
import '../../../core/presentation/catalog_state.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/presentation/auth_chrome.dart';
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
  late final _lifecycle = AppLifecycleListener(
    onResume: () => ref.invalidate(networkOnlineProvider),
  );

  @override
  void initState() {
    super.initState();
    // Instantiate the listener once for the lifetime of this route.
    _lifecycle;
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  void _refreshCatalog() {
    ref.invalidate(homeMemberProvider);
    ref.invalidate(homeBannersProvider);
    ref.invalidate(homeSectionsProvider);
    ref.invalidate(homeShopsProvider);
  }

  Future<void> _refresh() async {
    ref.invalidate(networkOnlineProvider);
    _refreshCatalog();
    await Future.wait<Object?>([
      ref.read(homeMemberProvider.future),
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
      backgroundColor: AppColors.catalogSurface,
      bottomNavigationBar: _HomeNavigation(
        onSettings: () => unawaited(_settings(context)),
      ),
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            key: const Key('homeScroll'),
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              if (online.value == false)
                _OfflineBanner(label: strings.offlineMessage),
              _header(),
              _sections(),
              const SizedBox(height: AppSpacing.lg),
              _shops(),
            ],
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
          value: ref.watch(homeMemberProvider),
          isEmpty: (member) => member == null,
          retry: () => ref.invalidate(homeMemberProvider),
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

  Future<void> _settings(BuildContext context) async {
    final strings = AppLocalizations.of(context);
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) => SafeArea(
        child: ListTile(
          leading: const Icon(Icons.logout),
          title: Text(strings.logOut),
          onTap: () => Navigator.of(context).pop(true),
        ),
      ),
    );
    if (confirmed != true || !context.mounted) return;
    final loggedOut = await widget.session.logout();
    if (!context.mounted) return;
    if (loggedOut) {
      context.go('/');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(strings.authError)));
    }
  }
}

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: AppColors.blush,
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          const Icon(Icons.cloud_off_outlined, size: 18),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    ),
  );
}

class _HomeNavigation extends StatelessWidget {
  const _HomeNavigation({required this.onSettings});
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.sm,
          AppSpacing.xs,
          AppSpacing.sm,
          AppSpacing.xs,
        ),
        child: DecoratedBox(
          decoration: const ShapeDecoration(
            color: AppColors.sky,
            shape: StadiumBorder(),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
              vertical: AppSpacing.xs,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Chip(
                  label: Text(
                    strings.home,
                    style: const TextStyle(color: AppColors.white),
                  ),
                  avatar: const Icon(
                    Icons.home_outlined,
                    size: 18,
                    color: AppColors.white,
                  ),
                  backgroundColor: AppColors.pink,
                  side: const BorderSide(color: AppColors.white),
                  shape: const StadiumBorder(),
                ),
                _icon(context, strings.rewards, Icons.emoji_events_outlined),
                _icon(context, strings.menu, Icons.donut_small_outlined),
                _icon(
                  context,
                  strings.wallet,
                  Icons.account_balance_wallet_outlined,
                ),
                _icon(
                  context,
                  strings.settings,
                  Icons.settings_outlined,
                  onSettings,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _icon(
    BuildContext context,
    String label,
    IconData icon, [
    VoidCallback? tap,
  ]) => IconButton(
    tooltip: label,
    icon: Icon(icon, color: AppColors.white),
    onPressed: tap ?? () => showAuthPlaceholder(context),
  );
}
