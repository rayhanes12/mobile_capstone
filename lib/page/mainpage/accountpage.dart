import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String _email = "";
  String _name = "";
  String _address = "";
  String _profilePhoto = "";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    final url = Uri.parse('http://192.168.1.25:5000/api/profile');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        setState(() {
          _email = data['email'] ?? "Tidak diketahui";
          _name = data['name'] ?? "Tidak diketahui";
          _address = data['address'] ?? "Alamat tidak tersedia";
          _profilePhoto = data['profile_photo'] ?? "";
          _isLoading = false;
        });
      } else if (response.statusCode == 401) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        throw Exception('Failed to load profile data');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Akun"),
        backgroundColor: Color(0xFF69BF5E),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_profilePhoto.isNotEmpty)
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(_profilePhoto),
                      ),
                    ),
                  SizedBox(height: 20),
                  Text("Nama: $_name", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text("Email: $_email", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text("Alamat: $_address", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _logout(context),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: Text("Logout", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
    );
  }
}
