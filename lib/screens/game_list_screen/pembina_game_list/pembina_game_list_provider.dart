
import 'package:flutter/material.dart';
import 'package:scout_hunt/models/game_data_models.dart';
import 'package:scout_hunt/models/game_info_models.dart';
import 'package:scout_hunt/utils/game_db_helper.dart';

class PembinaGameListProvider with ChangeNotifier {
  List<GameInfoModels> _gameList = [];
  GameDataModels? _gameData;
  bool _isLoadingData = false;

  List<GameInfoModels> get gameList => _gameList;
  GameDataModels? get gameData => _gameData;
  bool get isLoadingData => _isLoadingData;

  Future<void> getGameList(String username) async {
    try {
      _gameList = await GameDbHelper().fetchGameList(username);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteGame(int index) async {
    try {
      await GameDbHelper().deleteGameInDb(gameCode: _gameList[index].gameCode);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<GameDataModels?> getGameData({
    required String gameCode,
    required int index
  }) async {
    _isLoadingData =true;
    notifyListeners();
    try {
      _gameData = await GameDbHelper().fetchGameDataPembina(_gameList[index].gameCode);
      _isLoadingData = false;
      notifyListeners();
      return _gameData;
    } catch (e) {
      print(e);
      _isLoadingData = false;
      notifyListeners();
      return null;
    }
  }

  void clearProvider(){
    _isLoadingData = false;
    _gameData = null;
    _gameList = [];
  }
}
