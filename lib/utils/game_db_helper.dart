import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:scout_hunt/models/game_data_models.dart';
import 'package:scout_hunt/models/game_info_models.dart';
import 'package:scout_hunt/models/question_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GameDbHelper{
  late var supabase = Supabase.instance.client;

  Future<List<GameInfoModels>> fetchGameList(String username) async {
  try {
      final List<Map<String,dynamic>> response = await supabase.from('game').select().eq('created_by', username);

      List<GameInfoModels> gameInfoList = GameInfoModels.fromResponse(response);

      return gameInfoList;
    } on PostgrestException catch (e) {
      print(e);
      return [];
    }
  }

  Future<GameDataModels?> fetchGameDataPembina(String gameCode) async {
    try {
      final title = await supabase.from('game').select('title').eq('game_code', gameCode);
      final List<Map<String,dynamic>> response = await supabase.from('question').select().eq('game_code', gameCode);

      response.sort((a, b) => a['question_number'].compareTo(b['question_number']));

      List<Uint8List> imageList = [];
      for (var i = 0; i < response.length; i++) {
        final Uint8List imageData = await supabase.storage
          .from('game_bucket')
          .download('${gameCode}_${i + 1}');
        imageList.add(imageData);
      }

      List<QuestionModels> questionList = [];
      for (var i = 0; i < response.length; i++) {
        final File imageFile = await convertUint8ListToFile(
          imageList[i],
          '${gameCode}_${i + 1}.jpeg',
        );
        questionList.add(
          QuestionModels(
            category: response[i]['category'],
            question: response[i]['question'],
            answer: response[i]['answer'],
            imageClue: response[i]['image_clue'],
            imageFile: imageFile,
          ),
        );
      }

      GameDataModels gameData = GameDataModels(
        title: title[0]['title'],
        questionList: questionList
      );

      return gameData;
    } catch (e) {
      print(e);
      return null;
    }
  }

    Future<GameDataModels?> fetchGameDataSiswa(String gameCode) async {
    try {
      final titlePoints = await supabase.from('game').select('title, points').eq('game_code', gameCode);

      if(titlePoints.isEmpty){
        return null;
      }

      final List<Map<String,dynamic>> response = await supabase.from('question').select().eq('game_code', gameCode);

      response.sort((a, b) => a['question_number'].compareTo(b['question_number']));

      List<Uint8List> imageList = [];
      for (var i = 0; i < response.length; i++) {
        final Uint8List imageData = await supabase.storage
          .from('game_bucket')
          .download('${gameCode}_${i + 1}');
        imageList.add(imageData);
      }

      List<QuestionModels> questionList = [];
      for (var i = 0; i < response.length; i++) {
        questionList.add(
          QuestionModels(
            category: response[i]['category'],
            question: response[i]['question'],
            questionNumber: response[i]['question_number'],
            answer: response[i]['answer'],
            imageClue: response[i]['image_clue'],
            imageByte: imageList[i],
          ),
        );
      }

      GameDataModels gameData = GameDataModels(
        title: titlePoints[0]['title'],
        points: titlePoints[0]['points'],
        questionList: questionList
      );

      return gameData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> saveGameToDb({
    required List<QuestionModels> questionList,
    required String title,
    required String gameCode,
    required String username
  }) async {
    try {
      int points = questionList.length * 100;
      List<Map<String,dynamic>> responseGameDb = await supabase.from('game').insert({
        'created_by':username,
        'title': title,
        'game_code': gameCode,
        'points': points,
      }).select();

      print(responseGameDb);

      List<Map<String,dynamic>> questionListAsMap = [];
      for (var i = 0; i < questionList.length; i++) {
        questionListAsMap.add({
          'game_code': gameCode,
          'question_number': i+1,
          'category': questionList[i].category,
          'question': questionList[i].question,
          'answer': questionList[i].answer,
          'image_clue': questionList[i].imageClue,
          'image_file': '${gameCode}_${i+1}.jpeg'
        });
      }

      List<Map<String,dynamic>> responseQuestionDb = await supabase.from('question').insert(questionListAsMap).select();

      print(responseQuestionDb);

      for (var i = 0; i < questionList.length; i++) {
        final file = questionList[i].imageFile;
        final imageBytes = await file!.readAsBytes();
        img.Image? image = img.decodeImage(imageBytes);

        if (image == null) {
          throw Exception("Unable to decode image");
        }
        img.Image resizedImage = img.copyResize(image, width: 800);
        final compressedImageBytes = Uint8List.fromList(img.encodeJpg(resizedImage, quality: 60)); // quality 0-100

        final tempDir = await getTemporaryDirectory();
        File compressedImageFile = File(p.join(tempDir.path, 'compressed_${p.basename(file.path)}'));

        compressedImageFile = await compressedImageFile.writeAsBytes(compressedImageBytes);


        await supabase.storage.from('game_bucket').upload(
          '${gameCode}_${i+1}',
          compressedImageFile,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );
      }

    } catch (e) {
      print(e);
    }
  }

  Future<void> updateGameToDb({
    required List<QuestionModels> questionList,
    required String title,
    required String gameCode,
    required String username
  }) async {
    try {
      int points = questionList.length * 100;
      List<Map<String,dynamic>> responseGameDb = await supabase.from('game').update({
        'created_by':username,
        'title': title,
        'game_code': gameCode,
        'points': points,
      }).eq('game_code',gameCode).select();

      print(responseGameDb);

      List<Map<String,dynamic>> questionListAsMap = [];
      for (var i = 0; i < questionList.length; i++) {
        questionListAsMap.add({
          'game_code': gameCode,
          'question_number': i+1,
          'category': questionList[i].category,
          'question': questionList[i].question,
          'answer': questionList[i].answer,
          'image_clue': questionList[i].imageClue,
          'image_file': '${gameCode}_${i+1}.jpeg'
        });
      }

      await supabase.from('question').delete().eq('game_code', gameCode);
      List<Map<String,dynamic>> responseQuestionDb = await supabase.from('question').insert(questionListAsMap).select();

      print(responseQuestionDb);

      for (var i = 0; i < questionList.length; i++) {
        final file = questionList[i].imageFile;
        final imageBytes = await file!.readAsBytes();
        img.Image? image = img.decodeImage(imageBytes);

        if (image == null) {
          throw Exception("Unable to decode image");
        }

        img.Image resizedImage = img.copyResize(image, width: 800);
        final compressedImageBytes = Uint8List.fromList(img.encodeJpg(resizedImage, quality: 60)); // quality 0-100

        final tempDir = await getTemporaryDirectory();
        File compressedImageFile = File(p.join(tempDir.path, 'compressed_${p.basename(file.path)}'));

        compressedImageFile = await compressedImageFile.writeAsBytes(compressedImageBytes);

        await supabase.storage.from('game_bucket').upload(
          '${gameCode}_${i+1}',
          compressedImageFile,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
        );
      }

    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteGameInDb({
    required String gameCode,
  }) async {
    try {
      await supabase.from('game').delete().eq('game_code',gameCode);
      await supabase.from('question').delete().eq('game_code',gameCode);
    } catch (e) {
      print(e);
    }
  }
}

  Future<File> convertUint8ListToFile(Uint8List uint8List, String fileName) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String filePath = '${appDir.path}/$fileName';
    final File file = File(filePath);
    await file.writeAsBytes(uint8List);
    return file;
  }