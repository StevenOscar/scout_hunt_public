
import 'package:flutter/material.dart';

class AgamaValidatorProvider with ChangeNotifier {
  String _agamaValue = "islam";

  String get agamaValue => _agamaValue;

  void selectAgama(String selectedAgama){
    _agamaValue = selectedAgama;
    notifyListeners();
  }

  void clearProvider(){
    _agamaValue = "islam";
    notifyListeners();
  }
}
