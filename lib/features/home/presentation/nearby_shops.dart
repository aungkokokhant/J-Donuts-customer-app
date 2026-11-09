import 'package:flutter/material.dart';

import '../../../app/design/app_theme.dart';
import '../../../core/presentation/catalog_image.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/home_repository.dart';

class NearbyShops extends StatelessWidget {
  const NearbyShops({
    super.key,
    required this.shops,
    required this.bottomInset,
  });

  final List<NearbyShop> shops;
  final double bottomInset;

  static const _landscape = 'assets/images/catalog/nearby-shops-landscape.webp';

  @override
  Widget build(BuildContext context) {
    final viewport = MediaQuery.sizeOf(context).width;
    final inset = (viewport * .075).clamp(22.0, 36.0);
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.sky,
        image: DecorationImage(
          image: AssetImage(_landscape),
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: AppSpacing.lg,
          bottom: AppSpacing.lg + bottomInset,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _intro(context, inset: inset, titleWidth: viewport * .65),
            const SizedBox(height: AppSpacing.lg),
            _shopRail(context, inset: inset, width: viewport * .746),
          ],
        ),
      ),
    );
  }

  Widget _intro(
    BuildContext context, {
    required double inset,
    required double titleWidth,
  }) {
    final strings = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: inset),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: titleWidth,
            child: Text(
              strings.nearbyShops(shops.length),
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(color: AppColors.white, height: 1.15),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          DecoratedBox(
            decoration: const ShapeDecoration(
              color: AppColors.white,
              shape: StadiumBorder(),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 12,
              ),
              child: Text(
                strings.exploreNow.toUpperCase(),
                style: AppTypography.primaryButton.copyWith(
                  color: AppColors.sky,
                  letterSpacing: .65,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shopRail(
    BuildContext context, {
    required double inset,
    required double width,
  }) {
    final textScale = MediaQuery.textScalerOf(context);
    return SizedBox(
      height: _ShopCard.heightFor(width, textScale),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: inset),
        scrollDirection: Axis.horizontal,
        itemCount: shops.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) => SizedBox(
          width: width,
          child: _ShopCard(shop: shops[index]),
        ),
      ),
    );
  }
}

class _ShopCard extends StatelessWidget {
  const _ShopCard({required this.shop});

  final NearbyShop shop;

  static const _imageRatio = 16 / 9;
  static const _nameSize = 16.0;
  static const _addressSize = 15.0;
  static const _addressLineHeight = 1.32;
  static const _nameLineHeight = 1.20;

  static double heightFor(double width, TextScaler scale) =>
      (width - AppSpacing.md * 2) / _imageRatio +
      AppSpacing.md * 2 +
      AppSpacing.sm * 3 +
      scale.scale(_nameSize) * _nameLineHeight * 3 +
      scale.scale(_addressSize) * _addressLineHeight * 2;

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    color: AppColors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.md + AppSpacing.xs),
    ),
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.md),
            child: AspectRatio(
              aspectRatio: _imageRatio,
              child: CatalogImage(source: shop.imageKey, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _details(context),
        ],
      ),
    ),
  );

  Widget _details(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final nameStyle = styles.bodyLarge?.copyWith(
      fontSize: _nameSize,
      height: _nameLineHeight,
      fontWeight: AppTypography.strongWeight,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          shop.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: nameStyle,
        ),
        const SizedBox(height: AppSpacing.sm),
        FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: .76,
          child: Text(
            shop.address,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: styles.bodyMedium?.copyWith(
              fontSize: _addressSize,
              height: _addressLineHeight,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          AppLocalizations.of(context).orderOnline,
          style: nameStyle?.copyWith(color: AppColors.pink),
        ),
      ],
    );
  }
}
