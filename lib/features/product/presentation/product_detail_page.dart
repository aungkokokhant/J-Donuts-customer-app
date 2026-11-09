import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../app/repository_providers.dart';
import '../../../core/domain/result.dart';
import '../../../core/presentation/catalog_image.dart';
import '../../../core/presentation/catalog_price.dart';
import '../../../core/presentation/catalog_state.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/presentation/auth_chrome.dart';
import '../domain/product_repository.dart';
import 'product_preview.dart';

final productDetailProvider = FutureProvider.autoDispose
    .family<Result<CatalogProduct?>, String>(
      (ref, id) => ref.watch(productRepositoryProvider).findById(id),
    );

class ProductDetailPage extends ConsumerWidget {
  const ProductDetailPage({super.key, required this.id, this.preview});
  final String id;
  final ProductPreview? preview;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loaded = ref.watch(productDetailProvider(id));
    final snapshot = preview;
    final value =
        snapshot != null &&
            snapshot.product.id == id &&
            loaded.isLoading &&
            !loaded.hasValue
        ? AsyncData<Result<CatalogProduct?>>(Success(snapshot.product))
        : loaded;
    return Scaffold(
      backgroundColor: AppColors.catalogSurface,
      appBar: AppBar(
        backgroundColor: AppColors.catalogSurface,
        leading: BackButton(
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/home'),
        ),
      ),
      body: SafeArea(
        top: false,
        child: CatalogState(
          value: value,
          isEmpty: (_) => false,
          retry: () => ref.invalidate(productDetailProvider(id)),
          height: 320,
          buildData: (product) => product == null
              ? Center(
                  child: Text(AppLocalizations.of(context).productUnavailable),
                )
              : _ProductBody(
                  key: ValueKey(product.id),
                  product: product,
                  heroTag: snapshot?.heroTag,
                ),
        ),
      ),
    );
  }
}

class _ProductBody extends StatefulWidget {
  const _ProductBody({super.key, required this.product, required this.heroTag});
  final CatalogProduct product;
  final String? heroTag;

  @override
  State<_ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<_ProductBody> {
  static const _minimum = 1;
  var _quantity = _minimum;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final product = widget.product;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            children: [
              _ProductCard(product: product, heroTag: widget.heroTag),
              Transform.translate(
                offset: const Offset(0, -AppSpacing.md),
                child: Center(
                  child: _QuantityStepper(
                    quantity: _quantity,
                    onDecrease: _quantity > _minimum
                        ? () => setState(() => _quantity--)
                        : null,
                    onIncrease: () => setState(() => _quantity++),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              _Description(text: product.description),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.md,
          ),
          child: AuthButton(
            label:
                '${strings.addToCart}  |  ${formatMmk(context, product.priceMmk * _quantity)}',
            onPressed: () =>
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(strings.addedToCart))),
          ),
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.heroTag});
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
                  style: textTheme.bodySmall?.copyWith(color: AppColors.muted),
                ),
              ),
              if (product.isNew) _NewBadge(),
            ],
          ),
          Text(product.name, style: textTheme.headlineSmall),
          Text(
            formatMmk(context, product.priceMmk),
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: AspectRatio(
                aspectRatio: 1.07,
                child: FractionallySizedBox(
                  widthFactor: .66,
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
        horizontal: AppSpacing.sm,
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

class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback? onDecrease;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return DecoratedBox(
      decoration: const ShapeDecoration(
        color: AppColors.catalogSurface,
        shape: StadiumBorder(
          side: BorderSide(color: AppColors.white, width: 2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _button(strings.decreaseQuantity, Icons.remove_circle, onDecrease),
            AnimatedSwitcher(
              duration: AppMotion.duration(context, AppMotion.quick),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Text(
                formatNumber(context, quantity),
                key: ValueKey(quantity),
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            _button(strings.increaseQuantity, Icons.add_circle, onIncrease),
          ],
        ),
      ),
    );
  }

  Widget _button(String label, IconData icon, VoidCallback? tap) => IconButton(
    tooltip: label,
    onPressed: tap,
    color: AppColors.sky,
    icon: Icon(icon, size: 27),
  );
}

class _Description extends StatelessWidget {
  const _Description({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: MediaQuery.textScalerOf(context).scale(67),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.help_outline, size: 18, color: AppColors.muted),
            const SizedBox(height: AppSpacing.xs),
            Text(
              AppLocalizations.of(context).whatsThis,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.only(left: AppSpacing.sm),
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: AppColors.white)),
          ),
          child: Text(text, style: const TextStyle(color: AppColors.muted)),
        ),
      ),
    ],
  );
}
