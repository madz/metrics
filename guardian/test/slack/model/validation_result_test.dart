import 'package:guardian/slack/model/validation_result.dart';
import 'package:test/test.dart';

void main() {
  group('ValidationResult', () {
    test(
      'combine() should return failed validation result '
      'combining valid and invalid results',
      () {
        final valid = ValidationResult.valid();
        final invalid = ValidationResult.invalid();
        final result = invalid.combine(valid);

        expect(result.isValid, isFalse);
      },
    );

    test(
      'combine() should return failed validation result '
      'combining invalid results',
      () {
        final invalidFirst = ValidationResult.invalid();
        final invalidSecond = ValidationResult.invalid();
        final result = invalidFirst.combine(invalidSecond);

        expect(result.isValid, isFalse);
      },
    );

    test(
      'combine() should return successful validation result '
      'combining valid results',
      () {
        final validFirst = ValidationResult.valid();
        final validSecond = ValidationResult.valid();
        final result = validFirst.combine(validSecond);

        expect(result.isValid, isTrue);
      },
    );

    test(
      'combine() should use first validation message of invalid results',
      () {
        final first = ValidationResult.invalid('first');
        final second = ValidationResult.valid('second');
        final third = ValidationResult.invalid('third');
        final result = first.combine(second).combine(third);

        expect(result.message, equals('first'));
      },
    );
  });
}
