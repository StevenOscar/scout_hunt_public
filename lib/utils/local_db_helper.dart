
import 'package:path/path.dart';
import 'package:scout_hunt/models/game_data_models.dart';
import 'package:scout_hunt/models/game_info_models.dart';
import 'package:scout_hunt/models/local_game_data_models.dart';
import 'package:sqflite/sqflite.dart';

class LocalDbHelper {
  static LocalDbHelper? _databaseHelper;
  final String _tableName = "game_db";
  static late Database _database;

  LocalDbHelper._internal(){
    _databaseHelper = this;
  }

  factory LocalDbHelper() => _databaseHelper ?? LocalDbHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<Database> _initializeDb() async {
    var db = openDatabase(
      join(await getDatabasesPath(), 'game_db.db'),
      onCreate: (db,version) async {
        return db.execute(
          ''' CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY,
            username TEXT,
            title TEXT,
            points int,
            phase int,
            health int,
            question_number int,
            game_code TEXT,
            category TEXT,
            question TEXT,
            answer TEXT,
            image_clue TEXT,
            image_byte BLOB
          )
          '''
        );
      },
      version: 1
    );
    return db;
  }

  Future<void> saveGameToLocal ({
    required GameDataModels gameDataList,
    required String username,
    required String gameCode,
  }) async {
    final Database db = await database;

    for (var i = 0; i < gameDataList.questionList.length; i++) {
      int highestId =  await getHighestId();

      await db.insert(
        _tableName,
        {
          'id' : highestId + 1,
          'username' : username,
          'title' : gameDataList.title,
          'points' : gameDataList.points,
          'phase' : 1,
          'health' : 3,
          'question_number' : gameDataList.questionList[i].questionNumber,
          'game_code' : gameCode,
          'category' : gameDataList.questionList[i].category,
          'question' : gameDataList.questionList[i].question,
          'answer' : gameDataList.questionList[i].answer,
          'image_clue' : gameDataList.questionList[i].imageClue,
          'image_Byte' : gameDataList.questionList[i].imageByte
        }
      );
    }
  }

  Future<List<GameInfoModels>> getGameListFromLocal({required String username}) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT DISTINCT title, game_code, points FROM $_tableName WHERE username = '$username'
    ''');
    print(results);

    List<GameInfoModels> gameList = [];
    for (var i = 0; i < results.length; i++) {
      gameList.add(
        GameInfoModels(
          title: results[i]['title'],
          gameCode: results[i]['game_code'],
          points: results[i]['points'],
        )
      );
    }

    return gameList;
  }

  Future<List<LocalGameDataModels>> getGameDataFromLocal({required String username, required String gameCode}) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT * FROM $_tableName WHERE username = '$username' AND game_code = '$gameCode'
    '''
    );

    List<LocalGameDataModels> questionList = results.map((e) => LocalGameDataModels.fromMap(e)).toList();

    return questionList;
  }

  Future<bool> checkDuplicateGame({required String gameCode, required String username}) async {
    final db = await database;
    List<Map<String, dynamic>> checkDuplicate = await db.rawQuery('''
      SELECT username FROM $_tableName WHERE username = '$username' AND game_code = '$gameCode'
    '''
    );

    if(checkDuplicate.isEmpty){
      return false;
    } else {
      return true;
    }
  }

  Future<void> updatePhase ({
    required String gameCode,
    required int phase,
    required int questionNumber,
    required String username,
  }) async {
    final Database db = await database;
    await db.rawQuery('''
      UPDATE $_tableName SET phase = '${phase+1}' WHERE username = '$username' AND game_code = '$gameCode' AND question_number = '$questionNumber'
    ''');
  }

  Future<void> deleteGameFromLocal({required String gameCode, required String username}) async {
    final db = await database;
    await db.rawQuery('''
      DELETE FROM $_tableName WHERE username = '$username' AND game_code = '$gameCode'
    '''
    );
  }

  Future<int> getHighestId() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT MAX(id) as maxId FROM $_tableName;'
    );

    int highestId = result.isNotEmpty ? result.first['maxId'] ?? 0 : 0;
    return highestId;
  }

  //TODO implementasi nyawa
  Future<void> updateHealth ({
    required String gameCode,
    required int questionNumber,
    required String username,
    required int health
  }) async {
    final Database db = await database;
    await db.rawQuery('''
      UPDATE $_tableName SET health = '${health-1}' WHERE username = '$username' AND game_code = '$gameCode' AND question_number = '$questionNumber'
    ''');
  }
}