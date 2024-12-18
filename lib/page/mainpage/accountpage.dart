import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // Kontroller untuk teks
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Contoh nilai awal (bisa dikosongkan jika ingin user mulai dengan input manual)
    nameController.text = '';
    emailController.text = '';
    addressController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akun'),
        backgroundColor: Colors.green.shade900,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // Foto profil
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade300,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            SizedBox(height: 30),

            // Input untuk Nama
            buildEditableField(
              label: 'Nama',
              controller: nameController,
              hintText: 'Masukkan nama Anda',
            ),

            // Input untuk Email
            buildEditableField(
              label: 'Email',
              controller: emailController,
              hintText: 'Masukkan email Anda',
              keyboardType: TextInputType.emailAddress,
            ),

            // Input untuk Alamat
            buildEditableField(
              label: 'Alamat',
              controller: addressController,
              hintText: 'Masukkan alamat Anda',
            ),

            // Tombol Simpan
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simpan data (bisa dihubungkan ke database atau API di masa depan)
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Data Disimpan'),
                      content: Text('Informasi profil Anda telah diperbarui.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                'Simpan',
                style: TextStyle(fontSize: 16, color: Color(0xFF69BF5E)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEditableField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 5),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}

// Tetap pertahankan fungsi buildMenuItem
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
          } else {
            print('$title diklik');
          }
        },
      ),
    ),
  );
}
