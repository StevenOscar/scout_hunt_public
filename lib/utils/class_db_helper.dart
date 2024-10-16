import 'package:scout_hunt/models/class_detail_models.dart';
import 'package:scout_hunt/models/class_list_models.dart';
import 'package:scout_hunt/models/login_models.dart';
import 'package:scout_hunt/models/profile_models.dart';
import 'package:scout_hunt/models/progress_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ClassDbHelper {
  late var supabase = Supabase.instance.client;
  Future<List<ClassListModels>> fetchClassList(String username) async {
  try {
      final List<Map<String,dynamic>> response = await supabase.from('class').select().eq('created_by', username);

      List<ClassListModels> classList = ClassListModels.fromResponse(response);

      return classList;
    } on PostgrestException catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> insertClassToDb({
    required String title,
    required String classCode,
    required String username,
  }) async {
    try {
      List<Map<String,dynamic>> responseClassDb = await supabase.from('class').insert({
        'created_by':username,
        'title': title,
        'class_code': classCode
      }).select();

      print(responseClassDb);

    } catch (e) {
      print(e);
    }
  }

  Future<ClassDetailModels> fetchClassDetail(String classCode) async {
    try {
      final List<Map<String,dynamic>> responseClassDb = await supabase.from('class').select().eq('class_code', classCode);

      print("responseClassDb : $responseClassDb");

      ClassListModels classList = ClassListModels.fromSingleResponse(responseClassDb);

      final List<Map<String,dynamic>> responseProfileDb = await supabase.from('profile').select().eq('class_code', classCode);

      print("responseProfileDb : $responseProfileDb");

      List<ProfileModels> profileList = [];
      List<ProgressModels> progressList = [];
      List<LoginModels> userList = [];

      if(responseProfileDb.isNotEmpty){
        profileList = ProfileModels.fromListResponse(responseProfileDb);
        for (var i = 0; i < profileList.length; i++) {
          final List<Map<String,dynamic>> responseUserDb = await supabase.from('user').select('username, nama, user_id, agama').eq('user_id','${profileList[i].userId}');
          final List<Map<String,dynamic>> responseProgressDb = await supabase.from('student_progress').select().eq('user_id','${profileList[i].userId}');
          ProgressModels progress = ProgressModels.fromResponse(responseProgressDb);
          progressList.add(
            progress
          );
          userList.add(
            LoginModels(
              userId: responseUserDb[0]['user_id'],
              username: responseUserDb[0]['username'],
              nama: responseUserDb[0]['nama'],
              agama: responseUserDb[0]['agama'],
            )
          );
          print("user List : ${userList}");
        }
      }

      ClassDetailModels classDetail = ClassDetailModels(
        classCode: classCode,
        userList: userList,
        profileList: profileList,
        progressList: progressList,
        title: classList.title,
        createdBy: classList.createdBy
      );
      return classDetail;
    } on PostgrestException catch (e) {
      print(e);
      return ClassDetailModels(
        classCode: "-",
        userList: [],
        profileList: [],
        progressList: [],
        title: "Nama Kelas",
        createdBy: "-"
      );
    }
  }

  Future<bool> checkClassExistence({required String classCode}) async {
  try {
      List<Map<String,dynamic>> response = await supabase.from('class').select('class_code').eq('class_code',classCode);

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
}