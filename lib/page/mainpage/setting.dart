import 'package:flutter/material.dart';
import 'package:projek_capstone7/page/auth/login.dart';
import 'package:projek_capstone7/page/mainpage/accountpage.dart';

void main() {
  runApp(SettingsPage());
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Pengaturan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF69BF5E),
            ),
          ),
          SizedBox(height: 30),
          buildMenuItem(context, 'Akun'),
          buildMenuItem(context, 'Riwayat'),
          buildMenuItem(context, 'Tentang Kami'),
          buildMenuItem(context, 'Logout'),
        ],
      ),
    );
  }

  Widget buildMenuItem(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF69BF5E),
            ),
          ),
          onTap: () {
            if (title == 'Akun') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountPage()),
              );
            } else if (title == 'Logout') {
              _logout(context);
            } else {
              print('$title diklik');
            }
          },
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda yakin ingin logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
