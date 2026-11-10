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
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: AuthLayout.fieldInset,
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
        _nameField(
          _first,
          strings.firstName,
          strings.invalidName,
          focusNode: _firstFocus,
          showEmptyError: _firstBlurred,
        ),
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
    FocusNode? focusNode,
    bool showEmptyError = false,
  }) => TextField(
    controller: controller,
    focusNode: focusNode,
    enabled: !_busy,
    textCapitalization: TextCapitalization.words,
    decoration: InputDecoration(
      labelText: label,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: AuthLayout.fieldInset,
      errorText:
          (showEmptyError || controller.text.isNotEmpty) &&
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
      ],
    );
  }

  void _switchMode() => _update(() {
    _mode = AuthMode.register;
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
    safeTop: false,
    gradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColors.landingWhite, AppColors.landingPink],
      stops: [.53, .77],
    ),
    child: LayoutBuilder(
      builder: (context, limits) => SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: DonutArt(height: limits.maxHeight * .82, tiles: true),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                AuthLayout.pageInset,
                limits.maxHeight * .75,
                AuthLayout.pageInset,
                AppSpacing.lg,
              ),
              child: _welcomeActions(
                strings,
                gap: (limits.maxHeight * .05).clamp(
                  AppSpacing.lg,
                  AppSpacing.xxl,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _welcomeActions(AppLocalizations strings, {required double gap}) =>
      Column(
        children: [
          EnterMotion(
            index: 1,
            child: Text(
              strings.welcomeTitle,
              style: AuthLayout.heading(context),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: gap),
          EnterMotion(
            index: 2,
            child: PrimaryActionButton(
              label: strings.explore,
              onPressed: _submit,
              busy: _busy,
            ),
          ),
          _feedback(strings),
        ],
      );
}
