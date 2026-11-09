part of 'auth_flow_page.dart';

extension _AuthFlowForm on _AuthFlowPageState {
  String _title(AppLocalizations strings) => switch (_step) {
    _Step.phone => strings.phoneTitle,
    _Step.otp => strings.verifyTitle,
    _Step.name => strings.nameTitle,
    _Step.birth => strings.birthTitle,
    _Step.welcome => strings.welcomeTitle,
  };

  Widget _form(AppLocalizations strings) => switch (_step) {
    _Step.phone => TextField(
      key: const Key('phoneInput'),
      controller: _phone,
      focusNode: _phoneFocus,
      enabled: !_busy,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: strings.phoneLabel,
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: AppSpacing.md, right: AppSpacing.sm),
          child: Align(
            widthFactor: 1,
            alignment: Alignment.center,
            child: Text(myanmarDialCode),
          ),
        ),
        errorText: _phoneBlurred && _normalizedPhone == null
            ? strings.invalidPhone
            : null,
      ),
      onChanged: (_) => _update(() => _problem = null),
      onTapOutside: (_) => _phoneFocus.unfocus(),
      onSubmitted: (_) => _submit(),
    ),
    _Step.otp => _otpForm(strings),
    _Step.name => Column(
      children: [
        _nameField(_first, strings.firstName, strings.invalidName),
        const SizedBox(height: AppSpacing.md),
        _nameField(
          _last,
          strings.lastName,
          strings.invalidName,
          optional: true,
        ),
      ],
    ),
    _Step.birth => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BirthFields(
          month: _month,
          onMonthChanged: (month) => _update(() => _month = month),
          day: _day,
          year: _year,
          onChanged: () => _update(() {}),
          enabled: !_busy,
        ),
        if (_month != null &&
            _day.text.isNotEmpty &&
            _year.text.length == 4 &&
            _birthDate == null)
          _error(strings.invalidBirthDate),
      ],
    ),
    _Step.welcome => const SizedBox.shrink(),
  };

  Widget _nameField(
    TextEditingController controller,
    String label,
    String error, {
    bool optional = false,
  }) => TextField(
    controller: controller,
    enabled: !_busy,
    textCapitalization: TextCapitalization.words,
    decoration: InputDecoration(
      labelText: label,
      errorText:
          controller.text.isNotEmpty &&
              !isValidName(controller.text, optional: optional)
          ? error
          : null,
    ),
    onChanged: (_) => _update(() {}),
  );

  Widget _otpForm(AppLocalizations strings) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(strings.verifyMessage(_sentTo!)),
      const SizedBox(height: AppSpacing.lg),
      OtpBoxes(
        controller: _code,
        onChanged: _codeChanged,
        enabled: !_locked && !_busy,
        shake: _shake,
        hasError: _problem == _Problem.wrongCode || _problem == _Problem.locked,
      ),
      const SizedBox(height: AppSpacing.md),
      Text(strings.otpMissing),
      if (_secondsLeft > 0)
        Text(
          strings.resendIn(_remaining),
          style: const TextStyle(color: AppColors.pink),
        )
      else
        TextButton(
          onPressed: _busy ? null : _resend,
          child: Text(strings.resend),
        ),
      if (_busy) const LinearProgressIndicator(),
    ],
  );

  String get _remaining {
    final minutes = _secondsLeft ~/ 60;
    final seconds = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Widget _feedback(AppLocalizations strings) {
    final label = switch (_problem) {
      _Problem.wrongCode => strings.otpWrong,
      _Problem.locked => strings.otpLocked,
      _Problem.unknownPhone => strings.unknownPhone,
      _Problem.registered => strings.alreadyRegistered,
      _Problem.other => strings.authError,
      null => null,
    };
    if (label == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _error(label),
        if (_problem == _Problem.unknownPhone)
          TextButton(onPressed: _switchMode, child: Text(strings.register)),
        if (_problem == _Problem.registered)
          TextButton(onPressed: _switchMode, child: Text(strings.logIn)),
      ],
    );
  }

  void _switchMode() => _update(() {
    _mode = _mode == AuthMode.login ? AuthMode.register : AuthMode.login;
    _problem = null;
    _step = _Step.phone;
  });

  Widget _error(String label) => Padding(
    padding: const EdgeInsets.only(top: AppSpacing.sm),
    child: Semantics(
      liveRegion: true,
      child: Text(label, style: const TextStyle(color: AppColors.error)),
    ),
  );

  Widget _welcome(AppLocalizations strings) => AuthBackground(
    child: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            const DonutArt(tiles: true),
            const SizedBox(height: AppSpacing.lg),
            EnterMotion(
              index: 1,
              child: Text(
                strings.welcomeTitle,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            EnterMotion(
              index: 2,
              child: AuthButton(
                label: strings.explore,
                onPressed: _submit,
                busy: _busy,
              ),
            ),
            _feedback(strings),
          ],
        ),
      ),
    ),
  );
}
