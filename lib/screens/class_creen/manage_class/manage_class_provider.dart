
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scout_hunt/models/class_list_models.dart';
import 'package:scout_hunt/utils/class_db_helper.dart';

class ManageClassProvider with ChangeNotifier {
  List<ClassListModels> _classList = [];
  String _newClassCode = "";
  final TextEditingController _titleController = TextEditingController();
  String _titleError = "Nama kelas tidak boleh kosong";
  bool _isTitleValid = false;
  bool _isLoadingClassList = false;

  List<ClassListModels> get classList => _classList;
  String get newClassCode => _newClassCode;
  TextEditingController get titleController => _titleController;
  String get titleError => _titleError;
  bool get isTitleValid => _isTitleValid;
  bool get isLoadingClass => _isLoadingClassList;

  Future<void> getClassList(String username) async {
    _isLoadingClassList = true;
    notifyListeners();
    try {
      _classList = await ClassDbHelper().fetchClassList(username);
      _isLoadingClassList = false;
      notifyListeners();
    } catch (e) {
      print(e);
      _isLoadingClassList = false;
      notifyListeners();
    }
  }

  Future<void> saveClass({
    required String username,
    required int userId
  }) async{
    try {
      await ClassDbHelper().insertClassToDb(
        title: _titleController.text,
        classCode: _newClassCode,
        username: username,
      );
    } catch (e) {
      print(e);
    }
  }

  void validateTitle(){
    String title = _titleController.text;

    if (title.isEmpty) {
      _titleError = 'Nama kelas tidak boleh kosong';
      _isTitleValid = false;
      notifyListeners();
      return;
    }

    else {
      _titleError = '';
      _isTitleValid = true;
      notifyListeners();
      return;
    }
  }

  void generateClassCode(){
    const ch = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    _newClassCode = String.fromCharCodes(Iterable.generate(6,(_) => ch.codeUnitAt(Random().nextInt(ch.length))));
    notifyListeners();
  }

  void clearProvider(){
    _classList = [];
    _newClassCode = "";
    _titleController.text = "";
    _titleError = "Nama kelas tidak boleh kosong";
    _isTitleValid = false;
    notifyListeners();
  }

  void clearCreateClassButton(){
    _newClassCode = "";
    _titleController.text = "";
    _titleError = "Nama kelas tidak boleh kosong";
    _isTitleValid = false;
    notifyListeners();
  }
}
