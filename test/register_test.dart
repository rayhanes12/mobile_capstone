import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projek_capstone7/page/auth/register.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient client;

  setUp(() {
    client = MockClient();
  });

  group('RegisterScreen Tests', () {
    testWidgets('Check UI components existence', (WidgetTester tester) async {
      // Render RegisterScreen
      await tester.pumpWidget(MaterialApp(home: RegisterScreen()));

      // Check header
      expect(find.text('Kulakan.'), findsOneWidget);
      expect(find.text('Buat Akun Pertamamu'), findsOneWidget);

      // Check form fields
      expect(find.byType(TextField), findsNWidgets(3));
      expect(find.text('Full name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);

      // Check Register button
      expect(find.text('Daftar'), findsOneWidget);

      // Check navigation text
      expect(find.text('Sudah punya akun?'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('Show error on empty fields', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: RegisterScreen()));

      // Tap the register button without input
      await tester.tap(find.text('Daftar'));
      await tester.pump();

      // Ensure error dialog is shown
      expect(find.text('Semua kolom harus diisi.'), findsOneWidget);
    });

    testWidgets('Show error on invalid email format', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: RegisterScreen()));

      // Enter name and password, but invalid email
      await tester.enterText(find.byType(TextField).at(0), 'John Doe'); // Name
      await tester.enterText(find.byType(TextField).at(1), 'john.doe'); // Invalid Email
      await tester.enterText(find.byType(TextField).at(2), 'password123'); // Password
      await tester.tap(find.text('Daftar'));
      await tester.pump();

      // Ensure error dialog is shown
      expect(find.text('Format email tidak valid.'), findsOneWidget);
    });

    testWidgets('Show error on short password', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: RegisterScreen()));

      // Enter valid name and email, but short password
      await tester.enterText(find.byType(TextField).at(0), 'John Doe');
      await tester.enterText(find.byType(TextField).at(1), 'john.doe@example.com');
      await tester.enterText(find.byType(TextField).at(2), '123'); // Short password
      await tester.tap(find.text('Daftar'));
      await tester.pump();

      // Ensure error dialog is shown
      expect(find.text('Password minimal 6 karakter.'), findsOneWidget);
    });

    testWidgets('Successful registration flow', (WidgetTester tester) async {
      // Mock API response
      when(client.post(
        Uri.parse('http://127.0.0.1:5000/api/register'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('{"message": "Pendaftaran berhasil."}', 201));

      await tester.pumpWidget(MaterialApp(home: RegisterScreen()));

      // Enter valid data
      await tester.enterText(find.byType(TextField).at(0), 'John Doe'); // Name
      await tester.enterText(find.byType(TextField).at(1), 'john.doe@example.com'); // Email
      await tester.enterText(find.byType(TextField).at(2), 'password123'); // Password
      await tester.tap(find.text('Daftar'));
      await tester.pump();

      // Ensure success dialog is shown
      expect(find.text('Sukses'), findsOneWidget);
      expect(find.text('Pendaftaran berhasil.'), findsOneWidget);
    });
  });
}
