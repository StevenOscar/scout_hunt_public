
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scout_hunt/models/question_models.dart';
import 'package:scout_hunt/utils/game_db_helper.dart';

class GameSetupProvider with ChangeNotifier {
  List<QuestionModels> _questionList = [];
  String _gameCode = "";
  String _titleError = "Judul tidak boleh kosong";
  bool _isTitleValid = false;
  bool _isLoadingSave = false;
  final TextEditingController _titleController = TextEditingController();

  List<QuestionModels> get questionList => _questionList;
  String get gameCode => _gameCode;
  String get titleError => _titleError;
  bool get isTitleValid => _isTitleValid;
  bool get isLoadingSave => _isLoadingSave;
  TextEditingController get titleController => _titleController;

  void generateGameCode(){
    const ch = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    _gameCode = String.fromCharCodes(Iterable.generate(6,(_) => ch.codeUnitAt(Random().nextInt(ch.length))));
    notifyListeners();
  }

  void validateTitle(){
    String title = _titleController.text;

    if (title.isEmpty) {
      _titleError = 'Judul tidak boleh kosong';
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

  void addQuestion({
    required String category,
    required String question,
    required String imageClue,
    required File imageFile,
    required String answer
  }){
    _questionList.add(
      QuestionModels(
        category: category,
        question: question,
        imageClue: imageClue,
        imageFile: imageFile,
        answer: answer
      ),
    );
    notifyListeners();
  }

  void editQuestion({
    required int index,
    required String category,
    required String question,
    required String imageClue,
    required File imageFile,
    required String answer
  }){
    _questionList[index] = QuestionModels(
      answer: answer,
      category: category,
      imageClue: imageClue,
      imageFile: imageFile,
      question: question,
    );
    notifyListeners();
  }

  Future<void> saveGame({required String username}) async{
    _isLoadingSave = true;
    notifyListeners();
    for (var i = 0; i < _questionList.length; i++) {
      _questionList[i].questionNumber = i+1;
    }

    try {
      await GameDbHelper().saveGameToDb(
        questionList: questionList,
        title: _titleController.text,
        gameCode: gameCode,
        username: username
      );

      _isLoadingSave = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateGame({required String username}) async{
    _isLoadingSave = true;
    notifyListeners();
    for (var i = 0; i < _questionList.length; i++) {
      _questionList[i].questionNumber = i+1;
    }

    try {
      await GameDbHelper().updateGameToDb(
        questionList: questionList,
        title: _titleController.text,
        gameCode: gameCode,
        username: username
      );

      _isLoadingSave = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void removeQuestion(int index){
    _questionList.removeAt(index);
    notifyListeners();
  }

  void clearProvider(){
    _gameCode = "";
    _questionList = [];
    _titleError = "Judul tidak boleh kosong";
    _isTitleValid = false;
    _isLoadingSave = false;
    _titleController.text = "";
    notifyListeners();
  }

  Future<void> setEditPermainan({
    required List<QuestionModels> questionList,
    required String title,
    required String gameCode
  }) async {
    _titleError = "";
    _gameCode = gameCode;
    _questionList = questionList;
    _isTitleValid = true;
    _titleController.text = title;
    _isLoadingSave = false;
    notifyListeners();
  }
}
