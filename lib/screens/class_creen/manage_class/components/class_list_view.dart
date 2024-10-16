import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/constants/routes.dart';
import 'package:scout_hunt/screens/class_creen/class_detail/class_detail_provider.dart';
import 'package:scout_hunt/screens/class_creen/manage_class/manage_class_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/widget/list_tile_widget.dart';

class ClassListView extends StatelessWidget {
  const ClassListView({super.key});

  @override
  Widget build(BuildContext context) {
    ClassDetailProvider classDetailProvider = context.watch<ClassDetailProvider>();
    return Consumer<ManageClassProvider>(
      builder: (context, manageClassProvider, child) {
        return manageClassProvider.classList.isNotEmpty ?
          classDetailProvider.isLoadingClass ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 15),
              Text(
                "Mendownload data kelas\nMohon tunggu sejenak",
                style: TextStyleWidget.bodyB1(),
                textAlign: TextAlign.center,
              )
            ],
          ) :
          ListView.builder(
            itemCount: manageClassProvider.classList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: ColorThemeStyle.black100, width: 2),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ListTileWidget.defaultContainer(
                  tileColor: ColorThemeStyle.brown60,
                  onTap: () async{
                    await classDetailProvider.getClassDetail(manageClassProvider.classList[index].classCode);
                    if(!context.mounted) return;
                    Navigator.pushNamed(
                      context,
                      Routes.classDetailScreen
                    );
                  },
                  title: Text(
                    manageClassProvider.classList[index].title,
                    style: TextStyleWidget.headlineH3(
                      color: ColorThemeStyle.white100,
                      fontWeight: FontWeightStyle.bold
                    ),
                  ),
                  subtitle: Text(
                    "Kode Kelas : ${manageClassProvider.classList[index].classCode}",
                    style: TextStyleWidget.bodyB3(
                      color: ColorThemeStyle.white100
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_right_alt,
                    color: ColorThemeStyle.white100,
                    size: 35,
                  ),
                ),
              );
            }
          )
        : const Center(child: Text("Anda belum membuat kelas"));
      },
    );
  }
}