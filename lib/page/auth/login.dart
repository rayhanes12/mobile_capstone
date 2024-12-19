import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projek_capstone7/page/auth/register.dart';
import 'package:projek_capstone7/page/mainpage/mainpage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  Future<void> _login(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Validasi input
    if (email.isEmpty || password.isEmpty) {
      _showDialog(context, "Error", "Semua kolom harus diisi.");
      return;
    }

    if (!_isValidEmail(email)) {
      _showDialog(context, "Error", "Format email tidak valid.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/api/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print("Status Code: \${response.statusCode}");
      print("Response Body: \${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Login berhasil
        final res = jsonDecode(response.body);
        _showDialog(context, "Sukses", res['message']).then((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Mainpage()),
          );
        });
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        // Kesalahan validasi
        final res = jsonDecode(response.body);
        _showDialog(context, "Error", res['message'] ?? "Validasi gagal.");
      } else {
        // Kesalahan umum
        _showDialog(context, "Error", "Terjadi kesalahan server.");
      }
    } catch (e) {
      print("Exception: \$e");
      _showDialog(context, "Error", "Gagal terhubung ke server. Coba lagi.");
    }
  }

  Future<void> _showDialog(BuildContext context, String title, String message) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header dengan ilustrasi
            Container(
              color: Color(0xFF69BF5E),
              width: double.infinity,
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: Image.asset(
                  'assets/login_image.png',
                  height: 200,
                ),
              ),
            ),
            // Form Input
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kulakan.",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF69BF5E),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Masuk ke Akunmu",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildRoundedTextField(
                    "Email",
                    Icons.email,
                    false,
                    _emailController,
                  ),
                  SizedBox(height: 20),
                  _buildRoundedTextField(
                    "Password",
                    Icons.lock,
                    true,
                    _passwordController,
                  ),
                  SizedBox(height: 30),
                  _buildLoginButton(context),
                  SizedBox(height: 20),
                  _buildNoAccountText(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedTextField(String hintText, IconData icon,
      bool obscureText, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding:
            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon, color: Colors.black54),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _login(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF69BF5E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 15.0),
      ),
      child: Center(
        child: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    );
  }

  Widget _buildNoAccountText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Belum punya akun? ",
          style: TextStyle(color: Colors.black54),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          },
          child: Text(
            "Daftar",
            style: TextStyle(
              color: Color(0xFF69BF5E),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
