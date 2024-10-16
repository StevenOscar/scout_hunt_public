import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/routes.dart';
import 'package:scout_hunt/screens/game_setup_screen/components/save_game_button.dart';
import 'package:scout_hunt/screens/game_setup_screen/game_setup_provider.dart';
import 'package:scout_hunt/screens/game_setup_screen/question_edit_screen/question_edit_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/widget/button_widget.dart';
import 'package:scout_hunt/widget/list_tile_widget.dart';
import 'package:scout_hunt/widget/text_field_widget.dart';

class GameSetupScreen extends StatelessWidget {
  final String context;

  const GameSetupScreen({
    super.key,
    required this.context
  });

  @override
  Widget build(BuildContext context) {
    GameSetupProvider gameSetupProvider = context.watch<GameSetupProvider>();
    QuestionEditProvider questionEditProvider = context.watch<QuestionEditProvider>();
    late final args = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          args,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Consumer<GameSetupProvider>(
              builder: (context, gameSetupProvider, child) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextFieldWidget(
                        controller: gameSetupProvider.titleController,
                        hintText: "Judul Permainan",
                        textAlign: TextAlign.center,
                        errorStyle: const TextStyle(fontSize: 1),
                        errorText: gameSetupProvider.isTitleValid ? null : " ",
                        onChanged: (_) {gameSetupProvider.validateTitle();},
                      ),
                    ),
                    gameSetupProvider.titleError.isNotEmpty ?
                    Text(
                      gameSetupProvider.titleError,
                      style: TextStyleWidget.labelL1(
                        color: ColorThemeStyle.red
                      ),
                    )
                    : const SizedBox(height: 17)
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              "Kode Permainan",
              style: TextStyleWidget.bodyB1(),
            ),
            const SizedBox(height: 3),
            Text(
              gameSetupProvider.gameCode,
              style: TextStyleWidget.headlineH1(
                fontWeight: FontWeightStyle.bold,
                color: ColorThemeStyle.brown60
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              itemCount: gameSetupProvider.questionList.length + 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if(index != gameSetupProvider.questionList.length && index < 5){
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: ColorThemeStyle.black100, width: 2),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: ListTileWidget.defaultContainer(
                      tileColor: ColorThemeStyle.brown60,
                      leading: SizedBox(
                        height: 50,
                        width: 50,
                        child: ClipRect(
                          child: Image.file(gameSetupProvider.questionList[index].imageFile!)
                        )
                      ),
                      title: Text(
                        "Soal Nomor ${index+1}",
                        style: TextStyleWidget.headlineH3(
                          color: ColorThemeStyle.white100,
                          fontWeight: FontWeightStyle.bold
                        ),
                      ),
                      onTap: (){
                        print(gameSetupProvider.questionList[index].imageFile!);
                        questionEditProvider.setField(
                          editIndex: index,
                          category: gameSetupProvider.questionList[index].category,
                          question: gameSetupProvider.questionList[index].question,
                          imageClue: gameSetupProvider.questionList[index].imageClue,
                          imageFile: gameSetupProvider.questionList[index].imageFile!,
                          answer: gameSetupProvider.questionList[index].answer
                        );
                        Navigator.pushNamed(
                          context,
                          Routes.pembinaQuestionEditScreen,
                          arguments: args
                        );
                      },
                      trailing: IconButton(
                        onPressed: (){
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              actionsAlignment: MainAxisAlignment.center,
                              title: Center(
                                child: Text(
                                  "Hapus Soal?",
                                  style: TextStyleWidget.headlineH4(
                                    fontWeight: FontWeightStyle.bold,
                                    color: ColorThemeStyle.brown100
                                  ),
                                )
                              ),
                              content: Text("Apakah anda yakin ingin menghapus soal nomor ${index+1}?"),
                              actions: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ButtonWidget.defaultContainer(
                                      width: 100,
                                      height: 35,
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      text: "Tidak"
                                    ),
                                    const SizedBox(width: 20),
                                    ButtonWidget.defaultContainer(
                                      backgroundColor: ColorThemeStyle.red,
                                      width: 100,
                                      height: 35,
                                      onPressed: (){
                                        gameSetupProvider.removeQuestion(index);
                                        Navigator.pop(context);
                                      },
                                      text: "Ya"
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete,color: ColorThemeStyle.white100,)
                      ),
                    )
                  );
                } else if(index < 5){
                  return Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: ColorThemeStyle.black100, width: 2),
                    ),
                    child: ListTile(
                      onTap: (){
                        Navigator.pushNamed(
                          context,
                          Routes.pembinaQuestionEditScreen,
                          arguments: args
                        );
                        questionEditProvider.clearProvider();
                      },
                      tileColor: ColorThemeStyle.brown60,
                      title: const Icon(Icons.add, size: 30, color: ColorThemeStyle.white100),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }
            ),
            const SizedBox(height: 40),
            SaveGameButton(saveButton: args),
            const SizedBox(height: 80)
          ],
        ),
      ),
    );
  }
}