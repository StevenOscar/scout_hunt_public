import 'package:flutter/material.dart';

class PasswordValidatorProvider with ChangeNotifier {
  final TextEditingController _passwordController = TextEditingController();
  String? _passwordError;
  bool _isPasswordVisible = false;
  bool _isPasswordValid = false;

  String? get passwordError => _passwordError;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isPasswordValid => _isPasswordValid;
  TextEditingController get passwordController => _passwordController;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void validatePassword() {
    String password = _passwordController.text;

    // Lakukan validasi password sesuai kebutuhan
    if (password.isEmpty) {
      _passwordError = 'Password tidak boleh kosong';
      _isPasswordValid = false;
      notifyListeners();
      return;
    }

    if(!(password.contains(RegExp(r'\d')))) {
      _passwordError = 'Password harus memiliki minimal 1 angka';
      _isPasswordValid = false;
      notifyListeners();
      return;
    }

    if(password.length > 15) {
      _passwordError = 'Password tidak boleh melebihi 15 karakter';
      _isPasswordValid = false;
      notifyListeners();
      return;
    }

    else {
      _passwordError = null; // Menggunakan nullable pada string
      _isPasswordValid = true;
      notifyListeners();
      return;
    }
  }

  void clearProvider(){
    _passwordController.text = "";
    _passwordError = null;
    _isPasswordValid = false;
    notifyListeners();
  }
}
