import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/assets_images.dart';
import 'package:scout_hunt/constants/routes.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/user_provider.dart';
import 'package:scout_hunt/screens/class_creen/manage_class/manage_class_provider.dart';
import 'package:scout_hunt/screens/game_list_screen/pembina_game_list/pembina_game_list_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/widget/button_widget.dart';

class PembinaMainScreen extends StatelessWidget {
  const PembinaMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    PembinaGameListProvider pembinaGameListProvider = context.watch<PembinaGameListProvider>();
    ManageClassProvider manageClassProvider = context.watch<ManageClassProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        child: PopScope(
          canPop: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(AssetsImages.assetsImagesPembinaMainBackground),fit: BoxFit.fitHeight),
            ),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 75),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:ColorThemeStyle.brown60,
                        border: Border.all(color: ColorThemeStyle.black100, width: 2)
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        userProvider.userData!.username,
                        style: TextStyleWidget.titleT1(
                          fontWeight: FontWeightStyle.bold,
                          color: ColorThemeStyle.white100
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
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
                ),
                const SizedBox(height: 20),
                Image.asset(
                  AssetsImages.assetsImagesScoutHuntLogo,
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    await pembinaGameListProvider.getGameList(userProvider.userData!.username);
                    if(!context.mounted) return;
                    Navigator.pushNamed(
                      context,
                      Routes.pembinaGameListScreen
                    );
                  },
                  child: Stack(
                    children: [
                      Center(child: Image.asset(AssetsImages.assetsImagesMainButton)),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Text(
                            "List Permainan",
                            style: TextStyleWidget.bodyB1(
                              fontWeight: FontWeightStyle.bold,
                              color: ColorThemeStyle.white100
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    await manageClassProvider.getClassList(userProvider.userData!.username);
                    if(!context.mounted) return;
                    Navigator.pushNamed(
                      context,
                      Routes.pembinaManageClassScreen
                    );
                  },
                  child: Stack(
                    children: [
                      Center(child: Image.asset(AssetsImages.assetsImagesMainButton)),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Text(
                            "Kelas",
                            style: TextStyleWidget.bodyB1(
                              fontWeight: FontWeightStyle.bold,
                              color: ColorThemeStyle.white100
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    Navigator.pushNamed(
                      context,
                      Routes.materiCategoryScreen
                    );
                  },
                  child: Stack(
                    children: [
                      Center(child: Image.asset(AssetsImages.assetsImagesMainButton)),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Text(
                            "Materi",
                            style: TextStyleWidget.bodyB1(
                              fontWeight: FontWeightStyle.bold,
                              color: ColorThemeStyle.white100
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}