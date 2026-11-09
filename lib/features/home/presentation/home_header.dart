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
  Widget build(BuildContext context) => Stack(
    children: [
      PositionedDirectional(
        end: -AppSpacing.lg,
        top: AppSpacing.xs,
        child: ExcludeSemantics(
          child: Icon(
            Icons.shield_outlined,
            size: 132,
            color: AppColors.white.withValues(alpha: .65),
          ),
        ),
      ),
      _details(context),
    ],
  );

  Widget _details(BuildContext context) {
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
            CircleAvatar(
              radius: 9,
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.ink,
              child: FittedBox(child: Text(formatNumber(context, count))),
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
  final _controller = PageController(viewportFraction: .80);
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
      _page = widget.banners.isEmpty
          ? 0
          : _page.clamp(0, widget.banners.length - 1);
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
    height: 134 + MediaQuery.textScalerOf(context).scale(36),
    child: Padding(
      padding: const EdgeInsets.only(left: AppSpacing.md),
      child: PageView.builder(
        controller: _controller,
        padEnds: false,
        onPageChanged: (index) => _page = index,
        itemCount: widget.banners.length,
        itemBuilder: (context, index) =>
            _BannerCard(banner: widget.banners[index], alternate: index.isOdd),
      ),
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
      child: ColoredBox(
        color: alternate ? AppColors.sky : AppColors.violet,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.sm,
            AppSpacing.sm,
            AppSpacing.sm,
            0,
          ),
          child: Column(
            children: [
              _label(context),
              const SizedBox(height: AppSpacing.xs),
              Text(
                banner.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppSpacing.fieldRadius),
                  ),
                  child: SizedBox.expand(
                    child: CatalogImage(
                      source: banner.imageKey,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _label(BuildContext context) => DecoratedBox(
    decoration: const ShapeDecoration(
      color: AppColors.orange,
      shape: StadiumBorder(),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      child: Text(
        banner.label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: AppColors.white, fontWeight: FontWeight.w700),
      ),
    ),
  );
}
