
import 'package:flutter/material.dart';

class RoleValidatorProvider with ChangeNotifier {
  String _roleValue = "siswa"; //0 untuk siswa 1 untuk pembina

  String get roleValue => _roleValue;

  void selectRole(String selectedRole){
    _roleValue = selectedRole;
    notifyListeners();
  }

  void clearRoleProvider(){
    _roleValue = "siswa";
    notifyListeners();
  }
}
