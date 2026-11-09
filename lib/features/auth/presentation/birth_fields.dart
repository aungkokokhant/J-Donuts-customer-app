import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../app/design/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class BirthFields extends StatelessWidget {
  const BirthFields({
    super.key,
    required this.month,
    required this.onMonthChanged,
    required this.day,
    required this.year,
    required this.onChanged,
    required this.enabled,
  });

  final int? month;
  final ValueChanged<int?> onMonthChanged;
  final TextEditingController day;
  final TextEditingController year;
  final VoidCallback onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final monthFormat = DateFormat.MMMM(strings.localeName);
    return Column(
      children: [
        DropdownButtonFormField<int>(
          key: const Key('birthMonth'),
          initialValue: month,
          isExpanded: true,
          decoration: InputDecoration(labelText: strings.month),
          items: [
            for (var value = 1; value <= DateTime.monthsPerYear; value++)
              DropdownMenuItem(
                value: value,
                child: Text(monthFormat.format(DateTime(2000, value))),
              ),
          ],
          onChanged: enabled ? onMonthChanged : null,
        ),
        const SizedBox(height: AppSpacing.md),
        _numberField(day, strings.day, 2),
        const SizedBox(height: AppSpacing.md),
        _numberField(year, strings.year, 4),
      ],
    );
  }

  Widget _numberField(
    TextEditingController controller,
    String label,
    int digits,
  ) => TextField(
    controller: controller,
    enabled: enabled,
    decoration: InputDecoration(labelText: label),
    keyboardType: TextInputType.number,
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(digits),
    ],
    onChanged: (_) => onChanged(),
  );
}
