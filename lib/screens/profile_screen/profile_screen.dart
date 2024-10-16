import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/badge_list.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/user_provider.dart';
import 'package:scout_hunt/screens/profile_screen/profile_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/widget/button_widget.dart';
import 'package:scout_hunt/widget/snack_bar_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    ProfileProvider profileProvider = context.watch<ProfileProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profil",
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
          children: [
            const SizedBox(height: 30),
            Text(
              userProvider.userData!.username,
              style: TextStyleWidget.displayD4(
                fontWeight: FontWeightStyle.bold,color: ColorThemeStyle.brown100
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Nama: ${userProvider.userData!.nama}",
              style: TextStyleWidget.bodyB1(
                fontWeight: FontWeightStyle.bold,color: ColorThemeStyle.brown60
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Points \nterkumpul",
                      textAlign: TextAlign.center,
                      style: TextStyleWidget.headlineH5(
                        fontWeight: FontWeightStyle.bold,color: ColorThemeStyle.brown100
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      userProvider.progressData!.points.toString(),
                      style: TextStyleWidget.bodyB1(
                        fontWeight: FontWeightStyle.bold,
                        color: ColorThemeStyle.brown60
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Soal \nTerjawab",
                      textAlign: TextAlign.center,
                      style: TextStyleWidget.headlineH5(
                        fontWeight: FontWeightStyle.bold,color: ColorThemeStyle.brown100
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      userProvider.progressData!.questionAnswered.toString(),
                      style: TextStyleWidget.bodyB1(
                        fontWeight: FontWeightStyle.bold,
                        color: ColorThemeStyle.brown60
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (context) {
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
                          content: userProvider.progressData!.gameProgress.isEmpty
                          ? const Text(
                              "Belum menyelesaikan permainan",
                              textAlign: TextAlign.center,
                            )
                          : SizedBox(
                              width: double.maxFinite,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: userProvider.progressData!.gameProgress.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Center(child: Text(userProvider.progressData!.gameProgress[index]));
                                },
                              ),
                            ),
                        );
                      },
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        "Permainan \n selesai",
                        textAlign: TextAlign.center,
                        style: TextStyleWidget.headlineH5(
                          fontWeight: FontWeightStyle.bold,color: ColorThemeStyle.brown100
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        userProvider.progressData!.gameProgress.length.toString(),
                        style: TextStyleWidget.bodyB1(
                          fontWeight: FontWeightStyle.bold,
                          color: ColorThemeStyle.brown60
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              "Badge",
              style: TextStyleWidget.headlineH4(
                fontWeight: FontWeightStyle.bold,color: ColorThemeStyle.brown100
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorThemeStyle.brown60,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 10,
                bottom: 40,
              ),
              child: Consumer<ProfileProvider>(
                builder: (context, profileProvider, child) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                    itemCount: BadgeList.badgeImage.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          if (profileProvider.selectableBadgeIndex.contains(index)) {
                            profileProvider.selectBadge(index);
                          } else {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBarWidget.snackBarWidget(
                                message: "Anda belum membuka Badge ini! \n\n ${profileProvider.badgeMessageList[index]}",
                                backgroundColor: ColorThemeStyle.red
                              )
                            );
                          }
                        },
                        child: profileProvider.selectableBadgeIndex.contains(index)
                        ? Container(
                            decoration: BoxDecoration(
                              border: index == profileProvider.selectedBadgeIndex ? Border.all(
                                width: 4,
                                color: ColorThemeStyle.blue60
                              ) : null,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ClipRect(
                              child: Image.asset(BadgeList.badgeImage[index]),
                            ),
                        )
                        : ColorFiltered(
                            colorFilter: const ColorFilter.matrix(<double>[
                              0.2126,0.7152,0.0722,0,0,
                              0.2126,0.7152,0.0722,0,0,
                              0.2126,0.7152,0.0722,0,0,
                              0,0,0,1,0,
                              ]
                            ),
                            child: Image.asset(BadgeList.badgeImage[index])
                          )
                      );
                    },
                  );
                },
              )
            ),
            Text(
              "Achievement",
              style: TextStyleWidget.headlineH4(
                fontWeight: FontWeightStyle.bold,color: ColorThemeStyle.brown100
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // Garis border biasa
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.grey, // Warna garis
                        width: 2.0, // Ketebalan garis
                      ),
                    ),
                    alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                      // Garis border saat difokuskan
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: ColorThemeStyle.brown100, // Warna garis
                        width: 2.0, // Ketebalan garis
                      ),
                    ),
                  ),
                  value: profileProvider.achievementValue,
                  items: profileProvider.selectableAchievement,
                  onChanged: (selectedAchievement){
                    profileProvider.selectAchievement(selectedAchievement);
                  }
                ),
              ),
            ),
            Consumer<ProfileProvider>(
              builder: (context, profileProvider, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                  child: profileProvider.loadingProfile ? const CircularProgressIndicator()
                    : ButtonWidget.defaultContainer(
                        text: "Simpan Profil",
                        onPressed: () async {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          await profileProvider.updateProfile(userId: userProvider.userData!.userId);
                          await userProvider.getStudentData(userProvider.userData!);
                          if(!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarWidget.snackBarWidget(
                              message: "Profile Berhasil di update!",
                              backgroundColor: ColorThemeStyle.greenCarbon
                            )
                          );
                        }
                      ),
                );
              },
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}