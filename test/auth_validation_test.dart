import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts_customer_app/features/auth/domain/auth_validation.dart';

void main() {
  test('normalizes one leading zero, spaces and dashes', () {
    expect(normalizeMyanmarPhone('09 254-135592'), '+959254135592');
    expect(normalizeMyanmarPhone('91234567'), '+9591234567');
    expect(normalizeMyanmarPhone('9123456789'), '+959123456789');
    for (final value in [
      '009254135592',
      '812345678',
      '9123456',
      '91234567890',
    ]) {
      expect(normalizeMyanmarPhone(value), isNull, reason: value);
    }
  });

  test(
    'names accept Myanmar letters and combining marks but reject digits',
    () {
      expect(isValidName('  အောင် ခန့်  '), isTrue);
      expect(isValidName('Aung 1'), isFalse);
      expect(isValidName(''), isFalse);
      expect(isValidName('  ', optional: true), isTrue);
      expect(isValidName('a' * 50), isTrue);
      expect(isValidName('a' * 51), isFalse);
    },
  );

  test('birth dates enforce actual calendar dates and the 13th birthday', () {
    final today = DateTime(2026, 5, 1);
    expect(validBirthDate(2013, 5, 1, today), DateTime(2013, 5, 1));
    expect(validBirthDate(2013, 5, 2, today), isNull);
    expect(validBirthDate(2012, 2, 29, today), DateTime(2012, 2, 29));
    expect(validBirthDate(2011, 2, 29, today), isNull);
    expect(validBirthDate(2000, 4, 31, today), isNull);
    expect(validBirthDate(2027, 1, 1, today), isNull);
  });
}
