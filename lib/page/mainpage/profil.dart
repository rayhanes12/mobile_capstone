import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Controller untuk TextField
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isEditMode = false; // Status apakah sedang dalam mode edit

  @override
  void initState() {
    super.initState();
    // Nilai awal untuk TextField
    nameController.text = "Wicaksono";
    emailController.text = "wicaksono@gmail.com";
    phoneController.text = "08888888888";
    addressController.text = "Jl. jl ke pasar";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Bagian atas dengan background hijau gradasi
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade400, Colors.green.shade300],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Foto profil
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10),
                // Nama pengguna
                Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Bagian detail informasi
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextField("Nama", nameController, isEditMode),
                SizedBox(height: 10),
                buildTextField("E-mail", emailController, isEditMode),
                SizedBox(height: 10),
                buildTextField("No Telp", phoneController, isEditMode),
                SizedBox(height: 10),
                buildTextField("Alamat", addressController, isEditMode),
              ],
            ),
          ),

          // Tombol Edit atau Save
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (isEditMode) {
                    // Simpan perubahan
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Perubahan berhasil disimpan!"),
                      ),
                    );
                  }
                  // Toggle mode edit
                  isEditMode = !isEditMode;
                });
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Center(
                child: Text(
                  isEditMode ? "Save Changes" : "Edit Profil",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green.shade300
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // Widget untuk membuat TextField
  Widget buildTextField(String labelText, TextEditingController controller, bool isEditable) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: controller,
          enabled: isEditable, // Hanya dapat diedit saat mode edit
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
