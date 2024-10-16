import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';


class QuestionEditProvider with ChangeNotifier {
  String? _category = "Pertanyaan Umum";
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final TextEditingController _clueController = TextEditingController();
  CameraController? _cameraController;
  File? _imageFile;
  int _editIndex = -1;

  String? get category => _category;
  File? get imageFile => _imageFile;
  int? get editIndex => _editIndex;
  TextEditingController get questionController => _questionController;
  TextEditingController get answerController => _answerController;
  TextEditingController get clueController => _clueController;
  CameraController? get cameraController => _cameraController;

  void selectCategory(String? selectedCategory){
    _category = selectedCategory;
    notifyListeners();
  }

  void clearProvider(){
    _category = "Pertanyaan Umum";
    _questionController.text = "";
    _answerController.text = "";
    _clueController.text = "";
    _editIndex = -1;
    _imageFile = null;
    notifyListeners();
  }

  void textFieldOnChanged(){
    notifyListeners();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    await _cameraController?.initialize();
    notifyListeners();
  }

  Future<void> openCamera() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        // Move the file to the desired location
        final File newImage = File(image.path);

        _imageFile = newImage;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  void openFile(File? file){
    if(file != null){
      OpenFile.open(file.path);
    }
    notifyListeners();
  }

  void setField({
    required String category,
    required String question,
    required String imageClue,
    required File imageFile,
    required String answer,
    required int editIndex
  }){
    _editIndex = editIndex;
    _category = category;
    _questionController.text = question;
    _clueController.text = imageClue;
    _imageFile = imageFile;
    _answerController.text = answer;
    notifyListeners();
  }
}
