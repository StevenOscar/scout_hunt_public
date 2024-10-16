
import 'package:scout_hunt/models/login_models.dart';
import 'package:scout_hunt/models/progress_models.dart';
import 'package:scout_hunt/models/register_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDbHelper {
  late var supabase = Supabase.instance.client;

  Future<bool> checkDuplicateUsername(String username) async {
    try {
      List<Map<String,dynamic>> response = await supabase.from('user').select('username').eq('username',username);

      if (response.isEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> checkPembinaSku({
    required String username,
    required String password,
    required String classCode
  }) async {
    try {
      final List<Map<String,dynamic>> checkIsPembina = await supabase.from('user').select('username, role').eq('username',username).eq('password',password);

      if (checkIsPembina.isEmpty) {
        return false;
      } else if(checkIsPembina[0]['role'] == 1){
        final List<Map<String,dynamic>> checkClass = await supabase.from('class').select('created_by').eq('created_by',username).eq('class_code', classCode);
        if(checkClass.isEmpty){
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<LoginModels> login({required username, required password}) async {
    try {
      LoginModels user;
      final List<Map<String,dynamic>> response = await supabase.from('user').select('user_id, username, nama, agama, role').eq('username','$username').eq('password','$password');

      print(response);

      user = LoginModels.fromSingleResponse(response);

      return user;
    } on PostgrestException catch (e) {
      print(e);
      throw "terjadi kesalahan";
    }
  }

  Future<bool> register({
    required String username,
    required String password,
    required String nama,
    required String role,
    String? rank,
    required String agama
  }) async {
    try {
      List<Map<String,dynamic>> response = await supabase.from('user').insert({
        'username':username,
        'password':password,
        'nama':nama,
        'role': role == "siswa" ? 0 : 1,
        'agama': agama
      }).select();
      print(response);
      RegisterModels userData = RegisterModels.fromResponse(response);

      if(role == "siswa"){
        if(userData.agama == "islam"){
          await supabase.from('student_progress').insert({
            'user_id': userData.userId,
            'sku_progress': ProgressModels.blankSkuIslam,
            'game_progress':{'finished_game': []},
            'points': 0,
            'question_answered': 0
          });
        } else if(userData.agama == "katolik"){
          await supabase.from('student_progress').insert({
            'user_id': userData.userId,
            'sku_progress': ProgressModels.blankSkuKatolik,
            'game_progress':{'finished_game': []},
            'points': 0,
            'question_answered': 0
          });
        } else if(userData.agama == "kristen"){
          await supabase.from('student_progress').insert({
            'user_id': userData.userId,
            'sku_progress': ProgressModels.blankSkuKristen,
            'game_progress':{'finished_game': []},
            'points': 0,
            'question_answered': 0
          });
        }else if(userData.agama == "hindu"){
          await supabase.from('student_progress').insert({
            'user_id': userData.userId,
            'sku_progress': ProgressModels.blankSkuHindu,
            'game_progress':{'finished_game': []},
            'points': 0,
            'question_answered': 0
          });
        } else if(userData.agama == "buddha"){
          await supabase.from('student_progress').insert({
            'user_id': userData.userId,
            'sku_progress': ProgressModels.blankSkuBuddha,
            'game_progress': {'finished_game': []},
            'points': 0,
            'question_answered': 0
          });
        }

        await supabase.from('profile').insert({
          'user_id':'${userData.userId}',
          'badge':'Getting Started',
          'achievement':'Newbie',
          'class_code': null
        });
      }

      return true;
    } on PostgrestException catch (e) {
      print(e);
      return false;
    }
  }
}