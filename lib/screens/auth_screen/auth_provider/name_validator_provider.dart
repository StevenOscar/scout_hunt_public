import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NameValidatorProvider with ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();
  String? _nameError;
  bool _isNameValid = false;

  String? get nameError => _nameError;
  bool get isNameValid => _isNameValid;
  TextEditingController get nameController => _nameController;

  void validateName() {
    String name = _nameController.text;

    if (name.isEmpty) {
      _nameError = 'Nama tidak boleh kosong';
      _isNameValid = false;
      notifyListeners();
      return;
    }

    if(RegExp(r'\b[a-z][a-z]*\b').hasMatch(name)){
      _nameError = "Setiap kata harus diawali dengan huruf kapital";
      _isNameValid = false;
      notifyListeners();
      return;
    }

    if(RegExp(r'[0-9!@#$%^&*()_+{}\[\]:;<>,.?/~\\-]').hasMatch(name)){
      _nameError = "Nama tidak boleh mengandung angka atau karakter khusus";
      _isNameValid = false;
      notifyListeners();
      return;
    }

    else {
      _nameError = null;
      _isNameValid = true;
      notifyListeners();
      return;
    }
  }

  void clearProvider(){
    _nameController.text = "";
    _nameError = null;
    _isNameValid = false;
    notifyListeners();
  }
}
