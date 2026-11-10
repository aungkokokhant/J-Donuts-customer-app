import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/design/app_theme.dart';
import '../../../app/repository_providers.dart';
import '../../../core/domain/result.dart';
import '../../../core/presentation/catalog_image.dart';
import '../../../core/presentation/catalog_price.dart';
import '../../../core/presentation/catalog_state.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/cart_repository.dart';

final _cartProvider = StreamProvider.autoDispose
    .family<Result<List<CartLine>>, String>(
      (ref, owner) => ref.watch(cartRepositoryProvider).watch(owner),
    );

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key, required this.owner});

  final String owner;

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  bool _updating = false;

  Future<void> _changeQuantity(
    String productId, {
    required bool increase,
  }) async {
    if (_updating) return;
    final repository = ref.read(cartRepositoryProvider);
    setState(() => _updating = true);
    final result = increase
        ? await repository.add(widget.owner, productId, 1)
        : await repository.decrease(widget.owner, productId);
    if (!mounted) return;
    setState(() => _updating = false);
    if (result is Failure<void>) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).cartUpdateFailed)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final provider = _cartProvider(widget.owner);
    return Scaffold(
      backgroundColor: AppColors.catalogSurface,
      appBar: AppBar(
        backgroundColor: AppColors.catalogSurface,
        title: Text(strings.cartTitle),
        leading: BackButton(
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/home'),
        ),
      ),
      body: SafeArea(
        top: false,
        child: CatalogState(
          value: ref.watch(provider),
          isEmpty: (_) => false,
          retry: () => ref.invalidate(provider),
          height: 140,
          buildData: (lines) => lines.isEmpty
              ? Center(child: Text(strings.cartEmpty))
              : _cartContent(context, lines),
        ),
      ),
    );
  }

  Widget _cartContent(BuildContext context, List<CartLine> lines) {
    final total = lines.fold(
      0,
      (sum, line) => sum + line.product.priceMmk * line.quantity,
    );
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: lines.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (_, index) => _CartItem(
              line: lines[index],
              onIncrease: _updating
                  ? null
                  : () => _changeQuantity(
                      lines[index].product.id,
                      increase: true,
                    ),
              onDecrease: _updating
                  ? null
                  : () => _changeQuantity(
                      lines[index].product.id,
                      increase: false,
                    ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Wrap(
            spacing: AppSpacing.md,
            children: [
              Text(AppLocalizations.of(context).cartTotal),
              Text(
                formatMmk(context, total),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({required this.line, this.onIncrease, this.onDecrease});

  final CartLine line;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;

  @override
  Widget build(BuildContext context) {
    final product = line.product;
    final strings = AppLocalizations.of(context);
    return Card(
      margin: EdgeInsets.zero,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            SizedBox.square(
              dimension: AppSpacing.xxl,
              child: CatalogImage(source: product.imageKey),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: _details(context)),
            IconButton(
              tooltip: line.quantity == 1
                  ? strings.removeFromCart
                  : strings.decreaseQuantity,
              onPressed: onDecrease,
              icon: Icon(
                line.quantity == 1 ? Icons.delete_outline : Icons.remove,
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppSpacing.xxl),
              child: Text(
                formatNumber(context, line.quantity),
                key: ValueKey('cart-quantity:${product.id}'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              tooltip: strings.increaseQuantity,
              onPressed: onIncrease,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }

  Widget _details(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(line.product.name, style: Theme.of(context).textTheme.titleMedium),
      Text(formatMmk(context, line.product.priceMmk * line.quantity)),
    ],
  );
}
