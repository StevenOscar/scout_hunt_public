class RegisterModels {
  int userId;
  String username;
  String nama;
  String agama;
  int role;

  RegisterModels({
    required this.userId,
    required this.username,
    required this.nama,
    required this.agama,
    required this.role
  });

  factory RegisterModels.fromResponse(List<Map<String, dynamic>> response) {
    return RegisterModels(
      userId: response[0]['user_id'],
      username: response[0]['username'],
      nama: response[0]['nama'],
      agama: response[0]['agama'],
      role: response[0]['role'],
    );
  }
}