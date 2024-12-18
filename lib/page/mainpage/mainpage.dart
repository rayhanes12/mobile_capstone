import 'package:projek_capstone7/page/auth/login.dart';
import 'package:projek_capstone7/page/mainpage/cart.dart';
import 'package:projek_capstone7/page/mainpage/chatbot.dart';
import 'package:projek_capstone7/page/mainpage/home.dart';
import 'package:flutter/material.dart';
import 'package:projek_capstone7/page/mainpage/setting.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    bagianBody() {
      if (_currentIndex == 0) {
        return HomeScreen();
      } else if (_currentIndex == 1) {
        return CartPage();
      } else if (_currentIndex == 2) {
        return ChatPage();
      } else if (_currentIndex == 3){
        return SettingsPage();
      }
    }

    return Scaffold(
      body: bagianBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Transaction',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        selectedItemColor: Color(0xFF69BF5E),
        unselectedItemColor: Color(0xFF69BF5E),
        showUnselectedLabels: true,
      ),
    );
  }
}
