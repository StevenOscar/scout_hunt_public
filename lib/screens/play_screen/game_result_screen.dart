import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/assets_images.dart';
import 'package:scout_hunt/screens/play_screen/question_list/question_list_provider.dart';
import 'package:scout_hunt/style/font_weight_style.dart';

import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class GameResultScreen extends StatelessWidget {
  const GameResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionListProvider questionListProvider = context.watch<QuestionListProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Game Result",
          style: TextStyleWidget.titleT1(color: ColorThemeStyle.white100),
        ),
        centerTitle: true,
        backgroundColor: ColorThemeStyle.brown100,
        iconTheme: const IconThemeData(color: ColorThemeStyle.white100),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Permainan Selesai!",
                style: TextStyleWidget.displayD4(
                  fontWeight: FontWeightStyle.bold,color: ColorThemeStyle.brown100
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 175,
                height: 175,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorThemeStyle.black100,
                    width: 2
                  ),
                  image: const DecorationImage(
                    image: AssetImage(AssetsImages.assetsImagesThumbsUp)
                  )
                ),
              ),
              const SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorThemeStyle.lightOrange,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorThemeStyle.black100,
                    width: 2
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Judul Permainan",
                      style: TextStyleWidget.bodyB1(
                        fontWeight: FontWeightStyle.bold,
                      ),
                    ),
                    Text(
                      questionListProvider.questionList[0].title,
                      style: TextStyleWidget.headlineH4(
                        fontWeight: FontWeightStyle.bold,
                        color: ColorThemeStyle.brown60
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Kode Permainan",
                      style: TextStyleWidget.bodyB1(
                        fontWeight: FontWeightStyle.bold,
                      ),
                    ),
                    Text(
                      questionListProvider.questionList[0].gameCode,
                      style: TextStyleWidget.headlineH4(
                        fontWeight: FontWeightStyle.bold,
                        color: ColorThemeStyle.brown60
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Correct\nAnswers",
                              style: TextStyleWidget.bodyB1(
                                fontWeight: FontWeightStyle.bold,
                              ),
                              textAlign: TextAlign.center,
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
                        ),
                        const SizedBox(width: 3),
                        Column(
                          children: [
                            Text(
                              "Wrong\nAnswers",
                              style: TextStyleWidget.bodyB1(
                                fontWeight: FontWeightStyle.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              (questionListProvider.questionList.length - questionListProvider.correctAnswers).toString(),
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
                    Text(
                      "Points Earned",
                      style: TextStyleWidget.bodyB1(
                        fontWeight: FontWeightStyle.bold,
                      ),
                    ),
                    Text(
                      questionListProvider.currentPoints.toString(),
                      style: TextStyleWidget.headlineH1(
                        fontWeight: FontWeightStyle.bold,
                        color: ColorThemeStyle.brown60
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        )
      ),
    );
  }
}