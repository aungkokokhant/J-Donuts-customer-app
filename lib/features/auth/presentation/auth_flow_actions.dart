part of 'auth_flow_page.dart';

extension _AuthFlowActions on _AuthFlowPageState {
  bool get _canContinue => switch (_step) {
    _Step.phone => _normalizedPhone != null,
    _Step.otp => false,
    _Step.name =>
      isValidName(_first.text) && isValidName(_last.text, optional: true),
    _Step.birth => _birthDate != null,
    _Step.welcome => _registeredUser != null,
  };

  void _goBack() {
    if (_busy) return;
    if (_step == _Step.phone) {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/');
      }
      return;
    }
    _update(() {
      _step = _Step.values[_step.index - 1];
      _problem = null;
    });
  }

  Future<void> _run(Future<void> Function() action) async {
    if (_busy) return;
    _update(() {
      _busy = true;
      _problem = null;
    });
    try {
      await action();
    } finally {
      _update(() => _busy = false);
    }
  }

  void _submit() {
    if (!_canContinue || _busy) return;
    switch (_step) {
      case _Step.phone:
        unawaited(_run(() => _sendCode(_normalizedPhone!)));
      case _Step.name:
        unawaited(_run(_confirmName));
      case _Step.birth:
        unawaited(_run(_registerUser));
      case _Step.welcome:
        unawaited(_run(() => _signIn(_registeredUser!)));
      case _Step.otp:
        break;
    }
  }

  Future<void> _confirmName() async {
    final result = await widget.repository.confirmName(_first.text, _last.text);
    _update(() {
      if (result is Failure<void>) {
        _problem = _Problem.other;
      } else {
        _step = _Step.birth;
      }
    });
  }

  Future<void> _sendCode(String phone, {bool resend = false}) async {
    if (_sentTo != phone || resend) {
      final result = await widget.repository.requestCode(phone);
      if (!mounted) return;
      if (result is Failure<void>) {
        _update(() => _problem = _Problem.other);
        return;
      }
      _sentTo = phone;
      _code.clear();
      _wrongAttempts = 0;
      _shake = 0;
      _startTimer();
    }
    _update(() {
      _step = _Step.otp;
      if (_locked) _problem = _Problem.locked;
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsLeft = resendDelay.inSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _update(() => _secondsLeft = resendDelay.inSeconds - timer.tick);
      if (_secondsLeft <= 0) timer.cancel();
    });
  }

  void _resend() {
    if (_secondsLeft > 0 || _busy || _sentTo == null) return;
    unawaited(_run(() => _sendCode(_sentTo!, resend: true)));
  }

  void _codeChanged(String value) {
    if (_busy || _locked) return;
    _update(() => _problem = null);
    if (value.length == otpLength) {
      unawaited(_run(() => _verify(value)));
    }
  }

  Future<void> _verify(String code) async {
    final phone = _sentTo!;
    final result = await widget.repository.verifyCode(phone, code);
    if (!mounted) return;
    switch (result) {
      case Failure():
        _code.clear();
        _update(() => _problem = _Problem.other);
      case Success(value: false):
        _code.clear();
        _update(() {
          _wrongAttempts++;
          _shake++;
          _problem = _locked ? _Problem.locked : _Problem.wrongCode;
        });
      case Success(value: true):
        _code.clear();
        await _resolveVerifiedPhone(
          phone,
          allowRegistration: _mode == AuthMode.register,
        );
    }
  }

  Future<void> _resolveVerifiedPhone(
    String phone, {
    required bool allowRegistration,
  }) async {
    final result = await widget.repository.findUser(phone);
    if (!mounted) return;
    switch (result) {
      case Failure():
        _update(() => _problem = _Problem.other);
      case Success(value: null):
        _update(() {
          if (allowRegistration) {
            _step = _Step.name;
          } else {
            _problem = _Problem.unknownPhone;
          }
        });
      case Success(:final value):
        await _signIn(value!);
    }
  }

  Future<void> _registerUser() async {
    final user = (
      phone: _sentTo!,
      firstName: _first.text.trim(),
      lastName: _last.text.trim(),
      birthDate: _birthDate!,
    );
    final result = await widget.repository.register(user);
    if (!mounted) return;
    switch (result) {
      case Failure():
        _update(() => _problem = _Problem.other);
      case Success(value: false):
        await _resolveVerifiedPhone(user.phone, allowRegistration: false);
      case Success(value: true):
        _update(() {
          _registeredUser = user;
          _step = _Step.welcome;
        });
    }
  }

  Future<void> _signIn(RegisteredUser user) async {
    final signedIn = await widget.session.signIn(user);
    if (!mounted) return;
    if (signedIn) {
      context.go('/home');
    } else {
      _update(() => _problem = _Problem.other);
    }
  }
}
