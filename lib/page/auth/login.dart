import 'package:flutter/material.dart';
import 'package:projek_capstone7/service/api_service.dart';
import 'package:projek_capstone7/page/auth/forgot_password.dart';
import 'package:projek_capstone7/page/auth/register.dart';
import 'package:projek_capstone7/page/mainpage/mainpage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Validator email
  bool isValidEmail(String email) {
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    return RegExp(pattern).hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Bagian Header dengan Gambar
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF69BF5E),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'assets/login_image.png', // Path gambar
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Bagian Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
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
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Input Email dan Password
                  _buildRoundedTextField("Email", _emailController),
                  SizedBox(height: 15),
                  _buildRoundedTextField("Password", _passwordController),

                  SizedBox(height: 30),
                  // Tombol Login
                  _buildLoginButton(context),

                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen(),
                          ));
                        },
                        child: Text(
                          "Lupa Kata Sandi?",
                          style: TextStyle(color: Color(0xFF69BF5E)),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ));
                        },
                        child: Text(
                          "Belum punya akun? Daftar",
                          style: TextStyle(color: Color(0xFF69BF5E)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Input
  Widget _buildRoundedTextField(String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
      obscureText: hintText == "Password" ? true : false,
    );
  }


  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : () => _login(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF69BF5E),
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Center(
        child: _isLoading
            ? CircularProgressIndicator(color: Colors.white)
            : Text(
                "Log In",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
      ),
    );
  }

  // Fungsi Login
  Future<void> _login(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showDialog(context, "Error", "Email dan Password harus diisi.");
      return;
    }

    if (!isValidEmail(email)) {
      _showDialog(context, "Error", "Format email tidak valid.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await ApiService.login(email, password);

      if (result['statusCode'] == 200 && result['data']['success'] == true) {
        _showDialog(context, "Success", "Login berhasil!").then((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Mainpage()),
          );
        });
      } else {
        _showDialog(context, "Error", result['data']['message'] ?? "Login gagal.");
      }
    } catch (e) {
      _showDialog(context, "Error", "Tidak dapat terhubung ke server.");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Dialog Notifikasi
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
}
