import 'package:flutter_test/flutter_test.dart';
import 'package:projek_capstone7/page/auth/login.dart';

void main() {
  group('LoginScreen - Email Validation', () {
    test('Valid email', () {
      expect(LoginScreen.isValidEmail('test@example.com'), true);
    });

    test('invalid email', () {
      expect(LoginScreen.isValidEmail('testexample.com'), false);
    });

    test('invalid email 2', () {
      expect(LoginScreen.isValidEmail('test@'), false);
    });
  });
}
