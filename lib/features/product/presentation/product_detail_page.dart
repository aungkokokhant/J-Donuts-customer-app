import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../app/repository_providers.dart';
import '../../../core/domain/result.dart';
import '../../../core/presentation/catalog_price.dart';
import '../../../core/presentation/catalog_state.dart';
import '../../../core/presentation/primary_action_button.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/product_repository.dart';
import 'product_detail_card.dart';
import 'product_preview.dart';

final productDetailProvider = FutureProvider.autoDispose
    .family<Result<CatalogProduct?>, String>(
      (ref, id) => ref.watch(productRepositoryProvider).findById(id),
    );

class ProductDetailPage extends ConsumerWidget {
  const ProductDetailPage({
    super.key,
    required this.id,
    required this.cartOwner,
    this.preview,
  });
  final String id;
  final String cartOwner;
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
        leadingWidth: 72,
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
                  cartOwner: cartOwner,
                  heroTag: snapshot?.heroTag,
                ),
        ),
      ),
    );
  }
}

class _ProductBody extends ConsumerStatefulWidget {
  const _ProductBody({
    super.key,
    required this.product,
    required this.cartOwner,
    required this.heroTag,
  });
  final CatalogProduct product;
  final String cartOwner;
  final String? heroTag;

  @override
  ConsumerState<_ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends ConsumerState<_ProductBody> {
  static const _minimum = 1;
  var _quantity = _minimum;
  bool _adding = false;

  Future<void> _addToCart() async {
    if (_adding) return;
    setState(() => _adding = true);
    final result = await ref
        .read(cartRepositoryProvider)
        .add(widget.cartOwner, widget.product.id, _quantity);
    if (!mounted) return;
    setState(() => _adding = false);
    if (ModalRoute.isCurrentOf(context) != true) return;
    final strings = AppLocalizations.of(context);
    final router = GoRouter.of(context);
    final added = result is Success<void>;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(added ? strings.addedToCart : strings.cartUpdateFailed),
          action: added
              ? SnackBarAction(
                  label: strings.viewCart,
                  onPressed: () => router.push('/cart'),
                )
              : null,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final product = widget.product;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.md,
            ),
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: _QuantityStepper.height / 2,
                    ),
                    child: ProductDetailCard(
                      product: product,
                      heroTag: widget.heroTag,
                    ),
                  ),
                  _QuantityStepper(
                    quantity: _quantity,
                    onDecrease: !_adding && _quantity > _minimum
                        ? () => setState(() => _quantity--)
                        : null,
                    onIncrease: _adding
                        ? null
                        : () => setState(() => _quantity++),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl + AppSpacing.xs),
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
          child: PrimaryActionButton(
            label:
                '${strings.addToCart}  |  ${formatMmk(context, product.priceMmk * _quantity)}',
            busy: _adding,
            onPressed: _addToCart,
          ),
        ),
      ],
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });
  final int quantity;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;

  static const height = 64.0;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Container(
      height: height,
      alignment: Alignment.center,
      width: 176,
      decoration: const ShapeDecoration(
        color: AppColors.catalogSurface,
        shape: StadiumBorder(
          side: BorderSide(color: AppColors.white, width: 2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _button(strings.decreaseQuantity, Icons.remove_circle, onDecrease),
          SizedBox(
            width: 60,
            height: AppSpacing.xxl,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: AnimatedSwitcher(
                duration: AppMotion.duration(context, AppMotion.quick),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Text(
                  formatNumber(context, quantity),
                  key: ValueKey(quantity),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ),
          _button(strings.increaseQuantity, Icons.add_circle, onIncrease),
        ],
      ),
    );
  }

  Widget _button(String label, IconData icon, VoidCallback? tap) => IconButton(
    tooltip: label,
    onPressed: tap,
    color: AppColors.sky,
    disabledColor: AppColors.sky.withValues(alpha: .65),
    icon: Icon(icon, size: 38),
  );
}

class _Description extends StatelessWidget {
  const _Description({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: MediaQuery.textScalerOf(context).scale(67),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.help, size: 18, color: AppColors.helpGreen),
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
            padding: const EdgeInsets.only(left: AppSpacing.md),
            decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: AppColors.white)),
            ),
            child: ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.white, AppColors.descriptionFadeMask],
                stops: [.22, 1],
              ).createShader(bounds),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(height: 1.5, color: AppColors.ink),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
