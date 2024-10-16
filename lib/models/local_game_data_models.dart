import 'dart:typed_data';


class LocalGameDataModels {
  int id;
  String username;
  String title;
  int points;
  int phase;
  int health;
  int questionNumber;
  String gameCode;
  String category;
  String question;
  String answer;
  String imageClue;
  Uint8List? imageByte;

  LocalGameDataModels({
    required this.id,
    required this.username,
    required this.title,
    required this.points,
    required this.phase,
    required this.health,
    required this.questionNumber,
    required this.gameCode,
    required this.category,
    required this.question,
    required this.answer,
    required this.imageClue,
    required this.imageByte
  });


  factory LocalGameDataModels.fromMap(Map<String,dynamic> map){
    return LocalGameDataModels(
      id: map['id'],
      username: map['username'],
      title: map['title'],
      points: map['points'],
      phase: map['phase'],
      health: map['health'],
      questionNumber: map['question_number'],
      gameCode: map['game_code'],
      category: map['category'],
      question: map['question'],
      answer: map['answer'],
      imageClue: map['image_clue'],
      imageByte: map['image_byte'],
    );
  }
}