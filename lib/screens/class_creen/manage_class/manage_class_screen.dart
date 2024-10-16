import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/user_provider.dart';
import 'package:scout_hunt/screens/class_creen/manage_class/components/class_list_view.dart';
import 'package:scout_hunt/screens/class_creen/manage_class/manage_class_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/widget/button_widget.dart';
import 'package:scout_hunt/widget/text_field_widget.dart';

class ManageClassScreen extends StatelessWidget {
  const ManageClassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ManageClassProvider manageClassProvider = context.watch<ManageClassProvider>();
    UserProvider userProvider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kelola Kelas",
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
              child: ButtonWidget.defaultContainer(
                onPressed: (){
                  manageClassProvider.generateClassCode();
                  showDialog(
                    context: context,
                    builder: (_) {
                      return Consumer<ManageClassProvider>(
                        builder: (context, manageClassProvider, child) {
                          return AlertDialog(
                            title: Center(
                              child: Text(
                                "Tambah Kelas",
                                style: TextStyleWidget.headlineH4(
                                  fontWeight: FontWeightStyle.bold,
                                  color: ColorThemeStyle.brown100
                                ),
                              )
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 20),
                                TextFieldWidget(
                                  controller: manageClassProvider.titleController,
                                  hintText: "Nama Kelas",
                                  textAlign: TextAlign.center,
                                  errorText: manageClassProvider.isTitleValid ? null : manageClassProvider.titleError,
                                  onChanged: (_) {manageClassProvider.validateTitle();},
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  "Kode Kelas",
                                  style: TextStyleWidget.bodyB1(),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  manageClassProvider.newClassCode,
                                  style: TextStyleWidget.headlineH1(
                                    fontWeight: FontWeightStyle.bold,
                                    color: ColorThemeStyle.brown60
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              Consumer<ManageClassProvider>(
                                builder: (context, manageClassProvider, child) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                                    child: ButtonWidget.defaultContainer(
                                      onPressed: manageClassProvider.isTitleValid ? () async {
                                        await manageClassProvider.saveClass(
                                          username: userProvider.userData!.username,
                                          userId: userProvider.userData!.userId,
                                        );
                                        await manageClassProvider.getClassList(userProvider.userData!.username);
                                        if(!context.mounted) return;
                                        manageClassProvider.clearCreateClassButton();
                                        Navigator.pop(context);
                                      } : null,
                                      text: "Buat"
                                    ),
                                  );
                                },
                              )
                            ],
                          );
                        },
                      );
                    },
                  );
                },
                text: "Tambah Kelas"
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Daftar Kelas",
              style: TextStyleWidget.displayD4(
                fontWeight: FontWeightStyle.bold,color: ColorThemeStyle.brown100
              ),
            ),
            const SizedBox(height: 20),
            const ClassListView()
          ],
        ),
      ),
    );
  }
}