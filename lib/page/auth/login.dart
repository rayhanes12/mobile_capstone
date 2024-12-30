import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projek_capstone7/models/user.dart';
import 'package:projek_capstone7/page/auth/register.dart';
import 'package:projek_capstone7/page/mainpage/mainpage.dart';
import 'package:projek_capstone7/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    email = email.trim();
    return regex.hasMatch(email);
  }

  Future<void> _login(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (!_isValidEmail(email)) {
      _showDialog(context, "Error", "Format email tidak valid.");
      return;
    }

    if (password.isEmpty || password.length < 6) {
      _showDialog(context, "Error", "Password minimal 6 karakter.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _authService.login(email, password);

      if (response['success'] == true) {
      
        // Simpan token dan user di SharedPreferences
     

        // Navigasi ke halaman utama
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Mainpage()),
        );
      } else {
        _showDialog(context, "Error", response['message']);
      }
    } catch (e) {
      _showDialog(context, "Error", "Gagal terhubung ke server. Coba lagi.");
    } finally {
      setState(() {
        _isLoading = false;
      });
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
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Mainpage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFF69BF5E),
              width: double.infinity,
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: Image.asset('assets/login_image.png', height: 200),
              ),
            ),
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
                    "Login untuk melanjutkan",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildRoundedTextField(
                      "Email", Icons.email, false, _emailController),
                  SizedBox(height: 20),
                  _buildRoundedTextField(
                      "Password", Icons.lock, true, _passwordController),
                  SizedBox(height: 30),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : _buildLoginButton(context),
                  SizedBox(height: 20),
                  _buildCreateAccountText(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedTextField(String hintText, IconData icon, bool obscureText,
      TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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

  Widget _buildCreateAccountText(BuildContext context) {
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
