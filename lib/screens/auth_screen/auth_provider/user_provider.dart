import 'package:flutter/material.dart';
import 'package:scout_hunt/models/login_models.dart';
import 'package:scout_hunt/models/profile_models.dart';
import 'package:scout_hunt/models/progress_models.dart';
import 'package:scout_hunt/utils/profile_db_helper.dart';
import 'package:scout_hunt/utils/student_progress_db_helper.dart';

class UserProvider with ChangeNotifier {
  LoginModels? _userData;
  ProfileModels? _profileData;
  ProgressModels? _progressData;

  LoginModels? get userData => _userData;
  ProfileModels? get profileData => _profileData;
  ProgressModels? get progressData => _progressData;

  Future<void> getStudentData(LoginModels userData) async{
    try {
      _userData = userData;
      _progressData = await StudentProgressDbHelper().fetchProgress(userId: userData.userId);
      _profileData = await ProfileDbHelper().fetchProfileSingle(userId: userData.userId);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getPembinaData(LoginModels userData) async{
    try {
      _userData = userData;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void clearProvider(){
    _userData = null;
    _profileData = null;
    _progressData = null;
    notifyListeners();
  }
}
