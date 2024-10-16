class LoginModels {
  int userId;
  String username;
  String nama;
  String? agama;
  int? role;

  LoginModels({
    required this.userId,
    required this.username,
    required this.nama,
    this.agama,
    this.role
  });

  factory LoginModels.fromSingleResponse(List<Map<String, dynamic>> response) {
    return LoginModels(
      userId: response[0]['user_id'],
      username: response[0]['username'],
      nama: response[0]['nama'],
      agama: response[0]['agama'],
      role: response[0]['role'],
    );
  }
}