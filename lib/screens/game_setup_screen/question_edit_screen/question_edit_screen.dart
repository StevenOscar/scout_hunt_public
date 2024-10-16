
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/screens/game_setup_screen/game_setup_provider.dart';
import 'package:scout_hunt/screens/game_setup_screen/question_edit_screen/question_edit_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/widget/button_widget.dart';
import 'package:scout_hunt/widget/text_field_widget.dart';

class QuestionEditScreen extends StatelessWidget {
  final String context;
  const QuestionEditScreen({
    super.key,
    required this.context
  });

  @override
  Widget build(BuildContext context) {
    QuestionEditProvider questionEditProvider = context.watch<QuestionEditProvider>();
    GameSetupProvider gameSetupProvider = context.watch<GameSetupProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Soal",
          style: TextStyleWidget.titleT1(
            color: ColorThemeStyle.white100,
            fontWeight: FontWeightStyle.medium
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorThemeStyle.brown100,
        iconTheme: const IconThemeData(color: ColorThemeStyle.white100),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Isi Soal",
                  style: TextStyleWidget.bodyB1(
                    fontWeight: FontWeightStyle.bold,
                    color: ColorThemeStyle.brown100
                  ),
                ),
                Consumer<QuestionEditProvider>(
                  builder: (context, questionEditProvider, child) {
                    return TextFieldWidget(
                      controller: questionEditProvider.questionController,
                      hintText: 'Isi Soal',
                      onChanged: (_){questionEditProvider.textFieldOnChanged();},
                      textCapitalization: TextCapitalization.none,
                      prefixIcon: const FractionallySizedBox(
                        widthFactor: 0.06,
                        child: Icon(Icons.question_mark)
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "Kategori Soal",
                  style: TextStyleWidget.bodyB1(
                    fontWeight: FontWeightStyle.bold,
                    color: ColorThemeStyle.brown100
                  ),
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // Garis border biasa
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.grey, // Warna garis
                        width: 2.0, // Ketebalan garis
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // Garis border saat difokuskan
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: ColorThemeStyle.brown100, // Warna garis
                        width: 2.0, // Ketebalan garis
                      ),
                    ),
                  ),
                  value: questionEditProvider.category,
                  items: [
                    DropdownMenuItem(
                      value: "Pertanyaan Umum",
                      child: Text(
                        "Pertanyaan Umum",
                        style: TextStyleWidget.bodyB1(),
                      )
                    ),
                    DropdownMenuItem(
                      value: "Sandi Kotak",
                      child: Text(
                        "Sandi Kotak",
                        style: TextStyleWidget.bodyB1(),
                      )
                    ),
                    DropdownMenuItem(
                      value: "Sandi Rumput",
                      child: Text(
                        "Sandi Rumput",
                        style: TextStyleWidget.bodyB1(),
                      )
                    ),
                    DropdownMenuItem(
                      value: "Semaphore",
                      child: Text(
                        "Semaphore",
                        style: TextStyleWidget.bodyB1(),
                      )
                    ),
                    DropdownMenuItem(
                      value: "Morse",
                      child: Text(
                        "Morse",
                        style: TextStyleWidget.bodyB1(),
                      )
                    ),
                  ],
                  onChanged: (categoryValue){
                    questionEditProvider.selectCategory(categoryValue);
                  }
                ),
                const SizedBox(height: 20),
                Text(
                  "Jawaban",
                  style: TextStyleWidget.bodyB1(
                    fontWeight: FontWeightStyle.bold,
                    color: ColorThemeStyle.brown100
                  ),
                ),
                Consumer<QuestionEditProvider>(
                  builder: (context, questionEditProvider, child) {
                    return TextFieldWidget(
                      controller: questionEditProvider.answerController,
                      hintText: 'Jawaban',
                      onChanged: (_){questionEditProvider.textFieldOnChanged();},
                      textCapitalization: TextCapitalization.none,
                      prefixIcon: const FractionallySizedBox(
                        widthFactor: 0.06,
                        child: Icon(Icons.check)
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "Gambar Target",
                  style: TextStyleWidget.bodyB1(
                    fontWeight: FontWeightStyle.bold,
                    color: ColorThemeStyle.brown100
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ButtonWidget.defaultContainer(
                    height: 40,
                    onPressed: (){
                      questionEditProvider.openCamera();
                    },
                    text: "Buka Kamera"
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ButtonWidget.defaultContainer(
                    height: 40,
                    onPressed: (questionEditProvider.imageFile == null) ? null : (){
                      questionEditProvider.openFile(questionEditProvider.imageFile);
                      print(questionEditProvider.imageFile);
                    },
                    text: "Lihat Gambar"
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Petunjuk",
                  style: TextStyleWidget.bodyB1(
                    fontWeight: FontWeightStyle.bold,
                    color: ColorThemeStyle.brown100
                  ),
                ),
                Consumer<QuestionEditProvider>(
                  builder: (context, questionEditProvider, child) {
                    return TextFieldWidget(
                      controller: questionEditProvider.clueController,
                      hintText: 'Petunjuk',
                      onChanged: (_){questionEditProvider.textFieldOnChanged();},
                      textCapitalization: TextCapitalization.none,
                      prefixIcon: const FractionallySizedBox(
                        widthFactor: 0.06,
                        child: Icon(Icons.lightbulb)
                      ),
                    );
                  },
                ),
                const SizedBox(height: 50),
                Consumer<QuestionEditProvider>(
                  builder: (context, questionEditProvider, child) {
                    return ButtonWidget.defaultContainer(
                      text: "Simpan Soal",
                      onPressed: (
                          questionEditProvider.answerController.text.isNotEmpty &&
                          questionEditProvider.questionController.text.isNotEmpty &&
                          questionEditProvider.clueController.text.isNotEmpty &&
                          questionEditProvider.category!.isNotEmpty &&
                          questionEditProvider.imageFile != null
                        ) ? (){
                          if(questionEditProvider.editIndex == -1){
                            gameSetupProvider.addQuestion(
                              category: questionEditProvider.category.toString(),
                              imageClue: questionEditProvider.clueController.text,
                              question: questionEditProvider.questionController.text,
                              answer: questionEditProvider.answerController.text,
                              imageFile: questionEditProvider.imageFile!
                            );
                          } else {
                            gameSetupProvider.editQuestion(
                              index: questionEditProvider.editIndex!,
                              category: questionEditProvider.category.toString(),
                              answer: questionEditProvider.answerController.text,
                              question: questionEditProvider.questionController.text,
                              imageClue: questionEditProvider.clueController.text,
                              imageFile: questionEditProvider.imageFile!
                            );
                          }
                        Navigator.pop(context);
                        questionEditProvider.clearProvider();
                      } : null
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}