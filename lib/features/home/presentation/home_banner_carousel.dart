import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../core/presentation/catalog_image.dart';
import '../domain/home_repository.dart';

class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({super.key, required this.banners});
  final List<HomeBanner> banners;

  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  final _controller = PageController(viewportFraction: .82);
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
    height: 142 + MediaQuery.textScalerOf(context).scale(38),
    child: Padding(
      padding: const EdgeInsets.only(left: AppSpacing.lg),
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
    padding: const EdgeInsets.only(right: AppSpacing.md),
    child: ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(AppSpacing.md),
      ),
      child: ColoredBox(
        color: alternate ? AppColors.sky : AppColors.violet,
        child: CustomPaint(
          painter: const _BannerSprinkles(),
          child: _content(context),
        ),
      ),
    ),
  );

  Widget _content(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: AppSpacing.sm),
    child: Column(
      children: [
        _label(context),
        const SizedBox(height: AppSpacing.xs),
        FractionallySizedBox(
          widthFactor: .86,
          child: Text(
            banner.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(color: AppColors.white, height: 1.08),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Expanded(child: _photo()),
      ],
    ),
  );

  Widget _photo() => FractionallySizedBox(
    widthFactor: .68,
    child: ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(AppSpacing.fieldRadius),
      ),
      child: ColoredBox(
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(1, 1, 1, 0),
          child: SizedBox.expand(
            child: CatalogImage(source: banner.imageKey, fit: BoxFit.cover),
          ),
        ),
      ),
    ),
  );

  Widget _label(BuildContext context) => DecoratedBox(
    decoration: const ShapeDecoration(
      color: AppColors.orange,
      shape: StadiumBorder(side: BorderSide(color: AppColors.white)),
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
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.white,
          fontWeight: AppTypography.labelWeight,
        ),
      ),
    ),
  );
}

class _BannerSprinkles extends CustomPainter {
  const _BannerSprinkles();

  static const _strokes = [
    (Offset(.10, .06), Offset(.13, .12)),
    (Offset(.24, .00), Offset(.22, .06)),
    (Offset(.46, .00), Offset(.46, .09)),
    (Offset(.87, .00), Offset(.88, .06)),
    (Offset(.95, .11), Offset(.93, .21)),
    (Offset(.04, .27), Offset(.10, .30)),
    (Offset(.25, .22), Offset(.28, .18)),
    (Offset(.70, .16), Offset(.75, .20)),
    (Offset(.80, .34), Offset(.86, .25)),
    (Offset(.00, .49), Offset(.02, .56)),
    (Offset(.10, .61), Offset(.09, .72)),
    (Offset(.21, .45), Offset(.26, .49)),
    (Offset(.60, .48), Offset(.65, .56)),
    (Offset(.94, .70), Offset(.94, .81)),
    (Offset(.02, .85), Offset(.08, .86)),
    (Offset(.13, .95), Offset(.16, .86)),
    (Offset(.85, .94), Offset(.89, .98)),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.white.withValues(alpha: .12)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;
    for (final (start, end) in _strokes) {
      canvas.drawLine(
        Offset(start.dx * size.width, start.dy * size.height),
        Offset(end.dx * size.width, end.dy * size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_BannerSprinkles oldDelegate) => false;
}
