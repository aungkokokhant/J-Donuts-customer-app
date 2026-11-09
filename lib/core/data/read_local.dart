import '../domain/result.dart';

Future<Result<T>> readLocal<T>(Future<T> Function() query) async {
  try {
    return Success(await query());
  } on Exception catch (error, stackTrace) {
    return Failure(LocalDataFailure(error, stackTrace));
  }
}
