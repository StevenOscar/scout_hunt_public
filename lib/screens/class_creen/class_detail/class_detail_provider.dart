import 'package:flutter/material.dart';
import 'package:scout_hunt/models/class_detail_models.dart';
import 'package:scout_hunt/models/progress_models.dart';
import 'package:scout_hunt/utils/class_db_helper.dart';

class ClassDetailProvider with ChangeNotifier {
  ClassDetailModels _classDetail = ClassDetailModels(
    classCode: "-",
    userList: [],
    profileList: [],
    progressList: [],
    title: "Nama Kelas",
    createdBy: "-"
  );
  bool _isLoadingClass = false;

  ClassDetailModels get classDetail => _classDetail;
  bool get isLoadingClass => _isLoadingClass;

  Future<void> getClassDetail(String classCode) async {
    _isLoadingClass = true;
    notifyListeners();
    try {
      _classDetail = await ClassDbHelper().fetchClassDetail(classCode);
      List<ProgressModels> storeProgress = List.from(_classDetail.progressList);
      List<int> storeIndex = [];

      _classDetail.progressList.sort((a, b) => b.points.compareTo(a.points));

      for (int i = 0; i < _classDetail.progressList.length; i++) {
        for (int j = 0; j < storeProgress.length; j++) {
          if (_classDetail.progressList[i] == storeProgress[j]) {
            storeIndex.add(j);
          }
        }
      }

      _classDetail.userList = List.generate(classDetail.progressList.length, (index) => _classDetail.userList[storeIndex[index]]);
      _classDetail.profileList = List.generate(classDetail.progressList.length, (index) => _classDetail.profileList[storeIndex[index]]);
      _isLoadingClass = false;
      notifyListeners();
    } catch (e) {
      print(e);
      _isLoadingClass = false;
      notifyListeners();
    }
  }
}
