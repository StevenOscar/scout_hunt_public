import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/routes.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/user_provider.dart';
import 'package:scout_hunt/screens/play_screen/answer_screen/answer_provider.dart';
import 'package:scout_hunt/screens/play_screen/question_list/question_list_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/widget/button_widget.dart';
import 'package:scout_hunt/widget/list_tile_widget.dart';
import 'package:scout_hunt/widget/snack_bar_widget.dart';

class QuestionListScreen extends StatelessWidget {
  const QuestionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    AnswerProvider answerProvider = context.watch<AnswerProvider>();
    QuestionListProvider questionListProvider = context.read<QuestionListProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Soal",
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                questionListProvider.questionList[0].title,
                style: TextStyleWidget.displayD4(
                  fontWeight: FontWeightStyle.bold,color: ColorThemeStyle.brown100
                ),
              ),
              const SizedBox(height: 29),
              Consumer<QuestionListProvider>(
                builder: (context, questionListProvider, child) {
                  return ListView.builder(
                    itemCount: questionListProvider.questionList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: ColorThemeStyle.black100, width: 2),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: ListTileWidget.defaultContainer(
                          onTap: questionListProvider.questionList[index].phase == 3 ||
                                questionListProvider.questionList[index].health <= 0 ||
                                index != questionListProvider.activeQuestionIndex
                          ? null
                          : () async{
                              if(questionListProvider.questionList[index].phase == 1){
                                if(!context.mounted) return;
                                Navigator.pushNamed(
                                  context,
                                  Routes.siswaHuntScreen,
                                  arguments: index
                                );
                              } else if(questionListProvider.questionList[index].phase == 2){
                                answerProvider.getCurrentHealth(
                                  health: questionListProvider.questionList[index].health
                                );
                                Navigator.pushNamed(
                                  context,
                                  Routes.siswaAnswerScreen,
                                  arguments: index
                                );
                              }
                          },
                          leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: ClipRect(
                              child: Image.memory(questionListProvider.questionList[index].imageByte!)
                            )
                          ),
                          title: Text(
                            "Soal nomor ${questionListProvider.questionList[index].questionNumber}",
                            style: TextStyleWidget.headlineH3(
                              color: ColorThemeStyle.white100,
                              fontWeight: FontWeightStyle.bold
                            ),
                          ),
                          tileColor: index > questionListProvider.activeQuestionIndex ? ColorThemeStyle.grey100 : ColorThemeStyle.brown100,
                          trailing: questionListProvider.questionList[index].phase == 3 ?
                          questionListProvider.questionList[index].health == 0 ? const Icon(Icons.close_sharp, color: ColorThemeStyle.white100,size: 30) : const Icon(Icons.check, color: ColorThemeStyle.white100,size: 30)
                          : const Icon(Icons.arrow_right_alt_rounded, color: ColorThemeStyle.white100,size: 30),
                        ),
                      );
                    }
                  );
                },
              ),
              Consumer<QuestionListProvider>(
                builder: (context, questionListProvider, child) {
                  return questionListProvider.loadingSubmit == true ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Center(child: CircularProgressIndicator(),),
                  )
                  : Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Total points",
                                style: TextStyleWidget.headlineH4(
                                  fontWeight: FontWeightStyle.bold,color: ColorThemeStyle.brown100
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                questionListProvider.currentPoints.toString(),
                                style: TextStyleWidget.headlineH5(
                                  fontWeight: FontWeightStyle.bold,
                                  color: ColorThemeStyle.brown60
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Correct Answers",
                                style: TextStyleWidget.headlineH4(
                                  fontWeight: FontWeightStyle.bold,color: ColorThemeStyle.brown100
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                questionListProvider.correctAnswers.toString(),
                                style: TextStyleWidget.headlineH5(
                                  fontWeight: FontWeightStyle.bold,
                                  color: ColorThemeStyle.brown60
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      questionListProvider.questionList.every((element) => element.phase == 3) ?
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          "Kamu sudah menjawab semua pertanyaan! Silahkan tekan tombol submit untuk menyelesaikan permainan",
                          textAlign: TextAlign.center,
                          style: TextStyleWidget.bodyB2(
                            fontWeight: FontWeightStyle.bold
                          ),
                        ),
                      ) : const SizedBox.shrink(),
                      const SizedBox(height: 15),
                      ButtonWidget.defaultContainer(
                          text: "Submit",
                          backgroundColor: ColorThemeStyle.brown100,
                          onPressed: questionListProvider.questionList.every((element) => element.phase == 3) ? () async {
                            bool isDuplicate = await questionListProvider.checkDuplicate(
                              gameCode: questionListProvider.questionList[0].gameCode,
                              gameProgress: userProvider.progressData!.gameProgress
                            );
                            if(isDuplicate){
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBarWidget.snackBarWidget(
                                  message: "Kamu sudah pernah menyelesaikan permainan ini",
                                  backgroundColor: ColorThemeStyle.red
                                )
                              );
                            } else {
                              await questionListProvider.submitProgress(
                                userId: userProvider.userData!.userId,
                                currentProgress: userProvider.progressData!,
                              );
                              await userProvider.getStudentData(userProvider.userData!);
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBarWidget.snackBarWidget(
                                  message: "Data permainanmu berhasil disubmit",
                                  backgroundColor: ColorThemeStyle.greenCarbon
                                )
                              );
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.siswaGameResultScreen
                              );
                            }
                          } : null
                        ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}