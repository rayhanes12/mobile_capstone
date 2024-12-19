import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('http://192.168.121.203:5000/api/login');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      return {
        "statusCode": response.statusCode,
        "data": json.decode(response.body),
      };
    } catch (e) {
      throw Exception("Tidak dapat terhubung ke server. Pastikan koneksi internet aktif.");
    }
  }
}
