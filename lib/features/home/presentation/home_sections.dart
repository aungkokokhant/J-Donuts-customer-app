import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../core/presentation/catalog_image.dart';
import '../../../l10n/app_localizations.dart';
import '../../product/domain/product_repository.dart';
import '../domain/home_repository.dart';

class HomeProductSections extends StatelessWidget {
  const HomeProductSections({super.key, required this.sections});
  final List<ProductSection> sections;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (final (index, section) in sections.indexed)
        EnterMotion(
          index: index + 1,
          child: _ProductRail(section: section),
        ),
    ],
  );
}

class _ProductRail extends StatelessWidget {
  const _ProductRail({required this.section});
  final ProductSection section;

  @override
  Widget build(BuildContext context) {
    final isSeasonal = section.id == 'seasonal';
    final width = isSeasonal ? 166.0 : 124.0;
    final imageHeight = isSeasonal ? 112.0 : 136.0;
    final labelHeight = MediaQuery.textScalerOf(context).scale(14) * 2.6;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    section.title,
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                ),
                const CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.white,
                  child: Icon(
                    Icons.chevron_right,
                    size: 17,
                    color: AppColors.ink,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (section.products.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(AppLocalizations.of(context).emptySection),
            )
          else
            SizedBox(
              height: imageHeight + labelHeight + AppSpacing.sm,
              child: ListView.separated(
                key: ValueKey('rail-${section.id}'),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                scrollDirection: Axis.horizontal,
                itemCount: section.products.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, index) => _ProductCard(
                  product: section.products[index],
                  sectionId: section.id,
                  width: width,
                  imageHeight: imageHeight,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.sectionId,
    required this.width,
    required this.imageHeight,
  });
  final CatalogProduct product;
  final String sectionId;
  final double width;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    final heroTag = 'product:$sectionId:${product.id}';
    final radius = BorderRadius.circular(AppSpacing.fieldRadius);
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
                    Hero(
                      tag: heroTag,
                      child: ClipRRect(
                        borderRadius: radius,
                        child: ColoredBox(
                          color: AppColors.white,
                          child: CatalogImage(source: product.imageKey),
                        ),
                      ),
                    ),
                    if (discount != null)
                      Positioned(
                        right: AppSpacing.xs,
                        bottom: AppSpacing.xs,
                        child: _DiscountBadge(discount: discount),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  const _DiscountBadge({required this.discount});
  final int discount;

  @override
  Widget build(BuildContext context) => DecoratedBox(
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
        AppLocalizations.of(context).discountLabel(discount),
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: AppColors.white, fontWeight: FontWeight.w900),
      ),
    ),
  );
}

class NearbyShops extends StatelessWidget {
  const NearbyShops({super.key, required this.shops});
  final List<NearbyShop> shops;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return ColoredBox(
      color: AppColors.sky,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strings.nearbyShops(shops.length),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Chip(label: Text(strings.exploreNow)),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: 220 + MediaQuery.textScalerOf(context).scale(32),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                scrollDirection: Axis.horizontal,
                itemCount: shops.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, index) => _ShopCard(shop: shops[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShopCard extends StatelessWidget {
  const _ShopCard({required this.shop});
  final NearbyShop shop;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 228,
    child: Card(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.sm),
              child: SizedBox(
                height: 111,
                width: double.infinity,
                child: CatalogImage(source: shop.imageKey, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              shop.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            Text(
              shop.address,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              AppLocalizations.of(context).orderOnline,
              style: const TextStyle(
                color: AppColors.pink,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
