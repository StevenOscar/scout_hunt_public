
import 'package:flutter/material.dart';
import 'package:scout_hunt/models/game_data_models.dart';
import 'package:scout_hunt/models/game_info_models.dart';
import 'package:scout_hunt/utils/game_db_helper.dart';
import 'package:scout_hunt/utils/local_db_helper.dart';

class SiswaGameListProvider with ChangeNotifier {
  List<GameInfoModels> _gameList = [];
  bool _isDownloadingGameData = false;
  final TextEditingController _gameCodeController = TextEditingController();
  bool _isGameCodeValid = false;
  String _message = "";
  String? _gameCodeError;

  List<GameInfoModels> get gameList => _gameList;
  bool get isDownoadingGameData => _isDownloadingGameData;
  TextEditingController get gameCodeController => _gameCodeController;
  bool get isGameCodeValid => _isGameCodeValid;
  String get message => _message;
  String? get gameCodeError => _gameCodeError;

  Future<void> getGameList({required String username}) async {
    try {
      _gameList = await LocalDbHelper().getGameListFromLocal(username: username);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteGame({
    required String gameCode,
    required String username,
  }) async {
    try {
      await LocalDbHelper().deleteGameFromLocal(gameCode: gameCode, username: username);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> downloadGameData({
    required String gameCode,
    required String username
  }) async {
    _isDownloadingGameData = true;
    notifyListeners();
    try {
      GameDataModels? gameData = await GameDbHelper().fetchGameDataSiswa(gameCode);

      if(gameData == null){
        _isDownloadingGameData = false;
        notifyListeners();
        throw "Kode Permainan tidak ditemukan";
      } else {
        await LocalDbHelper().saveGameToLocal(gameDataList: gameData, username: username, gameCode: gameCode);
        _isDownloadingGameData = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _isDownloadingGameData = false;
      notifyListeners();
      throw e;
    }
  }

  Future<bool> checkDuplicate({
    required String gameCode,
    required String username
  }) async{
    bool isDuplicate = await LocalDbHelper().checkDuplicateGame(
      gameCode: gameCode,
      username: username
    );
    notifyListeners();
    return isDuplicate;
  }

  void validateGameCode(){
    String gameCode = _gameCodeController.text;

    if (gameCode.isEmpty) {
      _isGameCodeValid = false;
      _gameCodeError = null;
      notifyListeners();
      return;
    }

    if (gameCode.length != 6) {
      _gameCodeError = 'Game Code terdiri dari 6 huruf';
      _isGameCodeValid = false;
      notifyListeners();
      return;
    }

    if (gameCode.contains(" ")) {
      _gameCodeError = 'Game Code tidak memiliki spasi';
      _isGameCodeValid = false;
      notifyListeners();
      return;
    }

    if (gameCode.contains(" ")) {
      _gameCodeError = 'Game Code tidak memiliki spasi';
      _isGameCodeValid = false;
      notifyListeners();
      return;
    }

    if(RegExp(r'[0-9!@#$%^&*()_+{}\[\]:;<>,.?/~\\-]').hasMatch(gameCode)){
      _gameCodeError = "Game Code tidak boleh mengandung angka/karakter khusus";
      _isGameCodeValid = false;
      notifyListeners();
      return;
    }

    else {
      _gameCodeError = null;
      _isGameCodeValid = true;
      notifyListeners();
      return;
    }
  }

  void clearProvider(){
    _isDownloadingGameData = false;
    _gameList = [];
    _message = "";
    _gameCodeError = null;
    _isGameCodeValid = false;
    _gameCodeController.text = "";
    notifyListeners();
  }

  void clearTextField(){
    _gameCodeController.text = "";
    notifyListeners();
  }
}
