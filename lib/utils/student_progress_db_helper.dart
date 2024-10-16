import 'package:scout_hunt/models/progress_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StudentProgressDbHelper {
  late var supabase = Supabase.instance.client;

  Future<ProgressModels> fetchProgress({required userId}) async {
    try {
      ProgressModels progress;
      final List<Map<String,dynamic>> response = await supabase.from('student_progress').select().eq('user_id','$userId');
      print("Dari student db : $response");
      progress = ProgressModels.fromResponse(response);

      return progress;
    } on PostgrestException catch (e) {
      print(e);
      throw "terjadi kesalahan";
    }
  }

  Future<void> submitGameProgress({
    required int userId,
    required String gameCode,
    required ProgressModels currentProgress,
    required int points,
    required int correctAnswer
  }) async {
    try {
      List<String> appendedProgress = currentProgress.gameProgress;
      int appendedPoints = currentProgress.points + points;
      int appendedQuestionQuantity = currentProgress.questionAnswered + correctAnswer;
      appendedProgress.add(gameCode);
      await supabase.from('student_progress').update({
        'game_progress' : {
          'finished_game': appendedProgress
        },
        'points' : appendedPoints,
        'question_answered' : appendedQuestionQuantity
      }).eq('user_id','$userId').select();

    } on PostgrestException catch (e) {
      print(e);
      throw "terjadi kesalahan";
    }
  }

  Future<void> submitSkuProgress({
    required int userId,
    required ProgressModels currentProgress,
    required List<int> selectedSkuIndex,
    required int indexBalancer,
    required int points
  }) async {
    try {
      for(int i = 0; i < selectedSkuIndex.length; i++){
        currentProgress.skuProgress.update(selectedSkuIndex[i] + indexBalancer, (value) => value = true);
      }

      Map<String,bool> convertedProgress = currentProgress.skuProgress.map((key, value) {
        return MapEntry((key).toString(), value);
      });
      int appendedPoints = currentProgress.points + points;

      await supabase.from('student_progress').update({
        'sku_progress' : convertedProgress,
        'points' : appendedPoints,
      }).eq('user_id','$userId').select();

    } on PostgrestException catch (e) {
      print(e);
      throw "terjadi kesalahan";
    }
  }
}