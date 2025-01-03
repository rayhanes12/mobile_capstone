import 'package:projek_capstone7/page/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:projek_capstone7/page/auth/register.dart';
import 'package:projek_capstone7/page/mainpage/chatbot.dart';
import 'package:projek_capstone7/page/mainpage/home.dart';
import 'package:projek_capstone7/page/mainpage/mainpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      theme: ThemeData(
        primaryColor: Color(0xFF69BF5E),
      ),
    );
  }
}
