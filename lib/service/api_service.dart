import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('https://kulakan.cy4lsr.my.id/api');
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
