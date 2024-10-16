import 'dart:io';
import 'dart:typed_data';

class QuestionModels {
  int? questionNumber;
  String category;
  String question;
  String answer;
  String imageClue;
  File? imageFile;
  Uint8List? imageByte;

  QuestionModels({
    this.questionNumber,
    required this.category,
    required this.question,
    required this.answer,
    required this.imageClue,
    this.imageFile,
    this.imageByte
  });
}