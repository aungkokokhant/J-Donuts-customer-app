import '../../../core/domain/result.dart';

typedef RegisteredUser = ({
  String phone,
  String firstName,
  String lastName,
  DateTime birthDate,
});

abstract interface class AuthRepository {
  Future<Result<void>> requestCode(String phone);
  Future<Result<bool>> verifyCode(String phone, String code);
  Future<Result<RegisteredUser?>> findUser(String phone);
  Future<Result<void>> confirmName(String firstName, String lastName);
  Future<Result<bool>> register(RegisteredUser user);
  Future<Result<RegisteredUser?>> restoreSession();
  Future<Result<void>> saveSession(RegisteredUser user);
  Future<Result<void>> logout();
}
