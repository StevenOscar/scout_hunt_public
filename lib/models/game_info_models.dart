class GameInfoModels {
  String title;
  String gameCode;
  int points;

  GameInfoModels({
    required this.title,
    required this.gameCode,
    required this.points,
  });

  static List<GameInfoModels> fromResponse(List<Map<String, dynamic>> response) {
    List<GameInfoModels> gameInfoList = [];
    for(int i = 0; i < response.length; i++){
      gameInfoList.add(
        GameInfoModels(
          title: response[i]['title'],
          gameCode: response[i]['game_code'],
          points: response[i]['points'],
        )
      );
    }

    return gameInfoList;
  }
}