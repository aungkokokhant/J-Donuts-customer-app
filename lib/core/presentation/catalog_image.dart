import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/design/app_theme.dart';
import 'donut_photos.dart';

class CatalogImage extends StatelessWidget {
  const CatalogImage({
    super.key,
    required this.source,
    this.fit = BoxFit.contain,
  });

  final String source;
  final BoxFit fit;

  static const _photoSources = {
    'coconut_donut': DonutPhotos.chocolateDrizzle,
    'strawberry_donut': DonutPhotos.pink,
    'challenge_donut': DonutPhotos.pink,
    'challenge_coffee': 'assets/images/catalog/iced-coffee.webp',
    'dalgona_coffee': 'assets/images/catalog/iced-coffee.webp',
    'central_boulevard': 'assets/images/catalog/bakery.webp',
    'donut_shop': 'assets/images/catalog/bakery.webp',
    'holiday_specials': 'assets/images/catalog/donut-assortment.webp',
    'mistletoe_box': 'assets/images/catalog/donut-assortment.webp',
    'member_avatar': 'assets/images/catalog/member.webp',
  };

  @override
  Widget build(BuildContext context) {
    if (source.startsWith('https://') || source.startsWith('http://')) {
      return CachedNetworkImage(
        imageUrl: source,
        fit: fit,
        placeholder: (_, _) => const _ImageFallback(),
        errorWidget: (_, _, _) => const _ImageFallback(failed: true),
      );
    }
    final photo = _photoSources[source];
    if (photo != null) {
      return Image.asset(
        photo,
        fit: fit,
        frameBuilder: (_, child, frame, loadedSynchronously) =>
            loadedSynchronously || frame != null
            ? child
            : const _ImageFallback(),
        errorBuilder: (_, _, _) => const _ImageFallback(failed: true),
      );
    }
    return SvgPicture.asset(
      'assets/images/$source.svg',
      fit: fit,
      placeholderBuilder: (_) => const _ImageFallback(),
      errorBuilder: (_, _, _) => const _ImageFallback(failed: true),
    );
  }
}

class _ImageFallback extends StatelessWidget {
  const _ImageFallback({this.failed = false});
  final bool failed;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: AppColors.catalogSurface,
    child: Center(
      child: Icon(
        failed ? Icons.broken_image_outlined : Icons.image_outlined,
        color: AppColors.muted,
      ),
    ),
  );
}
