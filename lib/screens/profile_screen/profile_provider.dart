import 'package:flutter/material.dart';
import 'package:scout_hunt/constants/badge_list.dart';
import 'package:scout_hunt/models/login_models.dart';
import 'package:scout_hunt/models/progress_models.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/utils/profile_db_helper.dart';

class ProfileProvider with ChangeNotifier {
  int _selectedBadgeIndex = -1;
  String _achievementValue = "";
  List<int> _selectableBadgeIndex = [0];
  List<DropdownMenuItem> _selectableAchievement = [
    DropdownMenuItem(
      value: "Newbie",
      child: Text(
        "Newbie",
        style: TextStyleWidget.bodyB1(),
      )
    )
  ];
  bool _loadingProfile = false;
  final List<String> _badgeMessageList = [
    "",
    "Selesaikan SKU Penggalang Ramu",
    "Selesaikan SKU Penggalang Rakit",
    "Selesaikan SKU Penggalang Terap",
    "Jawab 1 soal di permainan",
    "Jawab 5 soal di permainan",
    "Jawab 10 soal di permainan",
    "Jawab 20 soal di permainan",
    "Kumpulkan 100 points",
    "Kumpulkan 1000 points",
    "Kumpulkan 2500 points",
    "Kumpulkan 5000 points",
    "Dapatkan semua badge",
  ];

  int get selectedBadgeIndex => _selectedBadgeIndex;
  String get achievementValue => _achievementValue;
  List<int> get selectableBadgeIndex => _selectableBadgeIndex;
  List<DropdownMenuItem> get selectableAchievement => _selectableAchievement;
  bool get loadingProfile => _loadingProfile;
  List<String> get badgeMessageList => _badgeMessageList;

  void selectAchievement(String selectedAchievement){
    _achievementValue = selectedAchievement;
    notifyListeners();
  }

  void selectBadge(int index){
    _selectedBadgeIndex = index;
    notifyListeners();
  }

  Future<void> updateProfile({required int userId}) async {
    _loadingProfile = true;
    notifyListeners();
    try {
      await ProfileDbHelper().updateProfile(
        badge: BadgeList.badgeName[_selectedBadgeIndex],
        achievement: _achievementValue,
        userId: userId
      );
      _loadingProfile = false;
      notifyListeners();
    } catch (e) {
      _loadingProfile = false;
      notifyListeners();
      print(e);
    }
  }

  Future<void> setInitialValue({
    required String achievement,
    required String badge,
    required ProgressModels userProgress,
    required LoginModels userData
  }) async {
    _achievementValue = achievement;
    _selectedBadgeIndex = BadgeList.badgeName.indexWhere((element) => element == badge);

    //Badge accu point 4
    if(userProgress.points >= 5000){
      _selectableBadgeIndex.add(11);
    }

    //Badge accu point 3
    if(userProgress.points >= 2500){
      _selectableBadgeIndex.add(10);
    }

    //Badge accu point 2
    if(userProgress.points >= 1000){
      _selectableBadgeIndex.add(9);
    }

    //Badge accu point 1
    if(userProgress.points >= 100){
      _selectableBadgeIndex.add(8);
    }

    //Badge question answered 4
    if(userProgress.questionAnswered >= 20){
      _selectableBadgeIndex.add(7);
    }

    //Badge question answered 3
    if(userProgress.questionAnswered >= 10){
      _selectableBadgeIndex.add(6);
    }

    //Badge question answered 2
    if(userProgress.questionAnswered >= 5){
      _selectableBadgeIndex.add(5);
    }

    //Badge question answered 1
    if(userProgress.questionAnswered >= 1){
      _selectableBadgeIndex.add(4);
    }

    //Badge penggalang terap
    if(
      (userData.agama == "islam" && userProgress.skuProgress.values.where((value) => value == true).length >= 97) ||
      (userData.agama == "katolik" && userProgress.skuProgress.values.where((value) => value == true).length >= 96) ||
      (userData.agama == "kristen" && userProgress.skuProgress.values.where((value) => value == true).length >= 99) ||
      (userData.agama == "hindu" && userProgress.skuProgress.values.where((value) => value == true).length >= 110) ||
      (userData.agama == "buddha" && userProgress.skuProgress.values.where((value) => value == true).length >= 100)
    ){
      _selectableBadgeIndex.add(3);
    }

    //Badge penggalang rakit
    if(
      (userData.agama == "islam" && userProgress.skuProgress.values.where((value) => value == true).length >= 64) ||
      (userData.agama == "katolik" && userProgress.skuProgress.values.where((value) => value == true).length >= 64) ||
      (userData.agama == "kristen" && userProgress.skuProgress.values.where((value) => value == true).length >= 66) ||
      (userData.agama == "hindu" && userProgress.skuProgress.values.where((value) => value == true).length >= 73) ||
      (userData.agama == "buddha" && userProgress.skuProgress.values.where((value) => value == true).length >= 66)
    ){
      _selectableBadgeIndex.add(2);
    }

    //Badge penggalang ramu
    if(
      (userData.agama == "islam" && userProgress.skuProgress.values.where((value) => value == true).length >= 32) ||
      (userData.agama == "katolik" && userProgress.skuProgress.values.where((value) => value == true).length >= 32) ||
      (userData.agama == "kristen" && userProgress.skuProgress.values.where((value) => value == true).length >= 33) ||
      (userData.agama == "hindu" && userProgress.skuProgress.values.where((value) => value == true).length >= 36) ||
      (userData.agama == "buddha" && userProgress.skuProgress.values.where((value) => value == true).length >= 32)
    ){
      _selectableBadgeIndex.add(1);
    }

    //Badge all complete
    if(_selectableBadgeIndex.length == 12){
      _selectableBadgeIndex.add(12);
    }

    //achievement experienced hunter
    if(userProgress.gameProgress.length >= 2){
      _selectableAchievement.add(
        DropdownMenuItem(
          value: "Experienced Hunter",
          child: Text(
            "Experienced Hunter",
            style: TextStyleWidget.bodyB1(),
          )
        )
      );
    }

    //achievement veteran hunter
    if(userProgress.gameProgress.length >= 5){
      _selectableAchievement.add(
        DropdownMenuItem(
          value: "Veteran Hunter",
          child: Text(
            "Veteran Hunter",
            style: TextStyleWidget.bodyB1(),
          )
        )
      );
    }

    //achievement legendary hunter
    if(userProgress.gameProgress.length >= 10){
      _selectableAchievement.add(
        DropdownMenuItem(
          value: "Legendary Hunter",
          child: Text(
            "Legendary Hunter",
            style: TextStyleWidget.bodyB1(),
          )
        )
      );
    }

    notifyListeners();
  }

  Future<void> clearProvider() async {
    _selectedBadgeIndex = -1;
    _achievementValue = "";
    _selectableBadgeIndex = [0];
    _selectableAchievement = [
      DropdownMenuItem(
        value: "Newbie",
        child: Text(
          "Newbie",
          style: TextStyleWidget.bodyB1(),
        )
      )
    ];
    _loadingProfile = false;
    notifyListeners();
  }
}
