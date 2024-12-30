class UserModel {
  final String email;
  int? id;
  String? profile_photo;
  final String name;
  final String address;


  UserModel({
    required this.email,
    this.id,
    this.profile_photo,
    required this.name,
    required this.address,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      id: json['id'] ?? 0,
      profile_photo: json['profile_photo'] ?? 'a',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'id': id,
      'img_profil': profile_photo,
      'name': name,
      'address': address,
   
    };
  }
}