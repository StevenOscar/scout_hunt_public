import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/assets_fonts.dart';
import 'package:scout_hunt/constants/routes.dart';
import 'package:scout_hunt/screens/play_screen/answer_screen/answer_provider.dart';
import 'package:scout_hunt/screens/play_screen/question_list/question_list_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/widget/button_widget.dart';
import 'package:scout_hunt/widget/text_field_widget.dart';

class AnswerScreen extends StatelessWidget {
  const AnswerScreen(int arguments, {super.key,});

  @override
  Widget build(BuildContext context) {
  QuestionListProvider questionListProvider = context.watch<QuestionListProvider>();
  AnswerProvider answerProvider = context.watch<AnswerProvider>();
  final args = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Jawab Soal",
          style: TextStyleWidget.titleT1(
            color: ColorThemeStyle.white100,
            fontWeight: FontWeightStyle.medium
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorThemeStyle.brown100,
        iconTheme: const IconThemeData(color: ColorThemeStyle.white100),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 40),
        child: FloatingActionButton.large(
          backgroundColor: ColorThemeStyle.blue60,
          child: const Icon(Icons.book, color: ColorThemeStyle.white100),
          onPressed: (){
            Navigator.pushNamed(context, Routes.materiCategoryScreen);
          }
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Consumer<AnswerProvider>(
                  builder: (context, answerProvider, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        for(var i = 0; i < 3;i++)
                        Icon(
                          CupertinoIcons.heart_solid,
                          color: i >= answerProvider.currentHealth ? ColorThemeStyle.black100 : ColorThemeStyle.red,
                          size: 30,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(2),
                    )
                  ),
                  child: Center(
                    child: Text(
                      questionListProvider.questionList[args].question,
                      style: TextStyleWidget.headlineH4(
                        fontWeight: FontWeightStyle.bold,
                        color: ColorThemeStyle.brown60
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                questionListProvider.questionList[args].category == "Pertanyaan Umum"
                ? const SizedBox.shrink()
                : Container(
                    height: 200,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 10
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(2),
                      )
                    ),
                    child: Center(
                      child: Text(
                        questionListProvider.questionList[args].answer.toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          fontFamily:
                            questionListProvider.questionList[args].category == "Sandi Kotak"
                            ? AssetsFonts.sandiKotak
                            : questionListProvider.questionList[args].category == "Sandi Rumput"
                            ? AssetsFonts.sandiRumput
                            : questionListProvider.questionList[args].category == "Semaphore"
                            ? AssetsFonts.semaphore
                            : AssetsFonts.morse
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFieldWidget(
                    controller: answerProvider.answerController,
                    hintText: "Jawaban",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ButtonWidget.defaultContainer(
                    onPressed: () async {
                      if(answerProvider.answerController.text.toLowerCase().replaceAll(' ', '') == questionListProvider.questionList[args].answer.toLowerCase().replaceAll(' ', '')){
                        bool navigate = false;
                        await questionListProvider.updatePhase(
                            index: args,
                          );
                        await questionListProvider.getGameData(
                          gameCode: questionListProvider.questionList[args].gameCode,
                          username: questionListProvider.questionList[args].username
                        );
                        if(!context.mounted) return;
                        await showDialog<bool>(
                          context: context,
                          useRootNavigator: false,
                          barrierDismissible: false,
                          builder: (context) {
                            return PopScope(
                              canPop: false,
                              child: AlertDialog(
                                actionsAlignment: MainAxisAlignment.center,
                                title: Center(
                                  child: Text(
                                    "Wah kamu hebat!",
                                    style: TextStyleWidget.headlineH4(
                                      fontWeight: FontWeightStyle.bold,
                                      color: ColorThemeStyle.brown100
                                    ),
                                  )
                                ),
                                content: const Text(
                                  "Selamat, kamu berhasil menjawab pertanyaan ini dengan benar!",
                                  textAlign: TextAlign.center,
                                ),
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                                    child: ButtonWidget.defaultContainer(
                                      height: 50,
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        navigate = true;
                                        answerProvider.clearProvider();
                                      },
                                      text: "Kembali"
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        );
                        if(navigate == true){
                          if(!context.mounted) return;
                          Navigator.popUntil(
                            context,
                            ModalRoute.withName(Routes.siswaQuestionListScreen)
                          );
                        } else {
                          if(!context.mounted) return;
                          Navigator.pop(context);
                        }
                      } else {
                        await questionListProvider.reduceHealth(index : args);
                        await questionListProvider.getGameData(
                          gameCode: questionListProvider.questionList[args].gameCode,
                          username: questionListProvider.questionList[args].username
                        );
                        answerProvider.getCurrentHealth(health: questionListProvider.questionList[args].health);
                        if(answerProvider.currentHealth == 0){
                          await questionListProvider.updatePhase(
                            index: args,
                          );
                          await questionListProvider.getGameData(
                            gameCode: questionListProvider.questionList[args].gameCode,
                            username: questionListProvider.questionList[args].username
                          );
                          if(!context.mounted) return;
                          showDialog(context: context, builder: (BuildContext context) {
                            return AlertDialog(
                              actionsAlignment: MainAxisAlignment.center,
                              title: Center(
                                child: Text(
                                  "Jawabanmu salah!",
                                  style: TextStyleWidget.headlineH4(
                                    fontWeight: FontWeightStyle.bold,
                                    color: ColorThemeStyle.brown100
                                  ),
                                )
                              ),
                              content: const Text(
                                "Nyawa kamu sudah habis! kamu gagal menjawab soal ini",
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                                  child: ButtonWidget.defaultContainer(
                                    height: 50,
                                    onPressed: (){
                                      Navigator.popUntil(
                                        context,
                                        ModalRoute.withName(Routes.siswaQuestionListScreen)
                                      );
                                      answerProvider.clearProvider();
                                    },
                                    text: "Kembali"
                                  ),
                                )
                              ],
                            );
                          });
                        } else {
                          if(!context.mounted) return;
                          showDialog(context: context, builder: (BuildContext context) {
                            return AlertDialog(
                              actionsAlignment: MainAxisAlignment.center,
                              title: Center(
                                child: Text(
                                  "Jawabanmu salah!",
                                  style: TextStyleWidget.headlineH4(
                                    fontWeight: FontWeightStyle.bold,
                                    color: ColorThemeStyle.brown100
                                  ),
                                )
                              ),
                              content: const Text(
                                "Nyawa kamu berkurang!",
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                                  child: ButtonWidget.defaultContainer(
                                    height: 50,
                                    onPressed: (){
                                      Navigator.pop(context);
                                      answerProvider.clearTextField();
                                    },
                                    text: "Coba Lagi"
                                  ),
                                )
                              ],
                            );
                          });
                        }
                      }
                    },
                    text: "Submit"
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}