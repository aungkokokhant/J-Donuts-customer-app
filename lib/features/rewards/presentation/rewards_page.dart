import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../app/network_status.dart';
import '../../../app/repository_providers.dart';
import '../../../core/domain/member_profile.dart';
import '../../../core/domain/result.dart';
import '../../../core/presentation/catalog_price.dart';
import '../../../core/presentation/catalog_state.dart';
import '../../../core/presentation/offline_banner.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/rewards_repository.dart';
import 'challenge_card.dart';
import 'rewards_overview.dart';
import 'rewards_style.dart';
import 'rewards_tabs.dart';

final rewardChallengesProvider =
    FutureProvider.autoDispose<Result<List<RewardChallenge>>>(
      (ref) =>
          ref.watch(rewardsRepositoryProvider).loadChallenges(demoMemberId),
    );

class RewardsPage extends ConsumerStatefulWidget {
  const RewardsPage({super.key});

  @override
  ConsumerState<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends ConsumerState<RewardsPage> {
  var _gift = false;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final online = ref.watch(networkOnlineProvider);
    ref.listen(networkOnlineProvider, (previous, next) {
      if (previous?.value == false && next.value == true) _reload();
    });
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: ColoredBox(
          color: AppColors.catalogSurface,
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              key: const Key('rewardsScroll'),
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                if (online.value == false)
                  OfflineBanner(label: strings.offlineMessage),
                _overview(),
                _tabs(),
                _content(strings),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabs() => DecoratedBox(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.white, AppColors.catalogSurface],
        stops: [.42, .42],
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 248),
          child: RewardsTabs(
            gift: _gift,
            onChanged: (value) => setState(() => _gift = value),
          ),
        ),
      ),
    ),
  );

  void _reload() {
    ref.invalidate(memberProfileProvider);
    ref.invalidate(rewardChallengesProvider);
  }

  Future<void> _refresh() async {
    ref.invalidate(networkOnlineProvider);
    _reload();
    await Future.wait<Object?>([
      ref.read(memberProfileProvider.future),
      ref.read(rewardChallengesProvider.future),
    ]);
  }

  Widget _overview() => ColoredBox(
    color: AppColors.white,
    child: Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md, bottom: AppSpacing.xl),
      child: CatalogState(
        value: ref.watch(memberProfileProvider),
        isEmpty: (member) => member == null,
        retry: () => ref.invalidate(memberProfileProvider),
        height: 225,
        buildData: (member) => Column(
          children: [
            _RewardsHeader(count: member!.availableRewards),
            const SizedBox(height: AppSpacing.xl + AppSpacing.sm),
            RewardsOverview(member: member),
          ],
        ),
      ),
    ),
  );

  Widget _content(AppLocalizations strings) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: (MediaQuery.sizeOf(context).width * .064).clamp(20.0, 32.0),
    ).copyWith(bottom: AppSpacing.lg),
    child: AnimatedSwitcher(
      duration: AppMotion.duration(context, AppMotion.step),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween(
            begin: const Offset(0, .06),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: AppMotion.curve)),
          child: child,
        ),
      ),
      child: _gift
          ? _GiftsEmpty(key: const ValueKey('gifts'), label: strings.noGifts)
          : _challengeList(),
    ),
  );

  Widget _challengeList() => CatalogState(
    key: const ValueKey('challenges'),
    value: ref.watch(rewardChallengesProvider),
    isEmpty: (challenges) => challenges.isEmpty,
    retry: () => ref.invalidate(rewardChallengesProvider),
    height: 146,
    buildData: (challenges) => Column(
      children: [
        for (final (index, challenge) in challenges.indexed)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: EnterMotion(
              index: index + 1,
              child: ChallengeCard(
                key: ValueKey(challenge.id),
                challenge: challenge,
              ),
            ),
          ),
      ],
    ),
  );
}

class _RewardsHeader extends StatelessWidget {
  const _RewardsHeader({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return ClipRect(
      child: Padding(
        padding: const EdgeInsets.only(left: AppSpacing.lg + AppSpacing.xs),
        child: Row(
          children: [
            Expanded(
              child: Text(
                strings.rewardsTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: RewardsTextSize.heading,
                  fontWeight: AppTypography.strongWeight,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: AppMotion.duration(context, AppMotion.step),
              curve: AppMotion.pop,
              builder: (_, value, child) => FractionalTranslation(
                translation: Offset((1 - value).clamp(0.0, 1.0), 0),
                child: Transform.scale(
                  alignment: Alignment.centerRight,
                  scale: .76 + .24 * value,
                  child: child,
                ),
              ),
              child: _RewardBadge(label: strings.rewardsBadge, count: count),
            ),
          ],
        ),
      ),
    );
  }
}

class _RewardBadge extends StatelessWidget {
  const _RewardBadge({required this.label, required this.count});
  final String label;
  final int count;
  static const _radius = BorderRadius.horizontal(left: Radius.circular(30));

  @override
  Widget build(BuildContext context) => Material(
    color: AppColors.orange,
    shape: const RoundedRectangleBorder(borderRadius: _radius),
    child: InkWell(
      borderRadius: _radius,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.md, 10, 12, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: RewardsTextSize.label,
                fontWeight: AppTypography.strongWeight,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            CircleAvatar(
              radius: 9,
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.ink,
              child: FittedBox(
                child: Text(
                  formatNumber(context, count),
                  style: const TextStyle(
                    fontSize: RewardsTextSize.body,
                    fontWeight: AppTypography.strongWeight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _GiftsEmpty extends StatelessWidget {
  const _GiftsEmpty({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Card(
    color: AppColors.white,
    elevation: 0,
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          const Icon(Icons.card_giftcard, size: 38, color: AppColors.pink),
          const SizedBox(height: AppSpacing.sm),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}
