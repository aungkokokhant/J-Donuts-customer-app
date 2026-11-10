import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/design/app_motion.dart';
import '../../app/design/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../domain/result.dart';

class CatalogState<T> extends StatelessWidget {
  const CatalogState({
    super.key,
    required this.value,
    required this.buildData,
    required this.isEmpty,
    required this.retry,
    this.height = 120,
  }) : _isSliver = false;

  const CatalogState.sliver({
    super.key,
    required this.value,
    required this.buildData,
    required this.isEmpty,
    required this.retry,
    this.height = 120,
  }) : _isSliver = true;

  final AsyncValue<Result<T>> value;
  final Widget Function(T) buildData;
  final bool Function(T) isEmpty;
  final VoidCallback retry;
  final double height;
  final bool _isSliver;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return value.when(
      loading: () => _placeholder(CatalogSkeleton(height: height)),
      error: (_, _) => _failure(strings),
      data: (result) => switch (result) {
        Success(:final value) when !isEmpty(value) => buildData(value),
        Success() => _placeholder(_message(strings.emptySection)),
        Failure() => _failure(strings),
      },
    );
  }

  Widget _failure(AppLocalizations strings) => _placeholder(
    _message(
      strings.dataError,
      action: TextButton(onPressed: retry, child: Text(strings.retry)),
    ),
  );

  Widget _placeholder(Widget child) =>
      _isSliver ? SliverToBoxAdapter(child: child) : child;

  Widget _message(String text, {Widget? action}) => SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSpacing.sm,
        children: [
          Text(text, textAlign: TextAlign.center),
          ?action,
        ],
      ),
    ),
  );
}

class CatalogSkeleton extends StatefulWidget {
  const CatalogSkeleton({super.key, required this.height});
  final double height;

  @override
  State<CatalogSkeleton> createState() => _CatalogSkeletonState();
}

class _CatalogSkeletonState extends State<CatalogSkeleton>
    with SingleTickerProviderStateMixin {
  late final _sweep = AnimationController(
    vsync: this,
    duration: AppMotion.shimmer,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _sweep.value = 0;
    } else if (!_sweep.isAnimating) {
      _sweep.repeat();
    }
  }

  @override
  void dispose() {
    _sweep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sweep,
      builder: (context, _) {
        final offset = _sweep.value * 4 - 2;
        return Container(
          height: widget.height,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.fieldRadius),
            gradient: LinearGradient(
              begin: Alignment(offset - 1, 0),
              end: Alignment(offset + 1, 0),
              colors: const [
                AppColors.skeleton,
                AppColors.white,
                AppColors.skeleton,
              ],
            ),
          ),
        );
      },
    );
  }
}
