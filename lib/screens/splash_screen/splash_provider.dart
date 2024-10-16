import 'dart:io';
import 'package:flutter/material.dart';

class SplashProvider with ChangeNotifier {
  bool _hasInternet = false;
  bool get hasInternet => _hasInternet;

  Future<void> pingGoogle(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
        _hasInternet = true;
        notifyListeners();
      } else{
        _hasInternet= false;
        notifyListeners();
      }
    } on SocketException catch (e) {
      print(e);
      notifyListeners();
    }
  }
}
