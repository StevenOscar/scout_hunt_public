class ClassListModels{
  String createdBy;
  String title;
  String classCode;

  ClassListModels({
    required this.createdBy,
    required this.title,
    required this.classCode,
  });

  static List<ClassListModels> fromResponse(List<Map<String, dynamic>> response) {
    List<ClassListModels> classList = [];
    for(int i = 0; i < response.length; i++){
      classList.add(
        ClassListModels(
          classCode: response[i]['class_code'],
          createdBy: response[i]['created_by'],
          title: response[i]['title'],
        )
      );
    }
    return classList;
  }

  factory ClassListModels.fromSingleResponse(List<Map<String, dynamic>> response) {
    return ClassListModels(
      classCode: response[0]['class_code'],
      createdBy: response[0]['created_by'],
      title: response[0]['title'],
    );
  }
}