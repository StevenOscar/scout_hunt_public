import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/assets_images.dart';
import 'package:scout_hunt/constants/badge_list.dart';
import 'package:scout_hunt/screens/class_creen/class_detail/class_detail_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/widget/button_widget.dart';
import 'package:scout_hunt/widget/list_tile_widget.dart';

class ClassDetailScreen extends StatelessWidget {
  const ClassDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ClassDetailProvider classDetailProvider = context.watch<ClassDetailProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Kelas",
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text(
              classDetailProvider.classDetail.title,
              style: TextStyleWidget.headlineH1(
                fontWeight: FontWeightStyle.bold,color: ColorThemeStyle.brown100
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Kode",
                      style: TextStyleWidget.headlineH4(
                        fontWeight: FontWeightStyle.bold,color: ColorThemeStyle.brown100
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      classDetailProvider.classDetail.classCode,
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
                      "Pembina",
                      style: TextStyleWidget.headlineH4(
                        fontWeight: FontWeightStyle.bold,color: ColorThemeStyle.brown100
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      classDetailProvider.classDetail.createdBy,
                      style: TextStyleWidget.headlineH5(
                        fontWeight: FontWeightStyle.bold,
                        color: ColorThemeStyle.brown60
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 40),
            Text(
              "Leaderboard",
              style: TextStyleWidget.headlineH2(
                fontWeight: FontWeightStyle.bold,color: ColorThemeStyle.brown100
              ),
            ),
            const SizedBox(height: 15),
            classDetailProvider.classDetail.profileList.isNotEmpty ?
            ListView.builder(
              itemCount: classDetailProvider.classDetail.profileList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                  index == 0 ? SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset(AssetsImages.assetsImagesGold)
                  )
                  : index == 1 ? SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset(AssetsImages.assetsImagesSilver)
                  )
                  : index == 2 ? SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset(AssetsImages.assetsImagesBronze)
                  )
                  : CircleAvatar(
                      radius: 15,
                      backgroundColor: ColorThemeStyle.brown60,
                      child: Text(
                        (index+1).toString(),
                        style: TextStyleWidget.headlineH4(
                          fontWeight: FontWeightStyle.bold,
                          color: ColorThemeStyle.white100
                        ),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.only(left: 26, right:26, bottom: 15,top:4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: ColorThemeStyle.black100, width: 2),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: ListTileWidget.defaultContainer(
                        tileColor: ColorThemeStyle.brown60,
                        leading: Image.asset(
                          height: 70,
                          BadgeList.badgeImage[BadgeList.badgeName.indexWhere((element) =>
                          element.contains(classDetailProvider.classDetail.profileList[index].badge))]
                        ),
                        title: Text(
                          classDetailProvider.classDetail.userList[index].nama,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleWidget.headlineH3(
                            color: ColorThemeStyle.white100,
                            fontWeight: FontWeightStyle.bold
                          ),
                        ),
                        subtitle: Text(
                          classDetailProvider.classDetail.profileList[index].achievement,
                          style: TextStyleWidget.bodyB3(
                            color: ColorThemeStyle.white100
                          ),
                        ),
                        trailing: Text(
                          "Points : ${classDetailProvider.classDetail.progressList[index].points.toString()}",
                          style: TextStyleWidget.bodyB2(
                            color: ColorThemeStyle.white100
                          ),
                        ),
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Center(
                                child: Text(
                                  classDetailProvider.classDetail.userList[index].nama,
                                  style: TextStyleWidget.headlineH2(
                                    fontWeight: FontWeightStyle.extraBold,
                                    color: ColorThemeStyle.brown100
                                  ),
                                ),
                              ),
                              content: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    height: 200,
                                    BadgeList.badgeImage[BadgeList.badgeName.indexWhere((element) =>
                                    element.contains(classDetailProvider.classDetail.profileList[index].badge))]
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Username : ${classDetailProvider.classDetail.userList[index].username}",
                                    style: TextStyleWidget.headlineH5(
                                      fontWeight: FontWeightStyle.bold,
                                      color: ColorThemeStyle.brown60
                                    ),
                                  ),
                                  Text(
                                    "Agama : ${classDetailProvider.classDetail.userList[index].agama!}",
                                    style: TextStyleWidget.headlineH5(
                                      fontWeight: FontWeightStyle.bold,
                                      color: ColorThemeStyle.brown60
                                    ),
                                  ),
                                  Text(
                                    "Cleared SKU : ${classDetailProvider.classDetail.progressList[index].skuProgress.values.where((value) => value == true).length} / ${classDetailProvider.classDetail.progressList[index].skuProgress.length.toString()}",
                                    style: TextStyleWidget.headlineH5(
                                      fontWeight: FontWeightStyle.bold,
                                      color: ColorThemeStyle.brown60
                                    ),
                                  ),
                                  Text(
                                    "Answered Question : ${classDetailProvider.classDetail.progressList[index].questionAnswered}",
                                    style: TextStyleWidget.headlineH5(
                                      fontWeight: FontWeightStyle.bold,
                                      color: ColorThemeStyle.brown60
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 50, right:50, bottom: 40, top: 10),
                                    child: ButtonWidget.defaultContainer(
                                      text: "Finished Game",
                                      height: 40,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            int userIndex = index;
                                            return AlertDialog(
                                              title: Center(
                                                child: Text(
                                                  "Finished Game",
                                                  style: TextStyleWidget.headlineH2(
                                                    fontWeight: FontWeightStyle.extraBold,
                                                    color: ColorThemeStyle.brown100
                                                  ),
                                                ),
                                              ),
                                              content: classDetailProvider.classDetail.progressList[index].gameProgress.isEmpty
                                              ? const Text(
                                                  "Belum menyelesaikan permainan",
                                                  textAlign: TextAlign.center,
                                                )
                                              : SizedBox(
                                                  width: double.maxFinite,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: classDetailProvider.classDetail.progressList[index].gameProgress.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return Center(child: Text(classDetailProvider.classDetail.progressList[userIndex].gameProgress[index]));
                                                    },
                                                  ),
                                                ),
                                            );
                                          },
                                        );
                                      }
                                    ),
                                  ),
                                  Text(
                                    "Points : ${classDetailProvider.classDetail.progressList[index].points.toString()}",
                                    style: TextStyleWidget.headlineH5(
                                      fontWeight: FontWeightStyle.bold,
                                      color: ColorThemeStyle.brown60
                                    ),
                                  ),
                                  SizedBox(height: 15)
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            ) : Center(
                  child: Text(
                    "Kelas ini masih kosong",
                    style: TextStyleWidget.headlineH4(
                      fontWeight: FontWeightStyle.bold,
                      color: ColorThemeStyle.black100
                    ),
                  )
                ),
            SizedBox(height : 20),
          ],
        ),
      ),
    );
  }
}