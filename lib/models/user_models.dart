import 'package:scout_hunt/models/login_models.dart';
import 'package:scout_hunt/models/profile_models.dart';
import 'package:scout_hunt/models/progress_models.dart';
class UserModels {
  LoginModels userData;
  ProfileModels? userProfile;
  ProgressModels? userProgress;

  UserModels({
    required this.userData,
    this.userProfile,
    this.userProgress
  });
}