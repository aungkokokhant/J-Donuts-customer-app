import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import 'rewards_style.dart';

class RewardsPointsRing extends StatefulWidget {
  const RewardsPointsRing({
    super.key,
    required this.points,
    required this.fill,
  });

  final int points;
  final double fill;

  @override
  State<RewardsPointsRing> createState() => _RewardsPointsRingState();
}

class _RewardsPointsRingState extends State<RewardsPointsRing>
    with SingleTickerProviderStateMixin {
  static const _countSteps = 15;
  late final _controller = AnimationController(
    vsync: this,
    duration: AppMotion.rewardEntrance,
  );
  late final _progress = _controller.drive(CurveTween(curve: AppMotion.curve));
  final _countStep = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateCountStep);
  }

  void _updateCountStep() {
    _countStep.value = (_controller.value * _countSteps).floor();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
    } else if (_controller.isDismissed && !_controller.isAnimating) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _countStep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: 1,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: RepaintBoundary(
            child: CustomPaint(painter: _PointsPainter(widget.fill, _progress)),
          ),
        ),
        FractionallySizedBox(
          widthFactor: .52,
          child: FittedBox(fit: BoxFit.scaleDown, child: _total(context)),
        ),
      ],
    ),
  );

  Widget _total(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final strings = AppLocalizations.of(context);
    final format = NumberFormat.decimalPattern(strings.localeName);
    final countStyle = theme.headlineMedium?.copyWith(
      color: AppColors.pink,
      fontSize: RewardsTextSize.points,
      fontWeight: FontWeight.w900,
      height: 1.1,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          strings.totalPoints,
          style: theme.titleSmall?.copyWith(
            color: AppColors.pink,
            fontSize: RewardsTextSize.label,
            fontWeight: AppTypography.strongWeight,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        ValueListenableBuilder<int>(
          valueListenable: _countStep,
          builder: (_, step, _) {
            final progress = AppMotion.curve.transform(step / _countSteps);
            return Text(
              format.format((widget.points * progress).round()),
              key: const Key('rewardPointTotal'),
              style: countStyle,
            );
          },
        ),
      ],
    );
  }
}

class _PointsPainter extends CustomPainter {
  _PointsPainter(this.fill, this.progress) : super(repaint: progress);

  final double fill;
  final Animation<double> progress;
  Rect? _icingBounds;
  Shader? _icingShader;
  static const _start = -math.pi / 2 + .14;
  static const _turn = math.pi * 2;
  static const _sprinkleCount = 24;
  static const _icing = RadialGradient(
    colors: [
      AppColors.rewardShadow,
      AppColors.pink,
      AppColors.rewardHighlight,
      AppColors.pink,
      AppColors.rewardShadow,
    ],
    stops: [.55, .61, .76, .94, 1],
  );

  @override
  void paint(Canvas canvas, Size size) {
    final visibleFill = fill * progress.value;
    final width = size.shortestSide * .21;
    final outer = size.shortestSide / 2 - 1;
    final center = size.center(Offset.zero);
    final radius = outer - width / 2;
    if (radius <= 0) return;
    final ring = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..color = AppColors.catalogSurface;
    canvas.drawCircle(center, radius, paint);
    if (visibleFill <= 0) return;
    final bounds = Rect.fromCircle(center: center, radius: outer);
    if (_icingBounds != bounds) {
      _icingBounds = bounds;
      _icingShader = _icing.createShader(bounds);
    }
    paint
      ..strokeCap = StrokeCap.round
      ..shader = _icingShader;
    canvas.drawArc(ring, _start, _turn * visibleFill, false, paint);
    _sprinkles(canvas, center, radius, width, visibleFill);
  }

  void _sprinkles(
    Canvas canvas,
    Offset center,
    double radius,
    double width,
    double visibleFill,
  ) {
    final paint = Paint()
      ..color = AppColors.white.withValues(alpha: .32)
      ..strokeWidth = width * .105
      ..strokeCap = StrokeCap.round;
    for (var index = 0; index < _sprinkleCount; index++) {
      final position = (index + .40) / _sprinkleCount;
      if (position > visibleFill) break;
      final angle = _start + _turn * position;
      final inset = ((index % 3) - 1) * width * .24;
      final anchor = center + _direction(angle) * (radius + inset);
      final tilt = angle + (index.isEven ? .6 : 1.6);
      final span = _direction(tilt) * width * .16;
      canvas.drawLine(anchor - span, anchor + span, paint);
    }
  }

  Offset _direction(double angle) => Offset(math.cos(angle), math.sin(angle));

  @override
  bool shouldRepaint(_PointsPainter oldDelegate) =>
      oldDelegate.fill != fill || oldDelegate.progress != progress;
}
