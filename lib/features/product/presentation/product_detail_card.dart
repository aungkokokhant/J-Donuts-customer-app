import 'package:flutter/material.dart';

import '../../../app/design/app_theme.dart';
import '../../../core/presentation/catalog_image.dart';
import '../../../core/presentation/catalog_price.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/product_repository.dart';

class ProductDetailCard extends StatelessWidget {
  const ProductDetailCard({
    super.key,
    required this.product,
    required this.heroTag,
  });
  final CatalogProduct product;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final image = CatalogImage(source: product.imageKey);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.fieldRadius * 1.6),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  product.code,
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    color: AppColors.muted,
                  ),
                ),
              ),
              if (product.isNew) _NewBadge(),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            product.name,
            style: textTheme.headlineMedium?.copyWith(
              fontSize: 30,
              height: 1.1,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            formatMmk(context, product.priceMmk),
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: AspectRatio(
                aspectRatio: .97,
                child: FractionallySizedBox(
                  widthFactor: .63,
                  heightFactor: .80,
                  child:
                      heroTag == null || MediaQuery.disableAnimationsOf(context)
                      ? image
                      : Hero(tag: heroTag!, child: image),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NewBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: AppColors.orange,
      borderRadius: BorderRadius.circular(AppSpacing.sm),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + AppSpacing.xs,
        vertical: AppSpacing.xs,
      ),
      child: Text(
        AppLocalizations.of(context).newLabel,
        style: const TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}
