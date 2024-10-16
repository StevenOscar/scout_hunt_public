import 'package:scout_hunt/models/login_models.dart';
import 'package:scout_hunt/models/profile_models.dart';
import 'package:scout_hunt/models/progress_models.dart';

class ClassDetailModels {
  String classCode;
  List<LoginModels> userList;
  List<ProfileModels> profileList;
  List<ProgressModels> progressList;
  String title;
  String createdBy;

  ClassDetailModels({
    required this.classCode,
    required this.userList,
    required this.profileList,
    required this.progressList,
    required this.title,
    required this.createdBy,
  });
}