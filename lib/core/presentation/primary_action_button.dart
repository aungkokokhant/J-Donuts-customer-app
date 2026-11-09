import 'package:flutter/material.dart';

import '../../app/design/app_motion.dart';
import '../../app/design/app_theme.dart';

class PrimaryActionButton extends StatefulWidget {
  const PrimaryActionButton({
    super.key,
    required this.label,
    this.onPressed,
    this.busy = false,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool busy;

  @override
  State<PrimaryActionButton> createState() => _PrimaryActionButtonState();
}

class _PrimaryActionButtonState extends State<PrimaryActionButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null && !widget.busy;
    final duration = AppMotion.duration(context, AppMotion.quick);
    return Listener(
      onPointerDown: enabled ? (_) => setState(() => _pressed = true) : null,
      onPointerUp: (_) => setState(() => _pressed = false),
      onPointerCancel: (_) => setState(() => _pressed = false),
      child: AnimatedScale(
        duration: duration,
        scale: _pressed && enabled && duration != Duration.zero ? .97 : 1,
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: enabled ? widget.onPressed : null,
            style: FilledButton.styleFrom(
              foregroundColor: AppColors.white,
              textStyle: AppTypography.primaryButton.copyWith(
                letterSpacing: .75,
              ),
            ),
            child: AnimatedSwitcher(
              duration: duration,
              child: widget.busy
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(widget.label.toUpperCase()),
            ),
          ),
        ),
      ),
    );
  }
}
