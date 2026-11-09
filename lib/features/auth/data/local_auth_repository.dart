import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/data/app_database.dart' hide RegisteredUser;
import '../../../core/data/read_local.dart';
import '../../../core/domain/result.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_validation.dart';

final class LocalAuthRepository implements AuthRepository {
  const LocalAuthRepository(this._database, this._storage);

  static const sessionKey = 'jdonuts.session.phone';
  static const _delay = Duration(seconds: 1);

  final AppDatabase _database;
  final FlutterSecureStorage _storage;

  @override
  Future<Result<void>> requestCode(String phone) => readLocal(() async {
    await Future<void>.delayed(_delay);
    if (!phone.startsWith(myanmarDialCode)) {
      throw const FormatException('Expected an international Myanmar number');
    }
  });

  @override
  Future<Result<bool>> verifyCode(String phone, String code) async {
    await Future<void>.delayed(_delay);
    return Success(code == fakeOtp);
  }

  @override
  Future<Result<void>> confirmName(String firstName, String lastName) =>
      readLocal(() async {
        await Future<void>.delayed(_delay);
        if (!isValidName(firstName) || !isValidName(lastName, optional: true)) {
          throw const FormatException('Invalid name');
        }
      });

  @override
  Future<Result<RegisteredUser?>> findUser(String phone) =>
      readLocal(() => _findUser(phone));

  Future<RegisteredUser?> _findUser(String phone) async {
    final query = _database.select(_database.registeredUsers)
      ..where((row) => row.phone.equals(phone));
    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return (
      phone: row.phone,
      firstName: row.firstName,
      lastName: row.lastName,
      birthDate: row.birthDate,
    );
  }

  @override
  Future<Result<bool>> register(RegisteredUser user) => readLocal(() async {
    await Future<void>.delayed(_delay);
    return _database.transaction(() async {
      if (await _findUser(user.phone) != null) return false;
      await _database
          .into(_database.registeredUsers)
          .insert(
            RegisteredUsersCompanion.insert(
              phone: user.phone,
              firstName: user.firstName,
              lastName: user.lastName,
              birthDate: user.birthDate,
            ),
          );
      return true;
    });
  });

  @override
  Future<Result<RegisteredUser?>> restoreSession() => readLocal(() async {
    final phone = await _storage.read(key: sessionKey);
    if (phone == null) return null;
    return _findUser(phone);
  });

  @override
  Future<Result<void>> saveSession(RegisteredUser user) =>
      readLocal(() => _storage.write(key: sessionKey, value: user.phone));

  @override
  Future<Result<void>> logout() =>
      readLocal(() => _storage.delete(key: sessionKey));
}
