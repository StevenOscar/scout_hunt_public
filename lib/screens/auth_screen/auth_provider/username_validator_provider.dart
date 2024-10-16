import 'package:flutter/material.dart';

class UsernameValidatorProvider with ChangeNotifier {
  final TextEditingController _usernameController = TextEditingController();
  String? _usernameError;
  bool _isUsernameValid = false;

  String? get usernameError => _usernameError;
  bool get isUsernameValid => _isUsernameValid;
  TextEditingController get usernameController => _usernameController;

  void validateUsername() {
    String username = _usernameController.text;

    if (username.isEmpty) {
      _usernameError = 'Username tidak boleh kosong';
      _isUsernameValid = false;
      notifyListeners();
      return;
    }

    if (username.length <= 5) {
      _usernameError = 'Username harus lebih dari 5 karakter';
      _isUsernameValid = false;
      notifyListeners();
      return;
    }

    if (username.contains(" ")) {
      _usernameError = 'Username tidak boleh memiliki spasi';
      _isUsernameValid = false;
      notifyListeners();
      return;
    }

    else {
      _usernameError = null;
      _isUsernameValid = true;
      notifyListeners();
      return;
    }
  }

  void clearProvider(){
    _usernameController.text = "";
    _usernameError = null;
    _isUsernameValid = false;
    notifyListeners();
  }
}
