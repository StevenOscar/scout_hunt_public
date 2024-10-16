import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/assets_fonts.dart';
import 'package:scout_hunt/constants/badge_list.dart';
import 'package:scout_hunt/constants/routes.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/user_provider.dart';
import 'package:scout_hunt/screens/profile_screen/profile_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/widget/button_widget.dart';

class SiswaMainHeader extends StatelessWidget {
  const SiswaMainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    ProfileProvider profileProvider = context.watch<ProfileProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async{
            await profileProvider.clearProvider();
            await profileProvider.setInitialValue(
              achievement: userProvider.profileData!.achievement,
              badge: userProvider.profileData!.badge,
              userProgress: userProvider.progressData!,
              userData: userProvider.userData!
            );
            if(!context.mounted) return;
            Navigator.pushNamed(
              context,
              Routes.siswaProfileScreen
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:ColorThemeStyle.brown60,
              border: Border.all(color: ColorThemeStyle.black100, width: 2)
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 110,
                      child: Text(
                        userProvider.userData!.username,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleWidget.titleT1(
                          fontFamily: AssetsFonts.theSunday,
                          fontWeight: FontWeightStyle.extraBold,
                          color: ColorThemeStyle.white100
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      userProvider.profileData!.achievement,
                      style: TextStyleWidget.titleT3(
                        fontWeight: FontWeightStyle.bold,
                        color: ColorThemeStyle.white100
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Image.asset(
                height: 55,
                  BadgeList.badgeImage[BadgeList.badgeName.indexWhere((element) => element.contains(userProvider.profileData!.badge))])
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: (){
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                title: Center(
                  child: Text(
                    "Log Out?",
                    style: TextStyleWidget.headlineH4(
                      fontWeight: FontWeightStyle.bold,
                      color: ColorThemeStyle.brown100
                    ),
                  ),
                ),
                content: const Text("Apakah anda yakin ingin keluar?"),
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
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.loginScreen,
                            (_) => false
                          );
                        },
                        text: "Ya"
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: ColorThemeStyle.errorBar,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorThemeStyle.black100, width: 1)
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Text(
                  "Log Out",
                  style: TextStyleWidget.labelL1(
                    fontWeight: FontWeight.w600,
                    color: ColorThemeStyle.white100
                  ),
                ),
                const SizedBox(width: 3),
                const Icon(
                  Icons.logout,
                  size: 20,
                  color: ColorThemeStyle.white100,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}