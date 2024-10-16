import 'package:scout_hunt/models/question_models.dart';
class GameDataModels {
  String title;
  int? points;
  List<QuestionModels> questionList;

  GameDataModels({
    required this.title,
    this.points,
    required this.questionList
  });
}