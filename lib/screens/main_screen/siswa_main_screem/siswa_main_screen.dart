import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/assets_fonts.dart';
import 'package:scout_hunt/constants/assets_images.dart';
import 'package:scout_hunt/constants/routes.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/password_validator_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/user_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/username_validator_provider.dart';
import 'package:scout_hunt/screens/class_creen/class_detail/class_detail_provider.dart';
import 'package:scout_hunt/screens/game_list_screen/siswa_game_list/siswa_game_list_provider.dart';
import 'package:scout_hunt/screens/main_screen/siswa_main_screem/components/siswa_main_header.dart';
import 'package:scout_hunt/screens/sku_screen/sku_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/utils/class_db_helper.dart';
import 'package:scout_hunt/utils/profile_db_helper.dart';
import 'package:scout_hunt/widget/button_widget.dart';
import 'package:scout_hunt/widget/snack_bar_widget.dart';
import 'package:scout_hunt/widget/text_field_widget.dart';

class SiswaMainScreen extends StatefulWidget {
  const SiswaMainScreen({super.key});

  @override
  State<SiswaMainScreen> createState() => _SiswaMainScreenState();
}

class _SiswaMainScreenState extends State<SiswaMainScreen> {
  late AssetImage backgroundImage;
  @override
  void initState() {
    super.initState();
    backgroundImage= const AssetImage(AssetsImages.assetsImagesSiswaMainBackground);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(backgroundImage, context);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    SiswaGameListProvider siswaGameListProvider = context.watch<SiswaGameListProvider>();
    ClassDetailProvider classDetailProvider = context.watch<ClassDetailProvider>();
    SkuProvider skuProvider = context.watch<SkuProvider>();
    TextEditingController classCodeController = TextEditingController();
    UsernameValidatorProvider usernameValidatorProvider = context.watch<UsernameValidatorProvider>();
    PasswordValidatorProvider passwordValidatorProvider = context.watch<PasswordValidatorProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        child: PopScope(
          canPop: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetsImages.assetsImagesSiswaMainBackground),
                fit: BoxFit.fitHeight
              ),
            ),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 75),
                const SiswaMainHeader(),
                const SizedBox(height: 20),
                Image.asset(
                  AssetsImages.assetsImagesScoutHuntLogo,
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    if(!context.mounted) return;
                    Navigator.pushNamed(
                      context,
                      Routes.siswaGameListScreen
                    );
                    await siswaGameListProvider.getGameList(username : userProvider.userData!.username);
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
                              fontFamily: AssetsFonts.theSunday,
                              fontWeight: FontWeightStyle.bold,
                              color: ColorThemeStyle.white100
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    if(userProvider.profileData!.classCode == null){
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Center(
                            child: Text(
                              "Anda belum masuk kelas",
                              style: TextStyleWidget.headlineH4(
                                fontWeight: FontWeightStyle.bold,
                                color: ColorThemeStyle.brown100
                              ),
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Silahkan masukkan kode kelas",
                                style: TextStyleWidget.bodyB2(),
                              ),
                              TextFieldWidget(
                                inputFormatters: [UpperCaseTextFormatter()],
                                textCapitalization: TextCapitalization.characters,
                                controller: classCodeController,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          actions: [
                            ButtonWidget.defaultContainer(
                              text: "Masuk kelas",
                              onPressed: () async {
                                bool isExist = await ClassDbHelper().checkClassExistence(classCode: classCodeController.text.toUpperCase());
                                if (isExist) {
                                  await ProfileDbHelper().insertClassCode(
                                    classCode: classCodeController.text.toUpperCase(),
                                    userId: userProvider.userData!.userId
                                  );
                                  await userProvider.getStudentData(userProvider.userData!);
                                  await classDetailProvider.getClassDetail(userProvider.profileData!.classCode!);

                                  if (!context.mounted) return;
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBarWidget.snackBarWidget(
                                      message: "Berhasil bergabung ke dalam kelas",
                                      backgroundColor: ColorThemeStyle.greenCarbon
                                    ),
                                  );
                                  Navigator.pushNamed(
                                    context,
                                    Routes.classDetailScreen
                                  );
                                } else {
                                  if (!context.mounted) return;
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBarWidget.snackBarWidget(
                                      message: "Kelas tidak ditemukan",
                                      backgroundColor: ColorThemeStyle.red
                                    ),
                                  );
                                }
                              }
                            )
                          ],
                        ),
                      );
                    } else {
                      await classDetailProvider.getClassDetail(userProvider.profileData!.classCode!);
                      if(!context.mounted) return;
                      Navigator.pushNamed(
                        context,
                        Routes.classDetailScreen
                      );
                    }
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
                              fontFamily: AssetsFonts.theSunday,
                              fontWeight: FontWeightStyle.bold,
                              color: ColorThemeStyle.white100
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
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
                              fontFamily: AssetsFonts.theSunday,
                              fontWeight: FontWeightStyle.bold,
                              color: ColorThemeStyle.white100
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    if(userProvider.profileData!.classCode == null){
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Center(
                            child: Text(
                              "Anda belum masuk kelas",
                              style: TextStyleWidget.headlineH4(
                                fontWeight: FontWeightStyle.bold,
                                color: ColorThemeStyle.brown100
                              ),
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Anda perlu masuk kelas dahulu untuk mengakses fitur ini!",
                                style: TextStyleWidget.bodyB2(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          actions: [
                            ButtonWidget.defaultContainer(
                              text: "Kembali",
                              onPressed: () async {
                                Navigator.pop(context);
                              }
                            )
                          ],
                        ),
                      );
                    } else {
                      usernameValidatorProvider.clearProvider();
                      passwordValidatorProvider.clearProvider();
                      skuProvider.clearProvider();
                      await skuProvider.setInitialValue(
                        skuProgress: userProvider.progressData!.skuProgress,
                        agama: userProvider.userData!.agama!
                      );
                      if(!context.mounted) return;
                      Navigator.pushNamed(
                        context,
                        Routes.siswaSkuScreen
                      );
                    }
                  },
                  child: Stack(
                    children: [
                      Center(child: Image.asset(AssetsImages.assetsImagesMainButton)),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Text(
                            "SKU",
                            style: TextStyleWidget.bodyB1(
                              fontFamily: AssetsFonts.theSunday,
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

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
    );
  }
}