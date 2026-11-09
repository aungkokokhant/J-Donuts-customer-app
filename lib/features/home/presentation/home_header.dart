import 'package:flutter/material.dart';

import '../../../app/design/app_theme.dart';
import '../../../core/domain/member_profile.dart';
import '../../../core/presentation/catalog_image.dart';
import '../../../core/presentation/catalog_price.dart';
import '../../../l10n/app_localizations.dart';

class HomeMemberHeader extends StatelessWidget {
  const HomeMemberHeader({super.key, required this.member, required this.name});

  final MemberProfile member;
  final String name;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      AppSpacing.lg,
      AppSpacing.lg,
      0,
      AppSpacing.md,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _profileRow(context),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: const EdgeInsets.only(right: AppSpacing.lg),
          child: _PointsToTier(member: member),
        ),
      ],
    ),
  );

  Widget _profileRow(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MemberAvatar(member: member),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  strings.memberTier(member.tier),
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Padding(
          padding: const EdgeInsets.only(top: AppSpacing.xs),
          child: _NotificationCount(count: member.notificationCount),
        ),
      ],
    );
  }
}

class _MemberAvatar extends StatelessWidget {
  const _MemberAvatar({required this.member});

  final MemberProfile member;

  @override
  Widget build(BuildContext context) {
    final (fill, color) = switch (member.tier.toLowerCase()) {
      'bronze' => (.18, AppColors.medalBronze),
      'silver' => (.30, AppColors.medalSilverAccent),
      'gold' => (.65, AppColors.medalGoldAccent),
      'platinum' => (1.0, AppColors.sky),
      _ => (member.tierProgress, AppColors.medalSilverAccent),
    };
    return ExcludeSemantics(
      child: SizedBox.square(
        dimension: 66,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: fill,
              color: color,
              backgroundColor: AppColors.white.withValues(alpha: .55),
              strokeWidth: 5,
              strokeCap: StrokeCap.round,
              padding: EdgeInsets.zero,
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: ClipOval(
                child: CatalogImage(source: member.imageKey, fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PointsToTier extends StatelessWidget {
  const _PointsToTier({required this.member});

  final MemberProfile member;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const ShapeDecoration(
      color: AppColors.white,
      shape: StadiumBorder(),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 6,
      ),
      child: Text(
        AppLocalizations.of(context).pointsToTier(
          formatNumber(context, member.pointsToNextTier),
          member.nextTier,
        ),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
  );
}

class _NotificationCount extends StatelessWidget {
  const _NotificationCount({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) => Semantics(
    label: AppLocalizations.of(context).notifications,
    child: DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.orange,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(AppSpacing.lg),
        ),
        border: Border.fromBorderSide(BorderSide(color: AppColors.white)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.sm,
          AppSpacing.sm,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.notifications_outlined,
              color: AppColors.white,
              size: 22,
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

class HomeMemberBackdrop extends StatelessWidget {
  const HomeMemberBackdrop({super.key});

  @override
  Widget build(BuildContext context) => const ExcludeSemantics(
    child: IgnorePointer(
      child: CustomPaint(
        painter: _MemberBadgePainter(),
        child: Align(
          alignment: Alignment(0, -.30),
          child: Icon(
            Icons.star_rounded,
            color: AppColors.memberBadgeStar,
            size: 52,
          ),
        ),
      ),
    ),
  );
}

class _MemberBadgePainter extends CustomPainter {
  const _MemberBadgePainter();

  static const _bounds = Rect.fromLTWH(0, 0, 1, 1);
  static final _badge = Path()
    ..moveTo(.42, .04)
    ..quadraticBezierTo(.5, 0, .58, .04)
    ..lineTo(.9, .22)
    ..quadraticBezierTo(.97, .26, .97, .34)
    ..lineTo(.97, .66)
    ..quadraticBezierTo(.97, .74, .9, .78)
    ..lineTo(.58, .96)
    ..quadraticBezierTo(.5, 1, .42, .96)
    ..lineTo(.10, .78)
    ..quadraticBezierTo(.03, .74, .03, .66)
    ..lineTo(.03, .34)
    ..quadraticBezierTo(.03, .26, .10, .22)
    ..close();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width, size.height);
    canvas.drawPath(_badge, Paint()..shader = _gradient.createShader(_bounds));
    canvas.drawPath(
      _badge,
      Paint()
        ..color = AppColors.white
        ..strokeWidth = .017
        ..style = PaintingStyle.stroke,
    );
    canvas.translate(.075, .075);
    canvas.scale(.85);
    canvas.drawPath(_badge, Paint()..color = AppColors.memberBadgeFace);
    canvas.restore();
  }

  static const _gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.warm, AppColors.medalBronze],
  );

  @override
  bool shouldRepaint(_MemberBadgePainter oldDelegate) => false;
}
