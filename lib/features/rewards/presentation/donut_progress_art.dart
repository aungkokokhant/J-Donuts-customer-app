import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../core/presentation/catalog_image.dart';

class DonutProgressArt extends StatefulWidget {
  const DonutProgressArt({super.key, required this.source, required this.fill});

  final String source;
  final double fill;

  @override
  State<DonutProgressArt> createState() => _DonutProgressArtState();
}

class _DonutProgressArtState extends State<DonutProgressArt> {
  ImageStream? _stream;
  ImageInfo? _image;
  bool _failed = false;

  late final _listener = ImageStreamListener(
    (image, synchronous) {
      if (synchronous) {
        _replaceImage(image);
      } else {
        setState(() => _replaceImage(image));
      }
    },
    onError: (error, stack) => setState(() {
      _replaceImage(null);
      _failed = true;
    }),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolveImage();
  }

  @override
  void didUpdateWidget(DonutProgressArt oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.source != oldWidget.source) _resolveImage();
  }

  void _resolveImage() {
    final next = CatalogImage.rasterProviderFor(widget.source)
        ?.resolve(createLocalImageConfiguration(context));
    if (_stream?.key == next?.key) return;
    _stream?.removeListener(_listener);
    _stream = next;
    _replaceImage(null);
    next?.addListener(_listener);
  }

  void _replaceImage(ImageInfo? image) {
    final old = _image;
    if (old != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => old.dispose());
    }
    _image = image;
    _failed = false;
  }

  @override
  void dispose() {
    _stream?.removeListener(_listener);
    _image?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = _image?.image;
    if (_stream == null) return CatalogImage(source: widget.source);
    if (image == null) return CatalogImagePlaceholder(failed: _failed);
    return CustomPaint(painter: _DonutProgressPainter(image, widget.fill));
  }
}

class _DonutProgressPainter extends CustomPainter {
  const _DonutProgressPainter(this.image, this.fill);

  final ui.Image image;
  final double fill;

  static const _frosted = ColorFilter.matrix(<double>[
    .0680,
    .2289,
    .0231,
    0,
    166,
    .0680,
    .2289,
    .0231,
    0,
    166,
    .0680,
    .2289,
    .0231,
    0,
    166,
    0,
    0,
    0,
    1,
    0,
  ]);

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;
    if (fill < 1) _draw(canvas, bounds, _frosted);
    if (fill <= 0) return;
    canvas.save();
    if (fill < 1) canvas.clipPath(_sector(size));
    _draw(canvas, bounds);
    canvas.restore();
  }

  Path _sector(Size size) {
    final center = size.center(Offset.zero);
    return Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: size.longestSide),
        -math.pi / 2,
        math.pi * 2 * fill,
        false,
      )
      ..close();
  }

  void _draw(Canvas canvas, Rect bounds, [ColorFilter? filter]) => paintImage(
    canvas: canvas,
    rect: bounds,
    image: image,
    fit: BoxFit.contain,
    colorFilter: filter,
  );

  @override
  bool shouldRepaint(_DonutProgressPainter oldDelegate) =>
      image != oldDelegate.image || fill != oldDelegate.fill;
}
