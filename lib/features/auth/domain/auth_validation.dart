const myanmarDialCode = '+95';
const minimumAge = 13;
const otpLength = 6;
const fakeOtp = '123456';
const maximumOtpAttempts = 3;
const resendDelay = Duration(minutes: 5);
const maximumNameLength = 50;

final _localPhone = RegExp(r'^9[0-9]{7,9}$');
final _phoneSeparators = RegExp(r'[\s-]');
final _nameLetters = RegExp(r'^[\p{L}\p{M} ]+$', unicode: true);
final _letter = RegExp(r'\p{L}', unicode: true);

String? normalizeMyanmarPhone(String input) {
  var number = input.replaceAll(_phoneSeparators, '');
  if (number.startsWith('0')) number = number.substring(1);
  return _localPhone.hasMatch(number) ? '$myanmarDialCode$number' : null;
}

bool isValidName(String input, {bool optional = false}) {
  final name = input.trim();
  if (name.isEmpty) return optional;
  return name.runes.length <= maximumNameLength &&
      _letter.hasMatch(name) &&
      _nameLetters.hasMatch(name);
}

DateTime? validBirthDate(int year, int month, int day, DateTime today) {
  if (year < 1 ||
      year > today.year ||
      month < 1 ||
      month > 12 ||
      day < 1 ||
      day > 31) {
    return null;
  }
  final date = DateTime(year, month, day);
  if (date.year != year || date.month != month || date.day != day) return null;
  final age = today.year - year;
  final birthdayReached =
      month < today.month || (month == today.month && day <= today.day);
  return age > minimumAge || (age == minimumAge && birthdayReached)
      ? date
      : null;
}
