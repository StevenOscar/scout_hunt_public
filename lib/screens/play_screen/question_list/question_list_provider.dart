
import 'package:flutter/material.dart';
import 'package:scout_hunt/models/local_game_data_models.dart';
import 'package:scout_hunt/models/progress_models.dart';
import 'package:scout_hunt/utils/local_db_helper.dart';
import 'package:scout_hunt/utils/student_progress_db_helper.dart';

class QuestionListProvider with ChangeNotifier {
  List<LocalGameDataModels> _questionList = [];
  bool _loadingSubmit = false;
  int _activeQuestionIndex = -1;
  int _currentPoints = 0;
  int _correctAnswers = 0;

  List<LocalGameDataModels> get questionList => _questionList;
  bool get loadingSubmit => _loadingSubmit;
  int get activeQuestionIndex => _activeQuestionIndex;
  int get currentPoints => _currentPoints;
  int get correctAnswers => _correctAnswers;

  Future<void> getGameData({
    required String username,
    required String gameCode
  }) async {
    try {
      _currentPoints = 0;
      _correctAnswers = 0;
      _questionList = await LocalDbHelper().getGameDataFromLocal(gameCode: gameCode, username: username);
      _activeQuestionIndex = _questionList.indexWhere((element) => element.phase < 3);

      if(_activeQuestionIndex != -1){
        for (int i = 0; i < _activeQuestionIndex; i++) {
          if (_questionList[i].health > 0) {
            _currentPoints += 100;
            _correctAnswers += 1;
          }
        }
      } else {
        for (int i = 0; i < _questionList.length; i++) {
          if (_questionList[i].health > 0) {
            _currentPoints += 100;
            _correctAnswers += 1;
          }
        }
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updatePhase({
    required int index,
  }) async {
    try {
      await LocalDbHelper().updatePhase(
        gameCode: _questionList[index].gameCode,
        phase: _questionList[index].phase,
        questionNumber: _questionList[index].questionNumber,
        username: _questionList[index].username
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> reduceHealth({
    required int index,
  }) async {
    try {
      await LocalDbHelper().updateHealth(
        gameCode: _questionList[index].gameCode,
        health: _questionList[index].health,
        questionNumber: _questionList[index].questionNumber,
        username: _questionList[index].username
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> submitProgress({
    required int userId,
    required ProgressModels currentProgress,
  }) async {
    _loadingSubmit = true;
    notifyListeners();
    try {
      await StudentProgressDbHelper().submitGameProgress(
        userId: userId,
        gameCode: questionList[0].gameCode,
        currentProgress: currentProgress,
        points: _currentPoints,
        correctAnswer: _correctAnswers
      );
      _loadingSubmit = false;
      notifyListeners();
    } catch (e) {
      print(e);
      _loadingSubmit = false;
      notifyListeners();
    }
  }

  Future<bool> checkDuplicate({
    required List<String> gameProgress,
    required String gameCode
  }) async {
    if (gameProgress.contains(gameCode)) {
      return true;
    } else {
      return false;
    }
  }
}
