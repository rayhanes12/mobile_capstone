import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:projek_capstone7/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login success test', (WidgetTester tester) async {
    // Jalankan aplikasi
    app.main();
    await tester.pumpAndSettle();

    // Masukkan email dan password
    final emailField = find.byKey(Key("emailField"));
    final passwordField = find.byKey(Key("passwordField"));
    await tester.enterText(emailField, "test@example.com");
    await tester.enterText(passwordField, "password123");

    // Tekan tombol Login
    final loginButton = find.text("Login");
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Pastikan navigasi berhasil ke halaman Mainpage
    expect(find.text("Mainpage"), findsOneWidget);
  });
}
