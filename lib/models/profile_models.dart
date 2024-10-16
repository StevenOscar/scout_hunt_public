class ProfileModels {
  int userId;
  String achievement;
  String badge;
  String? classCode;

  ProfileModels({
    required this.userId,
    required this.achievement,
    required this.badge,
    this.classCode
  });

  factory ProfileModels.fromSingleResponse(List<Map<String, dynamic>> response) {
    print(response[0]['user_id']);
    print(response[0]['achievement']);
    print(response[0]['badge']);
    print(response[0]['class_code']);
    return ProfileModels(
      userId: response[0]['user_id'],
      achievement: response[0]['achievement'],
      badge: response[0]['badge'],
      classCode: response[0]['class_code']
    );
  }

  static List<ProfileModels> fromListResponse(List<Map<String, dynamic>> response) {
    List<ProfileModels> listProfile = [];
    for (var i = 0; i < response.length; i++) {
      listProfile.add(
        ProfileModels(
          userId: response[i]['user_id'],
          achievement: response[i]['achievement'],
          badge: response[i]['badge'],
          classCode: response[i]['class_code']
        )
      );
    }
    return listProfile;
  }
}