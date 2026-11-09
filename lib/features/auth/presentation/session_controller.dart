import 'package:flutter/foundation.dart';

import '../../../core/domain/result.dart';
import '../domain/auth_repository.dart';

class SessionController extends ChangeNotifier {
  SessionController(this._repository);

  final AuthRepository _repository;
  RegisteredUser? user;
  bool loading = true;
  bool failed = false;
  bool _disposed = false;

  Future<void> restore() async {
    loading = true;
    failed = false;
    notifyListeners();
    final result = await _repository.restoreSession();
    if (_disposed) return;
    loading = false;
    switch (result) {
      case Success(:final value):
        user = value;
      case Failure():
        failed = true;
    }
    notifyListeners();
  }

  Future<bool> signIn(RegisteredUser registeredUser) async {
    final result = await _repository.saveSession(registeredUser);
    if (_disposed || result is Failure<void>) return false;
    user = registeredUser;
    notifyListeners();
    return true;
  }

  Future<bool> logout() async {
    final result = await _repository.logout();
    if (_disposed || result is Failure<void>) return false;
    user = null;
    notifyListeners();
    return true;
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
