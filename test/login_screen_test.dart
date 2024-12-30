import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:projek_capstone7/page/auth/login.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('LoginScreen ditampilkan dengan benar', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    expect(find.text("Kulakan."), findsOneWidget);
    expect(find.text("Masuk ke Akunmu"), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text("Login"), findsOneWidget);
 
  });

  testWidgets('Mengklik Login akan menampilkan kesalahan jika kolom kosong', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    final loginButton = find.text("Login");
    await tester.tap(loginButton);
    await tester.pump(); 


    expect(find.text("Semua kolom harus diisi."), findsOneWidget);
  });

  testWidgets('Tapping Login with invalid email shows error', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    // Enter invalid email and password
    final emailField = find.byType(TextField).first;
    final passwordField = find.byType(TextField).last;
    await tester.enterText(emailField, 'nkj5@gmail.com');
    await tester.enterText(passwordField, 'Nkj12345');

    // Tap on login
    final loginButton = find.text("Login");
    await tester.tap(loginButton);
    await tester.pump();

    // Verify the error dialog for invalid email
    expect(find.text("Format email tidak valid."), findsOneWidget);
  });
}
