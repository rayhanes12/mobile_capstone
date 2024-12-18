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
          // Header
          Text(
            'Pengaturan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade900,
            ),
          ),
          SizedBox(height: 30),
          // List Menu
          buildMenuItem(context, 'Akun'),
          buildMenuItem(context, 'Riwayat'),
          buildMenuItem(context, 'Tentang Kami'),
          buildMenuItem(context, 'Logout'),
        ],
      ),
    );
  }

  // Fungsi untuk membangun item menu
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
              color: Colors.green.shade900,
            ),
          ),
          onTap: () {
            // Aksi ketika menu diklik
            if (title == 'Akun') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountPage()),
              );
            } else if (title == 'Logout') {
              // Aksi logout
              _logout(context);
            } else {
              print('$title diklik');
            }
          },
        ),
      ),
    );
  }

  // Fungsi untuk melakukan logout
  void _logout(BuildContext context) {
    // Menampilkan dialog konfirmasi logout
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda yakin ingin logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Menutup dialog
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // Navigasi ke halaman login (sesuaikan dengan halaman login Anda)
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
