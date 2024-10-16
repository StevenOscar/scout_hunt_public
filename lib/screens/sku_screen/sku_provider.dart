import 'package:flutter/material.dart';
import 'package:scout_hunt/constants/sku_list.dart';
import 'package:scout_hunt/models/progress_models.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/utils/student_progress_db_helper.dart';
import 'package:scout_hunt/utils/user_db_helper.dart';

class SkuProvider with ChangeNotifier {
  String? _agamaValue;
  List<int> _clearedSkuIndex = [];
  List<int> _selectedSkuIndex = [];
  List<String> _skuTaskListRamu = [];
  List<String> _skuTaskListRakit = [];
  List<String> _skuTaskListTerap = [];
  int _indexBalancer = 0;
  bool _isLoadingSubmit = false;
  String _selectedRank = "Penggalang Ramu";
  List<DropdownMenuItem> _selectableRank = [
    const DropdownMenuItem(
      value: "Penggalang Ramu",
      child: Text("Penggalang Ramu")
    )
  ];
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? get agamaValue => _agamaValue;
  List<int> get clearedSkuIndex => _clearedSkuIndex;
  List<int> get selectedSkuIndex => _selectedSkuIndex;
  List<String> get skuTaskListRamu => _skuTaskListRamu;
  List<String> get skuTaskListRakit => _skuTaskListRakit;
  List<String> get skuTaskListTerap => _skuTaskListTerap;
  int get indexBalancer => _indexBalancer;
  String get selectedRank => _selectedRank;
  bool get isLoadingSubmit => _isLoadingSubmit;
  List<DropdownMenuItem> get selectableRank => _selectableRank;

  Future<void> setInitialValue({
    required Map<int,bool> skuProgress,
    required String agama
  }) async {
    if(agama == "islam"){
      _skuTaskListRamu = SkuList.skuIslamList.sublist(0, 32);
      _skuTaskListRakit = SkuList.skuIslamList.sublist(32,64);
      _skuTaskListTerap = SkuList.skuIslamList.sublist(64,97);
    }

    if(agama == "katolik"){
      _skuTaskListRamu = SkuList.skuKatolikList.sublist(0, 32);
      _skuTaskListRakit = SkuList.skuKatolikList.sublist(32,64);
      _skuTaskListTerap = SkuList.skuKatolikList.sublist(64,96);
    }

    if(agama == "kristen"){
      _skuTaskListRamu = SkuList.skuKristenList.sublist(0, 33);
      _skuTaskListRakit = SkuList.skuKristenList.sublist(33,65);
      _skuTaskListTerap = SkuList.skuKristenList.sublist(65,99);
    }

    if(agama == "hindu"){
      _skuTaskListRamu = SkuList.skuHinduList.sublist(0, 36);
      _skuTaskListRakit = SkuList.skuHinduList.sublist(36,73);
      _skuTaskListTerap = SkuList.skuHinduList.sublist(73,110);
    }

    if(agama == "buddha"){
      _skuTaskListRamu = SkuList.skuBuddhaList.sublist(0, 33);
      _skuTaskListRakit = SkuList.skuBuddhaList.sublist(33,66);
      _skuTaskListTerap = SkuList.skuBuddhaList.sublist(66,100);
    }

    if(
      (agama == "islam" && skuProgress.values.where((value) => value == true).length >= 32) ||
      (agama == "katolik" && skuProgress.values.where((value) => value == true).length >= 32) ||
      (agama == "kristen" && skuProgress.values.where((value) => value == true).length >= 33) ||
      (agama == "hindu" && skuProgress.values.where((value) => value == true).length >= 36) ||
      (agama == "buddha" && skuProgress.values.where((value) => value == true).length >= 32)
    ){
      _selectableRank.add(
        DropdownMenuItem(
          value: "Penggalang Rakit",
          child: Text(
            "Penggalang Rakit",
            style: TextStyleWidget.bodyB1(),
          )
        )
      );
    } else {
      _selectableRank.add(
        DropdownMenuItem(
          enabled: false,
          value: "Penggalang Rakit",
          child: Text(
            "Penggalang Rakit",
            style: TextStyleWidget.bodyB1(
              color: ColorThemeStyle.grey80
            ),
          )
        )
      );
    }

    if(
      (agama == "islam" && skuProgress.values.where((value) => value == true).length >= 64) ||
      (agama == "katolik" && skuProgress.values.where((value) => value == true).length >= 64) ||
      (agama == "kristen" && skuProgress.values.where((value) => value == true).length >= 66) ||
      (agama == "hindu" && skuProgress.values.where((value) => value == true).length >= 73) ||
      (agama == "buddha" && skuProgress.values.where((value) => value == true).length >= 66)
    ){
      _selectableRank.add(
        DropdownMenuItem(
          value: "Penggalang Terap",
          child: Text(
            "Penggalang Terap",
            style: TextStyleWidget.bodyB1(),
          )
        )
      );
    } else{
      _selectableRank.add(
        DropdownMenuItem(
          enabled: false,
          value: "Penggalang Terap",
          child: Text(
            "Penggalang Terap",
            style: TextStyleWidget.bodyB1(
              color: ColorThemeStyle.grey80
            ),
          )
        )
      );
    }

    skuProgress.forEach((key, value) {
      if(value == true){
        _clearedSkuIndex.add(key);
      }
    });
    notifyListeners();
  }

