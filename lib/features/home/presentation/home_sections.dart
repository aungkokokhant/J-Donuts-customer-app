import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../core/presentation/catalog_image.dart';
import '../../../core/presentation/catalog_state.dart';
import '../../../l10n/app_localizations.dart';
import '../../product/domain/product_repository.dart';
import '../domain/home_repository.dart';
import 'home_data.dart';

class HomeProductSections extends StatelessWidget {
  const HomeProductSections({super.key, required this.sections});
  final List<ProductSection> sections;

  @override
  Widget build(BuildContext context) => SliverList.builder(
    itemCount: sections.length,
    itemBuilder: (_, index) {
      final section = sections[index];
      return EnterMotion(
        key: PageStorageKey(section.id),
        index: index + 1,
        child: _ProductRail(section: section),
      );
    },
  );
}

enum _RailStyle {
  seasonal(.625, 2 / 3, .48, 1, 1),
  popular(.417, 1.5, .88, .90, .78),
  orderAgain(.417, 1, .88, .82, .83);

  const _RailStyle(
    this.cardWidthFactor,
    this.imageHeightFactor,
    this.labelWidth,
    this.photoWidth,
    this.photoHeight,
  );

  final double cardWidthFactor;
  final double imageHeightFactor;
  final double labelWidth;
  final double photoWidth;
  final double photoHeight;
}

const _productLabelSize = 16.0;
const _productLabelLineHeight = 1.3;
const _productLabelLines = 2;

class _ProductRail extends ConsumerWidget {
  const _ProductRail({required this.section});
  final ProductSection section;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = switch (section.id) {
      'seasonal' => _RailStyle.seasonal,
      'popular' => _RailStyle.popular,
      _ => _RailStyle.orderAgain,
    };
    final viewport = MediaQuery.sizeOf(context).width;
    final inset = (viewport * .064).clamp(20.0, 32.0);
    final width = viewport * style.cardWidthFactor;
    final imageHeight = width * style.imageHeightFactor;
    final provider = homeSectionProductsProvider(section.id);
    return Padding(
      padding: EdgeInsets.only(
        top: style == _RailStyle.seasonal ? AppSpacing.lg : AppSpacing.xxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: inset + AppSpacing.xs),
            child: _title(context, hot: style == _RailStyle.popular),
          ),
          const SizedBox(height: AppSpacing.md),
          CatalogState(
            value: ref.watch(provider),
            isEmpty: (products) => products.isEmpty,
            retry: () => ref.invalidate(provider),
            height: imageHeight,
            buildData: (products) => _productList(
              context,
              products,
              style: style,
              width: width,
              imageHeight: imageHeight,
              inset: inset,
            ),
          ),
        ],
      ),
    );
  }

  Widget _productList(
    BuildContext context,
    List<CatalogProduct> products, {
    required _RailStyle style,
    required double width,
    required double imageHeight,
    required double inset,
  }) {
    final viewport = MediaQuery.sizeOf(context).width;
    final gap = (viewport * .043).clamp(12.0, 22.0);
    final labelStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: _productLabelSize,
      height: _productLabelLineHeight,
      fontWeight: AppTypography.strongWeight,
    );
    return SizedBox(
      height: imageHeight + _labelHeight(context, labelStyle) + AppSpacing.sm,
      child: ListView.separated(
        key: ValueKey('rail-${section.id}'),
        padding: EdgeInsets.symmetric(horizontal: inset),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, _) => SizedBox(width: gap),
        itemBuilder: (context, index) => _ProductCard(
          product: products[index],
          sectionId: section.id,
          width: width,
          imageHeight: imageHeight,
          style: style,
          labelStyle: labelStyle,
        ),
      ),
    );
  }

  double _labelHeight(BuildContext context, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(style: style),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
    );
    final height = painter.preferredLineHeight * _productLabelLines;
    painter.dispose();
    return height.ceilToDouble();
  }

  Widget _title(BuildContext context, {required bool hot}) {
    final titleStyle = Theme.of(context).textTheme.headlineSmall;
    final strings = AppLocalizations.of(context);
    final title = switch (section.id) {
      'seasonal' => strings.seasonalSpecials,
      'popular' => strings.popular,
      'order_again' => strings.orderAgain,
      _ => section.title,
    };
    return Row(
      children: [
        Expanded(
          child: Wrap(
            spacing: AppSpacing.xs,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(title, style: titleStyle),
              if (hot) ExcludeSemantics(child: Text('🔥', style: titleStyle)),
            ],
          ),
        ),
        const CircleAvatar(
          radius: 15,
          backgroundColor: AppColors.white,
          child: Icon(Icons.chevron_right, size: 20, color: AppColors.ink),
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.sectionId,
    required this.width,
    required this.imageHeight,
    required this.style,
    required this.labelStyle,
  });
  final CatalogProduct product;
  final String sectionId;
  final double width;
  final double imageHeight;
  final _RailStyle style;
  final TextStyle labelStyle;

  @override
  Widget build(BuildContext context) {
    final heroTag = 'product:$sectionId:${product.id}';
    final radius = BorderRadius.circular(AppSpacing.md);
    final discount = product.discountPercent;
    return SizedBox(
      width: width,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          key: ValueKey(heroTag),
          borderRadius: radius,
          onTap: () => context.push(
            '/product/${Uri.encodeComponent(product.id)}',
            extra: (heroTag: heroTag, product: product),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: imageHeight,
                width: width,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _photo(context, heroTag, radius),
                    if (discount != null)
                      Positioned(
                        right: AppSpacing.sm,
                        bottom: AppSpacing.sm,
                        child: _DiscountBadge(discount: discount),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              _label(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _photo(BuildContext context, String heroTag, BorderRadius radius) {
    final photo = ClipRRect(
      borderRadius: radius,
      child: ColoredBox(
        color: AppColors.white,
        child: FractionallySizedBox(
          widthFactor: style.photoWidth,
          heightFactor: style.photoHeight,
          child: CatalogImage(
            source: product.imageKey,
            fit: style == _RailStyle.seasonal ? BoxFit.cover : BoxFit.contain,
          ),
        ),
      ),
    );
    return MediaQuery.disableAnimationsOf(context)
        ? photo
        : Hero(tag: heroTag, child: photo);
  }

  Widget _label() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
    child: FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: style.labelWidth,
      child: Text(
        product.name,
        maxLines: _productLabelLines,
        overflow: TextOverflow.ellipsis,
        style: labelStyle,
      ),
    ),
  );
}

class _DiscountBadge extends StatelessWidget {
  const _DiscountBadge({required this.discount});
  final int discount;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const ShapeDecoration(
      color: AppColors.orange,
      shape: StadiumBorder(side: BorderSide(color: AppColors.white)),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(
        AppLocalizations.of(context).discountLabel(discount),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.white,
          fontWeight: AppTypography.strongWeight,
        ),
      ),
    ),
  );
}
