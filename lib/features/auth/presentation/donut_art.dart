import 'package:flutter/material.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../core/presentation/donut_photos.dart';
import 'donut_backdrop.dart';

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
  DonutBackdropStyle backdrop,
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

  static const _tileHeightFraction = .45;
  static const _tileWidthFraction = .535;
  static const _leftTileVisibleFraction = .8;
  static const _leftTileWidthFraction =
      _tileWidthFraction / _leftTileVisibleFraction;
  static const _leftTileCenter =
      _tileWidthFraction - _leftTileWidthFraction / 2;

  static const List<_Placement> _circles = [
    (
      x: -.08,
      y: .12,
      widthFraction: .56,
      photo: DonutPhotos.chocolate,
      backdrop: DonutBackdropStyle.aqua,
    ),
    (
      x: .53,
      y: .43,
      widthFraction: .55,
      photo: DonutPhotos.pink,
      backdrop: DonutBackdropStyle.peach,
    ),
    (
      x: 1.10,
      y: .16,
      widthFraction: .52,
      photo: DonutPhotos.chocolateDrizzle,
      backdrop: DonutBackdropStyle.ice,
    ),
    (
      x: -.08,
      y: .72,
      widthFraction: .56,
      photo: DonutPhotos.blue,
      backdrop: DonutBackdropStyle.sky,
    ),
    (
      x: 1.10,
      y: .68,
      widthFraction: .50,
      photo: DonutPhotos.blue,
      backdrop: DonutBackdropStyle.mint,
    ),
    (
      x: .52,
      y: 1.06,
      widthFraction: .53,
      photo: DonutPhotos.chocolateDrizzle,
      backdrop: DonutBackdropStyle.honey,
    ),
  ];

  static const List<_Placement> _tiles = [
    (
      x: _leftTileCenter,
      y: .21,
      widthFraction: _leftTileWidthFraction,
      photo: DonutPhotos.purpleGlaze,
      backdrop: DonutBackdropStyle.sky,
    ),
    (
      x: .8875,
      y: .30,
      widthFraction: _tileWidthFraction,
      photo: DonutPhotos.pinkDrizzle,
      backdrop: DonutBackdropStyle.ice,
    ),
    (
      x: _leftTileCenter,
      y: .71,
      widthFraction: _leftTileWidthFraction,
      photo: DonutPhotos.pink,
      backdrop: DonutBackdropStyle.peach,
    ),
    (
      x: .8875,
      y: .81,
      widthFraction: _tileWidthFraction,
      photo: DonutPhotos.chocolateDrizzle,
      backdrop: DonutBackdropStyle.honey,
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
    final tileWidth = width * item.widthFraction;
    final edge = tiles ? tileWidth : tileWidth.clamp(0.0, height * .56);
    final tileHeight = tiles ? height * _tileHeightFraction : edge;
    return Positioned(
      width: edge,
      height: tileHeight,
      left: width * item.x - edge / 2,
      top: height * item.y - tileHeight / 2,
      child: _DonutEntrance(
        index: index,
        child: _PhotoTile(
          item: item,
          rounded: tiles,
          edge: edge,
          photoWidthFactor: _photoWidthFactor(item),
        ),
      ),
    );
  }

  double _photoWidthFactor(_Placement item) {
    if (!tiles) return .76;
    return item.x < .5 ? .84 * _leftTileVisibleFraction : .84;
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({
    required this.item,
    required this.rounded,
    required this.edge,
    required this.photoWidthFactor,
  });

  final _Placement item;
  final bool rounded;
  final double edge;
  final double photoWidthFactor;

  static const _tileRadius = Radius.circular(AppSpacing.lg);

  BorderRadius? get _borderRadius {
    if (!rounded) return null;
    return item.x < .5
        ? const BorderRadius.horizontal(right: _tileRadius)
        : const BorderRadius.all(_tileRadius);
  }

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      DonutBackdrop(style: item.backdrop, borderRadius: _borderRadius),
      FractionallySizedBox(
        widthFactor: photoWidthFactor,
        heightFactor: .76,
        child: Image.asset(
          item.photo,
          fit: BoxFit.contain,
          cacheWidth: (edge * MediaQuery.devicePixelRatioOf(context)).round(),
          excludeFromSemantics: true,
        ),
      ),
    ],
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
