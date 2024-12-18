import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projek_capstone7/models/apiresponse_model.dart';
import 'package:projek_capstone7/service/session_service.dart';

const String baseUrl = 'https://kulakan.cy4lsr.my.id/api';

class AuthService {
  final SessionService _sessionService = SessionService();

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 201) {
      ApiresponseModel res = ApiresponseModel.fromJson(jsonDecode(response.body));
      await _sessionService.saveToken("${res.data["token"]}");
      await _sessionService.saveUser(
        res.data["user"]["id"].toString(),
        res.data["user"]["name"],
        res.data["user"]["email"],
      );
      return {"status": true, "message": res.message};
    } else if (response.statusCode == 422) {
      ApiresponseModel res = ApiresponseModel.fromJson(jsonDecode(response.body));
      print("Errors: ${res.errors}");
      Map<String, dynamic> err = res.errors as Map<String, dynamic>;
      return {"status": false, "message": res.message, "error": err};
    } else {
      print("Failed Response Body: ${response.body}");
      throw Exception("Failed to register");
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      ApiresponseModel res = ApiresponseModel.fromJson(jsonDecode(response.body));
      await _sessionService.saveToken("${res.data["token"]}");
      await _sessionService.saveUser(
        res.data["user"]["id"].toString(),
        res.data["user"]["name"],
        res.data["user"]["email"],
      );
      return {"status": true, "message": res.message};
    } else if (response.statusCode == 401) {
      ApiresponseModel res = ApiresponseModel.fromJson(jsonDecode(response.body));
      return {"status": false, "message": res.message};
    } else {
      throw Exception("Failed to register");
    }
  }
}