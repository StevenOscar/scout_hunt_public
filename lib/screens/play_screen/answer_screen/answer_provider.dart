import 'package:flutter/material.dart';

class AnswerProvider with ChangeNotifier {
  final TextEditingController _answerController = TextEditingController();
  int _currentHealth = 0;

  TextEditingController get answerController => _answerController;
  int get currentHealth => _currentHealth;

  void getCurrentHealth({required int health}){
    _currentHealth = health;
    notifyListeners();
  }

  void clearTextField(){
    _answerController.text = "";
    notifyListeners();
  }

  void clearProvider(){
    _answerController.text = "";
    _currentHealth = 0;
    notifyListeners();
  }
}