  void selectSkuTask({required int index}){
    _selectedSkuIndex.add(index);
    notifyListeners();
  }

  void deselectSkuTask({required int index}){
    _selectedSkuIndex.remove(index);
    notifyListeners();
  }

  void selectRank({required String selectedRank, required String agama}){
    _selectedRank = selectedRank;

    if(_selectedRank == "Penggalang Ramu"){
      _indexBalancer = 0;
    }

    if(_selectedRank == "Penggalang Rakit"){
      if(agama == "islam"){
        _indexBalancer = 32;
      }

      if(agama == "katolik"){
        _indexBalancer = 32;
      }

      if(agama == "kristen"){
        _indexBalancer = 33;
      }

      if(agama == "hindu"){
        _indexBalancer = 36;
      }

      if(agama == "buddha"){
        _indexBalancer = 32;
      }
    }

    if(_selectedRank == "Penggalang Terap"){
      if(agama == "islam"){
        _indexBalancer = 64;
      }

      if(agama == "katolik"){
        _indexBalancer = 64;
      }

      if(agama == "kristen"){
        _indexBalancer = 66;
      }

      if(agama == "hindu"){
        _indexBalancer = 73;
      }

      if(agama == "buddha"){
        _indexBalancer = 66;
      }
    }
    notifyListeners();
  }

  Future<bool> submitProgress({
    required int userId,
    required ProgressModels currentProgress
  }) async {
    try {
      await StudentProgressDbHelper().submitSkuProgress(
        userId: userId,
        currentProgress: currentProgress,
        selectedSkuIndex: _selectedSkuIndex,
        indexBalancer: _indexBalancer,
        points: 50 * selectedSkuIndex.length
      );
      notifyListeners();
      return true;
    } catch (e) {
      notifyListeners();
      return false;
    }
  }

  void setLoading(){
    _isLoadingSubmit = !isLoadingSubmit;
    notifyListeners();
  }

  Future<void> clearProvider() async {
    _agamaValue = null;
    _clearedSkuIndex = [];
    _selectedSkuIndex = [];
    _indexBalancer = 0;
    _selectedRank = "Penggalang Ramu";
    _selectableRank = [
      DropdownMenuItem(
        value: "Penggalang Ramu",
        child: Text(
          "Penggalang Ramu",
          style: TextStyleWidget.bodyB1(),
        )
      )
    ];
    notifyListeners();
  }

  Future<bool> checkPembinaSku({
    required String username,
    required String password,
    required String classCode
  }) async {
    try {
      return await UserDbHelper().checkPembinaSku(
        username: username,
        password: password,
        classCode: classCode
      );
    } catch (e) {
      print(e);
      return false;
    }
  }
}
