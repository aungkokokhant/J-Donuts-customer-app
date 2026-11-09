import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../core/domain/result.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_validation.dart';
import 'auth_chrome.dart';
import 'birth_fields.dart';
import 'donut_art.dart';
import 'otp_boxes.dart';
import 'session_controller.dart';

part 'auth_flow_actions.dart';
part 'auth_flow_form.dart';

enum AuthMode { register, login }

enum _Step { phone, otp, name, birth, welcome }

enum _Problem { wrongCode, locked, unknownPhone, registered, other }

class AuthFlowPage extends StatefulWidget {
  const AuthFlowPage({
    super.key,
    required this.mode,
    required this.repository,
    required this.session,
  });

  final AuthMode mode;
  final AuthRepository repository;
  final SessionController session;

  @override
  State<AuthFlowPage> createState() => _AuthFlowPageState();
}

class _AuthFlowPageState extends State<AuthFlowPage> {
  late AuthMode _mode = widget.mode;
  _Step _step = _Step.phone;
  _Problem? _problem;
  final _phone = TextEditingController();
  final _code = TextEditingController();
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _day = TextEditingController();
  final _year = TextEditingController();
  final _phoneFocus = FocusNode();
  bool _phoneBlurred = false;
  bool _busy = false;
  int? _month;
  int _wrongAttempts = 0;
  int _shake = 0;
  int _secondsLeft = 0;
  Timer? _timer;
  String? _sentTo;
  RegisteredUser? _registeredUser;

  bool get _locked => _wrongAttempts >= maximumOtpAttempts;
  String? get _normalizedPhone => normalizeMyanmarPhone(_phone.text);
  DateTime? get _birthDate => validBirthDate(
    int.tryParse(_year.text) ?? 0,
    _month ?? 0,
    int.tryParse(_day.text) ?? 0,
    DateTime.now(),
  );

  @override
  void initState() {
    super.initState();
    _phoneFocus.addListener(() {
      if (!_phoneFocus.hasFocus) _update(() => _phoneBlurred = true);
    });
  }

  void _update(VoidCallback update) {
    if (mounted) setState(update);
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final controller in [_phone, _code, _first, _last, _day, _year]) {
      controller.dispose();
    }
    _phoneFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    if (_step == _Step.welcome) return _welcome(strings);
    return PopScope(
      canPop: _step == _Step.phone && !_busy,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _goBack();
      },
      child: AuthBackground(
        child: LayoutBuilder(
          builder: (context, limits) => SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: (limits.maxHeight - AppSpacing.lg * 2).clamp(
                  0,
                  double.infinity,
                ),
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _header(),
                    const SizedBox(height: AppSpacing.xl),
                    _switchingForm(strings),
                    const Spacer(),
                    if (_step != _Step.otp)
                      AuthButton(
                        label: strings.continueLabel,
                        busy: _busy,
                        onPressed: _canContinue ? _submit : null,
                      ),
                    const SizedBox(height: AppSpacing.lg),
                    const AuthLegal(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      BackButton(onPressed: _busy ? () {} : _goBack),
      if (_mode == AuthMode.register) RegistrationRing(step: _step.index + 1),
    ],
  );

  Widget _switchingForm(AppLocalizations strings) => AnimatedSwitcher(
    duration: AppMotion.duration(context, AppMotion.step),
    transitionBuilder: (child, animation) => FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween(
          begin: const Offset(.10, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: AppMotion.curve)),
        child: child,
      ),
    ),
    child: Column(
      key: ValueKey(_step),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(_title(strings), style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: AppSpacing.lg),
        _form(strings),
        _feedback(strings),
      ],
    ),
  );
}
