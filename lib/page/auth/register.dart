// import 'package:flutter/material.dart';

// class RegisterScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF69BF5E), Color(0xFFA2E555)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Create Account",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 _buildRoundedTextField("Name", Icons.person, false),
//                 SizedBox(height: 20),
//                 _buildRoundedTextField("Email", Icons.email, false),
//                 SizedBox(height: 20),
//                 _buildRoundedTextField("Password", Icons.lock, true),
//                 SizedBox(height: 30),
//                 _buildRegisterButton(),
//                 SizedBox(height: 30),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text(
//                     "Already have an account? Login",
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildRoundedTextField(
//       String hintText, IconData icon, bool obscureText) {
//     return TextField(
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: TextStyle(color: const Color.fromARGB(255, 56, 56, 56)),
//         filled: true,
//         fillColor: Colors.white.withOpacity(0.9),
//         contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30.0),
//           borderSide: BorderSide.none,
//         ),
//         prefixIcon: Icon(icon, color: const Color.fromARGB(255, 56, 56, 56)),
//       ),
//       style: TextStyle(color: const Color.fromARGB(255, 56, 56, 56)),
//     );
//   }

//   Widget _buildRegisterButton() {
//     return ElevatedButton(
//       onPressed: () {
//         // Tambahkan fungsi registrasi di sini
//       },
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//       ),
//       child: Text(
//         "Register",
//         style: TextStyle(color: Color(0xFF69BF5E), fontSize: 18),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Bagian atas - Ilustrasi
            Container(
              color: Color(0xFF69BF5E),
              width: double.infinity,
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: Image.asset(
                  'assets/illustration.png', // Gambar ilustrasi
                  height: 200, // Sesuaikan ukuran gambar
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Bagian bawah - Form registrasi
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul aplikasi
                  Text(
                    "Kulakan.",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF69BF5E),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Sub-judul
                  Text(
                    "Buat Akun Pertamamu",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Input Full Name
                  _buildRoundedTextField("Full name", Icons.person, false),
                  SizedBox(height: 20),
                  // Input Email
                  _buildRoundedTextField("Email", Icons.email, false),
                  SizedBox(height: 20),
                  // Input Password
                  _buildRoundedTextField("Password", Icons.lock, true),
                  SizedBox(height: 30),
                  // Tombol Register
                  _buildRegisterButton(),
                  SizedBox(height: 20),
                  // Teks Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Navigasi ke halaman login
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xFF69BF5E),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
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

  Widget _buildRoundedTextField(
      String hintText, IconData icon, bool obscureText) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon, color: Colors.black54),
      ),
      style: TextStyle(color: Colors.black87),
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () {
        // Tambahkan logika registrasi di sini
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15),
        backgroundColor: Color(0xFF69BF5E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Center(
        child: Text(
          "Start",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
