import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../core/domain/member_profile.dart';
import '../../../core/presentation/catalog_image.dart';
import '../../../core/presentation/catalog_price.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/home_repository.dart';

class HomeMemberHeader extends StatelessWidget {
  const HomeMemberHeader({super.key, required this.member, required this.name});

  final MemberProfile member;
  final String name;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: SizedBox.square(
                  dimension: 49,
                  child: CatalogImage(
                    source: member.imageKey,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      strings.memberTier(member.tier),
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              _NotificationCount(count: member.notificationCount),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          DecoratedBox(
            decoration: const ShapeDecoration(
              color: AppColors.white,
              shape: StadiumBorder(),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Text(
                strings.pointsToTier(
                  formatNumber(context, member.pointsToNextTier),
                  member.nextTier,
                ),
                style: textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationCount extends StatelessWidget {
  const _NotificationCount({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) => Semantics(
    label: AppLocalizations.of(context).notifications,
    child: DecoratedBox(
      decoration: const ShapeDecoration(
        color: AppColors.orange,
        shape: StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.notifications_outlined,
              color: AppColors.white,
              size: 19,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              formatNumber(context, count),
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({super.key, required this.banners});
  final List<HomeBanner> banners;

  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  final _controller = PageController(viewportFraction: .86);
  Timer? _timer;
  var _page = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _schedule();
  }

  @override
  void didUpdateWidget(covariant HomeBannerCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.banners.length != widget.banners.length) {
      _page = _page.clamp(0, widget.banners.length - 1);
      _schedule();
    }
  }

  void _schedule() {
    _timer?.cancel();
    if (widget.banners.length < 2 || MediaQuery.disableAnimationsOf(context)) {
      return;
    }
    _timer = Timer.periodic(AppMotion.carouselInterval, (_) {
      if (!_controller.hasClients ||
          ModalRoute.of(context)?.isCurrent != true) {
        return;
      }
      if (_controller.position.isScrollingNotifier.value) return;
      final next = (_page + 1) % widget.banners.length;
      unawaited(
        _controller.animateToPage(
          next,
          duration: AppMotion.step,
          curve: AppMotion.curve,
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 174,
    child: PageView.builder(
      controller: _controller,
      onPageChanged: (index) => _page = index,
      itemCount: widget.banners.length,
      itemBuilder: (context, index) =>
          _BannerCard(banner: widget.banners[index], alternate: index.isOdd),
    ),
  );
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({required this.banner, required this.alternate});
  final HomeBanner banner;
  final bool alternate;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: AppSpacing.sm),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.fieldRadius),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(color: alternate ? AppColors.orange : AppColors.violet),
          Positioned.fill(
            top: 72,
            child: CatalogImage(source: banner.imageKey, fit: BoxFit.cover),
          ),
          Positioned(
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.sm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  banner.label,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  banner.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
