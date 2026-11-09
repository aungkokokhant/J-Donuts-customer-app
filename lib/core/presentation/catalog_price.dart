import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';

String formatNumber(BuildContext context, int value) =>
    NumberFormat.decimalPattern(AppLocalizations.of(context).localeName)
        .format(value);

String formatMmk(BuildContext context, int amount) =>
    AppLocalizations.of(context).priceMmk(formatNumber(context, amount));
