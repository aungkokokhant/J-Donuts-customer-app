import 'package:flutter/material.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../core/presentation/donut_photos.dart';

class DonutArt extends StatelessWidget {
  const DonutArt({super.key, required this.height, this.tiles = false});

  final double height;
  final bool tiles;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    width: double.infinity,
    child: ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [AppColors.white, AppColors.white, Colors.transparent],
        stops: [0, tiles ? .78 : .68, .95],
      ).createShader(bounds),
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: LayoutBuilder(
          builder: (context, limits) => _DonutCollage(
            width: limits.maxWidth,
            height: limits.maxHeight,
            tiles: tiles,
          ),
        ),
      ),
    ),
  );
}

typedef _Placement = ({
  double x,
  double y,
  double widthFraction,
  String photo,
  Color backdrop,
});

class _DonutCollage extends StatelessWidget {
  const _DonutCollage({
    required this.width,
    required this.height,
    required this.tiles,
  });

  final double width;
  final double height;
  final bool tiles;

  static const List<_Placement> _circles = [
    (
      x: -.08,
      y: .12,
      widthFraction: .56,
      photo: DonutPhotos.chocolate,
      backdrop: AppColors.artAqua,
    ),
    (
      x: .53,
      y: .43,
      widthFraction: .55,
      photo: DonutPhotos.pink,
      backdrop: AppColors.artPeach,
    ),
    (
      x: 1.10,
      y: .16,
      widthFraction: .52,
      photo: DonutPhotos.chocolateDrizzle,
      backdrop: AppColors.artLavender,
    ),
    (
      x: -.08,
      y: .72,
      widthFraction: .56,
      photo: DonutPhotos.blue,
      backdrop: AppColors.artPowderBlue,
    ),
    (
      x: 1.10,
      y: .68,
      widthFraction: .50,
      photo: DonutPhotos.blue,
      backdrop: AppColors.artPowderBlue,
    ),
    (
      x: .52,
      y: 1.06,
      widthFraction: .53,
      photo: DonutPhotos.chocolateDrizzle,
      backdrop: AppColors.artHoney,
    ),
  ];

  static const List<_Placement> _tiles = [
    (
      x: .22,
      y: .24,
      widthFraction: .48,
      photo: DonutPhotos.blue,
      backdrop: AppColors.artPowderBlue,
    ),
    (
      x: .78,
      y: .34,
      widthFraction: .48,
      photo: DonutPhotos.chocolateDrizzle,
      backdrop: AppColors.artLavender,
    ),
    (
      x: .22,
      y: .73,
      widthFraction: .48,
      photo: DonutPhotos.pink,
      backdrop: AppColors.artPeach,
    ),
    (
      x: .78,
      y: .83,
      widthFraction: .48,
      photo: DonutPhotos.chocolate,
      backdrop: AppColors.artHoney,
    ),
  ];

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      for (final (index, item) in (tiles ? _tiles : _circles).indexed)
        _place(item, index),
    ],
  );

  Widget _place(_Placement item, int index) {
    final edge = (width * item.widthFraction).clamp(0.0, height * .56);
    return Positioned(
      width: edge,
      height: edge,
      left: width * item.x - edge / 2,
      top: height * item.y - edge / 2,
      child: _DonutEntrance(
        index: index,
        child: _PhotoTile(item: item, rounded: tiles, edge: edge),
      ),
    );
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({
    required this.item,
    required this.rounded,
    required this.edge,
  });

  final _Placement item;
  final bool rounded;
  final double edge;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      shape: rounded ? BoxShape.rectangle : BoxShape.circle,
      borderRadius: rounded ? BorderRadius.circular(AppSpacing.lg) : null,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          item.backdrop,
          Color.lerp(item.backdrop, AppColors.landingPink, .34)!,
        ],
      ),
    ),
    child: FractionallySizedBox(
      widthFactor: .76,
      heightFactor: .76,
      child: Image.asset(
        item.photo,
        fit: BoxFit.contain,
        cacheWidth: (edge * MediaQuery.devicePixelRatioOf(context)).round(),
        excludeFromSemantics: true,
      ),
    ),
  );
}

class _DonutEntrance extends StatelessWidget {
  const _DonutEntrance({required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return child;
    final delay = AppMotion.stagger * index;
    final total = AppMotion.entrance + delay;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: total,
      curve: Interval(delay.inMilliseconds / total.inMilliseconds, 1),
      child: child,
      builder: (context, value, child) {
        final remaining = 1 - AppMotion.curve.transform(value);
        return Transform.translate(
          offset: Offset(
            (index.isEven ? -1 : 1) * 42 * remaining,
            26 * remaining,
          ),
          child: Opacity(opacity: 1 - remaining, child: child),
        );
      },
    );
  }
}
