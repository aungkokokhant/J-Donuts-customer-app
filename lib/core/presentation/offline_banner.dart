import 'package:flutter/material.dart';

import '../../app/design/app_theme.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: AppColors.blush,
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          const Icon(Icons.cloud_off_outlined, size: 18),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    ),
  );
}
