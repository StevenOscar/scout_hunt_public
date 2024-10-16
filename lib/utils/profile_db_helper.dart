import 'package:scout_hunt/models/profile_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileDbHelper {
  late var supabase = Supabase.instance.client;

  Future<ProfileModels> fetchProfileSingle({required userId}) async {
    try {
      ProfileModels profile;
      final List<Map<String,dynamic>> response = await supabase.from('profile').select().eq('user_id','$userId');

      profile = ProfileModels.fromSingleResponse(response);

      return profile;
    } on PostgrestException catch (e) {
      print(e);
      throw "terjadi kesalahan";
    }
  }

  Future<void> insertClassCode({required String classCode, required int userId}) async {
    try {
      await supabase.from('profile').update({
        'class_code': classCode
      }).eq('user_id','$userId').select();
    } on PostgrestException catch (e) {
      print(e);
      throw "terjadi kesalahan";
    }
  }

  Future<void> updateProfile({
    required String badge,
    required String achievement,
    required int userId
  }) async {
    try {
      await supabase.from('profile').update({
        'badge': badge,
        'achievement': achievement
      }).eq('user_id', '$userId').select();
    } on PostgrestException catch (e) {
      print(e);
      throw "terjadi kesalahan";
    }
  }
}