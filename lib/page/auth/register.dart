import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projek_capstone7/page/auth/login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return regex.hasMatch(email);
  }

  Future<void> _register(BuildContext context) async {
  final name = _nameController.text.trim();
  final email = _emailController.text.trim();
  final password = _passwordController.text.trim();

  // Validasi Input
  if (name.isEmpty || email.isEmpty || password.isEmpty) {
    _showDialog(context, "Error", "Semua kolom harus diisi.");
    return;
  }

  if (!_isValidEmail(email)) {
    _showDialog(context, "Error", "Format email tidak valid.");
    return;
  }

  if (password.length < 6) {
    _showDialog(context, "Error", "Password minimal 6 karakter.");
    return;
  }

  setState(() {
    _isLoading = true;
  });

  try {
    final response = await http.post(
      Uri.parse('https://kulakan.cy4lsr.my.id/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Jika respons berhasil
      final res = jsonDecode(response.body);

      if (res.containsKey('message')) {
        _showDialog(context, "Sukses", res['message']).then((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        });
      } else {
        _showDialog(context, "Sukses", "Pendaftaran berhasil.");
      }
    } else if (response.statusCode == 422) {
      // Kesalahan validasi
      final res = jsonDecode(response.body);
      _showDialog(context, "Error", res['message'] ?? "Validasi gagal.");
    } else {
      // Kesalahan umum
      _showDialog(context, "Error", "Terjadi kesalahan server.");
    }
  } catch (e) {
    setState(() {
      _isLoading = false;
    });
    print("Exception: $e");
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
                    "Buat Akun Pertamamu",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildRoundedTextField(
                    "Full name",
                    Icons.person,
                    false,
                    _nameController,
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
                  _buildRegisterButton(context),
                  SizedBox(height: 20),
                  _buildAlreadyHaveAccountText(context),
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

  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : () => _register(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF69BF5E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 15.0),
      ),
      child: Center(
        child: _isLoading
            ? CircularProgressIndicator(color: Colors.white)
            : Text(
                "Daftar",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
      ),
    );
  }

  Widget _buildAlreadyHaveAccountText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Sudah punya akun? ",
          style: TextStyle(color: Colors.black54),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            "Login",
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