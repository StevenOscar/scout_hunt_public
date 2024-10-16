import 'package:flutter/material.dart';
import 'package:scout_hunt/utils/user_db_helper.dart';


class RegisterProvider with ChangeNotifier {
  String? _message;
  bool _isLoadingRegister = false;
  bool _isRegisterValid = false;
  bool _isDuplicate = false;

  String? get message => _message;
  bool get isLoadingRegister => _isLoadingRegister;
  bool get isRegisterValid => _isRegisterValid;

  Future<bool> registerUser({
    required String username,
    required String name,
    required String password,
    required String role,
    required String agama,
  }) async {
    _isLoadingRegister = true;
    notifyListeners();
    try {
      _isDuplicate = await UserDbHelper().checkDuplicateUsername(username);

      if (_isDuplicate == false) {
        _isRegisterValid = await UserDbHelper().register(
          username: username,
          password: password,
          nama: name,
          role: role,
          agama: agama,
        );
        _isLoadingRegister = false;
        notifyListeners();
        return true;
      } else {
        _message = "User sudah terdaftar sebelumnya";
        print(_message);
        _isLoadingRegister = false;
        notifyListeners();
        return false;
      }
    } catch (error) {
      _message = "Register gagal! Coba lagi";
      _isLoadingRegister = false;
      _isRegisterValid = false;
      notifyListeners();
      return false;
    }
  }

  void setLoadingRegister(){
    _isLoadingRegister = false;
    notifyListeners();
  }

  void clearProvider(){
    _message = null;
    _isLoadingRegister = false;
    _isRegisterValid = false;
    notifyListeners();
  }
}
