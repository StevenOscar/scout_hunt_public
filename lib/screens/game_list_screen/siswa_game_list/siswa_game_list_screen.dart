import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/routes.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/user_provider.dart';
import 'package:scout_hunt/screens/game_list_screen/siswa_game_list/siswa_game_list_provider.dart';
import 'package:scout_hunt/screens/play_screen/question_list/question_list_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/widget/button_widget.dart';
import 'package:scout_hunt/widget/list_tile_widget.dart';
import 'package:scout_hunt/widget/snack_bar_widget.dart';
import 'package:scout_hunt/widget/text_field_widget.dart';

class SiswaGameListScreen extends StatelessWidget {
  const SiswaGameListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SiswaGameListProvider siswaGameListProvider = context.watch<SiswaGameListProvider>();
    QuestionListProvider questionListProvider = context.watch<QuestionListProvider>();
    UserProvider userProvider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List Permainan",
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
            const SizedBox(height: 20),
            Text(
              "Input Kode Permainan",
              style: TextStyleWidget.bodyB1(
                color: ColorThemeStyle.brown100,
                fontWeight: FontWeightStyle.bold
              )
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:50),
              child: TextFieldWidget(
                controller: siswaGameListProvider.gameCodeController,
                labelText: 'Kode Permainan',
                hintText: 'Kode Permainan',
                keyboardType: TextInputType.text,
                errorText: siswaGameListProvider.gameCodeError,
                onChanged: (_) => siswaGameListProvider.validateGameCode(),
                inputFormatters: [UpperCaseTextFormatter()],
                textCapitalization: TextCapitalization.characters,
                prefixIcon: const FractionallySizedBox(
                  widthFactor: 0.06,
                  child: Icon(Icons.gamepad)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
              child: Consumer<SiswaGameListProvider>(
                builder: (context, siswaGameListProvider, child) {
                  return siswaGameListProvider.isDownoadingGameData ? const Center(child: CircularProgressIndicator())
                    : ButtonWidget.defaultContainer(
                        text: "Download Permainan",
                        onPressed: (siswaGameListProvider.isGameCodeValid) ?
                        () async {
                          FocusScope.of(context).unfocus();
                          bool isDuplicate = await siswaGameListProvider.checkDuplicate(
                            gameCode: siswaGameListProvider.gameCodeController.text,
                            username: userProvider.userData!.username
                          );
                          if(isDuplicate){
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBarWidget.snackBarWidget(
                                message: "Data permainan sudah ada",
                                backgroundColor: ColorThemeStyle.red
                              )
                            );
                          } else {
                            try {
                              await siswaGameListProvider.downloadGameData(
                                gameCode: siswaGameListProvider.gameCodeController.text,
                                username: userProvider.userData!.username
                              );
                              siswaGameListProvider.clearTextField();
                              await siswaGameListProvider.getGameList(username: userProvider.userData!.username);
                              if(!context.mounted) return;
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBarWidget.snackBarWidget(
                                  message: "Data Permainan berhasil didownload",
                                  backgroundColor: ColorThemeStyle.greenCarbon
                                )
                              );
                            } catch (e) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBarWidget.snackBarWidget(
                                  message: e.toString(),
                                  backgroundColor: ColorThemeStyle.red
                                )
                              );
                            }
                          }
                        } : null
                      );
                },
              ),
            ),
            const SizedBox(height: 40),
            Text(
              "Daftar Permainan",
              style: TextStyleWidget.displayD4(
                fontWeight: FontWeightStyle.bold,color: ColorThemeStyle.brown100
              ),
            ),
            const SizedBox(height: 20),
            Consumer<SiswaGameListProvider>(
              builder: (context, siswaGameListProvider, child) {
                return siswaGameListProvider.gameList.isEmpty ? const Center(child: Text("Anda belum mendonwload permainan"))
                : ListView.builder(
                    itemCount: siswaGameListProvider.gameList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: ColorThemeStyle.black100, width: 2),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: ListTileWidget.defaultContainer(
                          tileColor: userProvider.progressData!.gameProgress.contains(siswaGameListProvider.gameList[index].gameCode) ? ColorThemeStyle.greenCarbon : ColorThemeStyle.brown60,
                          onTap: userProvider.progressData!.gameProgress.contains(siswaGameListProvider.gameList[index].gameCode) ? (){
                            if(!context.mounted) return;
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBarWidget.snackBarWidget(
                                  message: "Anda sudah menyelesaikan permainan ini!\nSilahkan hapus data permainan",
                                  backgroundColor: ColorThemeStyle.greenCarbon
                                )
                              );
                          }
                              : () async {await questionListProvider.getGameData(
                                  username: userProvider.userData!.username,
                                  gameCode: siswaGameListProvider.gameList[index].gameCode
                                );
                                if(!context.mounted) return;
                                Navigator.pushNamed(
                                  context,
                                  Routes.siswaQuestionListScreen
                                );
                              },
                          title: Text(
                            siswaGameListProvider.gameList[index].title,
                            style: TextStyleWidget.headlineH3(
                              color: ColorThemeStyle.white100,
                              fontWeight: FontWeightStyle.bold
                            ),
                          ),
                          subtitle: Text(
                            "Kode Permainan : ${siswaGameListProvider.gameList[index].gameCode}",
                            style: TextStyleWidget.bodyB3(
                              color: ColorThemeStyle.white100
                            ),
                          ),
                          trailing: userProvider.progressData!.gameProgress.contains(siswaGameListProvider.gameList[index].gameCode) ? IconButton(
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  actionsAlignment: MainAxisAlignment.center,
                                  title: Center(
                                    child: Text(
                                      "Hapus Permainan?",
                                      style: TextStyleWidget.headlineH4(
                                        fontWeight: FontWeightStyle.bold,
                                        color: ColorThemeStyle.brown100
                                      ),
                                    )
                                  ),
                                  content: Text("Apakah anda yakin ingin menghapus '${siswaGameListProvider.gameList[index].title}'?"),
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
                                          onPressed: () async {
                                            await siswaGameListProvider.deleteGame(
                                              gameCode: siswaGameListProvider.gameList[index].gameCode,
                                              username: userProvider.userData!.username
                                            );
                                            await siswaGameListProvider.getGameList(
                                              username: userProvider.userData!.username
                                            );
                                            if (!context.mounted) return;
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
                            icon: const Icon(
                              Icons.delete,
                              color: ColorThemeStyle.white100,
                              size: 27,
                            )
                          ) : null
                        ),
                      );
                    }
                  );
              },
            ),
            const SizedBox(height: 50)
          ],
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
