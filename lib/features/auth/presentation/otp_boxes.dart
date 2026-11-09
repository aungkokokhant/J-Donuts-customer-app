import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/auth_validation.dart';

class OtpBoxes extends StatelessWidget {
  const OtpBoxes({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.enabled,
    required this.shake,
    required this.hasError,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool enabled;
  final int shake;
  final bool hasError;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    key: ValueKey(shake),
    tween: Tween(begin: shake == 0 ? 1 : 0, end: 1),
    duration: AppMotion.duration(context, AppMotion.shake),
    child: _input(context),
    builder: (context, value, child) => Transform.translate(
      offset: Offset(math.sin(value * math.pi * 6) * (1 - value) * 10, 0),
      child: child,
    ),
  );

  Widget _input(BuildContext context) {
    final label = AppLocalizations.of(context).otpLabel;
    return SizedBox(
      height: 58,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ExcludeSemantics(
            child: IgnorePointer(
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller,
                builder: (context, input, _) => _digits(context, input.text),
              ),
            ),
          ),
          Semantics(
            label: label,
            child: TextField(
              key: const Key('otpInput'),
              controller: controller,
              enabled: enabled,
              autofocus: true,
              keyboardType: TextInputType.number,
              autofillHints: const [AutofillHints.oneTimeCode],
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(otpLength),
              ],
              showCursor: false,
              style: const TextStyle(color: Colors.transparent),
              decoration: const InputDecoration(
                filled: false,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _digits(BuildContext context, String code) => Row(
    children: [
      for (var index = 0; index < otpLength; index++) ...[
        if (index > 0) const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: AnimatedContainer(
            duration: AppMotion.duration(context, AppMotion.quick),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSpacing.fieldRadius),
              border: Border.all(
                color: hasError
                    ? AppColors.error
                    : index == code.length && enabled
                    ? AppColors.sky
                    : AppColors.white,
              ),
            ),
            child: Text(
              index < code.length ? code[index] : '',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ],
    ],
  );
}
