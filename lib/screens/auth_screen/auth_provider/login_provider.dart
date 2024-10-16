import 'package:flutter/material.dart';
import 'package:scout_hunt/models/login_models.dart';
import 'package:scout_hunt/utils/user_db_helper.dart';


class LoginProvider with ChangeNotifier {
  String? _message;
  LoginModels? _userData;
  bool _isLoadingLogin = false;
  bool _isLoginValid = false;

  String get message => _message ?? '-';
  LoginModels? get userData => _userData;
  bool get isLoadingLogin => _isLoadingLogin;
  bool get isLoginValid => _isLoginValid;

  Future<bool> loginUser(String username, String password) async {
    _isLoadingLogin = true;
    notifyListeners();
    try {
      _userData = await UserDbHelper().login(username: username,password: password);
      _isLoginValid = true;
      notifyListeners();

      return true;

    } catch (error) {
      _isLoadingLogin = false;
      _isLoginValid = false;
      notifyListeners();
      return false;
    }
  }

  void setLoadingLogin(){
    _isLoadingLogin = false;
    notifyListeners();
  }

  void clearProvider(){
    _message = null;
    _userData = null;
    _isLoadingLogin = false;
    _isLoginValid = false;
    notifyListeners();
  }
}
