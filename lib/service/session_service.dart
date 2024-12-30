import 'package:projek_capstone7/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  // Menyimpan token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  // Mengambil token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  // Menghapus token
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }

  // Menyimpan data pengguna
  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', user.id!);
    await prefs.setString('profile_photo', user.profile_photo.toString());
    await prefs.setString('name', user.name);
    await prefs.setString('email', user.address);
  
  }

  // Mengambil data pengguna
  Future<UserModel> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    String? profile_photo = prefs.getString('profile_photo');
    String? address = prefs.getString('address');

    
    return UserModel(
      id: id,
      email: email!, 
      name: name!, 
      address: address!, 
      profile_photo: profile_photo);
  }

  // Menghapus data pengguna
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('profile_photo');
    await prefs.remove('address');
    
  }

  // Menghapus semua data (token dan data pengguna)
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
