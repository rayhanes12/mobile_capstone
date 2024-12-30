import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projek_capstone7/models/apiresponse_model.dart';
import 'package:projek_capstone7/models/user.dart';
import 'package:projek_capstone7/service/session_service.dart';

const String baseUrl = 'http://127.0.0.1:5000/';

class AuthService {
  final SessionService _sessionService = SessionService();

  // Future<Map<String, dynamic>> register(
  //     String name, String email, String password) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/register'),
  //     headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode({
  //       "name": name,
  //       "email": email,
  //       "password": password,
  //     }),
  //   );

  //   print("Response Status Code: ${response.statusCode}");
  //   print("Response Body: ${response.body}");

  //   if (response.statusCode == 201) {
  //     ApiresponseModel res =
  //         ApiresponseModel.fromJson(jsonDecode(response.body));
  //     await _sessionService.saveToken("${res.data["token"]}");
  //     await _sessionService.saveUser(
  //       res.data["user"]["id"].toString(),
  //       res.data["user"]["name"],
  //       res.data["user"]["email"],
  //     );
  //     return {"status": true, "message": res.message};
  //   } else if (response.statusCode == 422) {
  //     ApiresponseModel res =
  //         ApiresponseModel.fromJson(jsonDecode(response.body));
  //     print("Errors: ${res.errors}");
  //     Map<String, dynamic> err = res.errors as Map<String, dynamic>;
  //     return {"status": false, "message": res.message, "error": err};
  //   } else {
  //     print("Failed Response Body: ${response.body}");
  //     throw Exception("Failed to register");
  //   }
  // }

  Future<Map<String, dynamic>> login(String Email, String pass) async {
    final url = Uri.parse('http://192.168.1.25:5000/api/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': Email,
          'password': pass,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final user = UserModel(
          id: data['user']['id'],
          email: data['user']['email'],
          name: data['user']['name'],
          address: data['user']['address'] ?? '',
          profile_photo: data['user']['profile_photo'],
        
        );

        await _sessionService.saveToken(token);
        await _sessionService.saveUser(user);
        return {'success': true, 'token': data['token'], 'user': data['user']};
      } else {
        return {
          'message': 'Unexpected status code: ${response.statusCode}',
          'status': 'danger'
        };
      }
    } catch (error) {
      return {'message': 'Error: $error', 'status': 'bahaya'};
    }
  }
}
