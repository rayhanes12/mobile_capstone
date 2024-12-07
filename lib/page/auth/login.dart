import 'package:flutter/material.dart';
import 'package:projek_capstone7/page/auth/forgot_password.dart';
import 'package:projek_capstone7/page/auth/register.dart';
import 'package:projek_capstone7/page/mainpage/mainpage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Bagian ilustrasi
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
                    'assets/login_image.png', // Tambahkan ilustrasi di folder assets
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // Bagian form login
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
                  _buildRoundedTextField("Email"),
                  SizedBox(height: 15),
                  _buildRoundedTextField("Password"),
                  SizedBox(height: 30),
                  _buildLoginButton(),
                  SizedBox(height: 20),
                  // Lupa Kata Sandi dan Daftar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPasswordScreen(),));
                        },
                        child: Text(
                          "Lupa Kata Sandi?",
                          style: TextStyle(color: Color(0xFF69BF5E)),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterScreen()),
                          );
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

  Widget _buildRoundedTextField(String hintText) {
    return TextField(
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

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Mainpage()),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Center(
        child: Text(
          "Log In",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
