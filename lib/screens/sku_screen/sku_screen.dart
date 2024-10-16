import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/password_validator_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/user_provider.dart';
import 'package:scout_hunt/screens/auth_screen/auth_provider/username_validator_provider.dart';
import 'package:scout_hunt/screens/sku_screen/sku_provider.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';
import 'package:scout_hunt/widget/button_widget.dart';
import 'package:scout_hunt/widget/snack_bar_widget.dart';
import 'package:scout_hunt/widget/text_field_widget.dart';

class SkuScreen extends StatelessWidget {
  const SkuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Halaman SKU",
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
              "Pilih tingkatan SKU",
              style: TextStyleWidget.headlineH4(
                color: ColorThemeStyle.brown100,
                fontWeight: FontWeightStyle.bold
              ),
            ),
            Consumer<SkuProvider>(
              builder: (context, skuProvider, child) {
                return DropdownButtonFormField(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
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
                  value: skuProvider.selectedRank,
                  items: skuProvider.selectableRank,
                  onChanged: (val){
                    skuProvider.selectRank(selectedRank: val, agama: userProvider.userData!.agama!);
                  }
                );
              },
            ),
            Consumer<SkuProvider>(
              builder: (context, skuProvider, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                      skuProvider.selectedRank == "Penggalang Ramu" ? skuProvider.skuTaskListRamu.length
                      : skuProvider.selectedRank == "Penggalang Rakit" ? skuProvider.skuTaskListRakit.length
                      : skuProvider.skuTaskListTerap.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20
                    ),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 0,
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ExpansionTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(width: 3, color: ColorThemeStyle.brown100)
                          ),
                          collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(width: 3, color: ColorThemeStyle.brown100)
                          ),
                          collapsedBackgroundColor: ColorThemeStyle.orange,
                          childrenPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                          backgroundColor: Colors.orange[100],
                          title: Text(
                            "Butir ${index + 1}",
                            style: TextStyleWidget.headlineH4(
                              color: ColorThemeStyle.black100,
                              fontWeight: FontWeightStyle.bold
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: skuProvider.clearedSkuIndex.contains(index + skuProvider.indexBalancer) ? null
                            : () {
                                if(skuProvider.selectedSkuIndex.contains(index)){
                                  skuProvider.deselectSkuTask(index: index);
                                } else {
                                  skuProvider.selectSkuTask(index: index);
                                }
                              },
                            child:
                            skuProvider.clearedSkuIndex.contains(index + skuProvider.indexBalancer) ? const Icon(Icons.check, color: ColorThemeStyle.greenCarbon, size: 30,)
                            : skuProvider.selectedSkuIndex.contains(index) ? const Icon(Icons.check_box, color: ColorThemeStyle.brown100, size: 30)
                            : const Icon(Icons.check_box_outline_blank, color: ColorThemeStyle.brown100,size:30)
                          ),
                          children: [
                            Text(
                              skuProvider.selectedRank == "Penggalang Ramu" ? skuProvider.skuTaskListRamu[index]
                              : skuProvider.selectedRank == "Penggalang Rakit" ? skuProvider.skuTaskListRakit[index]
                              : skuProvider.skuTaskListTerap[index],
                              style: TextStyleWidget.bodyB2(
                                color: ColorThemeStyle.brown100,
                                fontWeight: FontWeightStyle.bold
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Consumer<SkuProvider>(
              builder: (context, skuProvider, child) {
                return Padding(
                  padding: const EdgeInsets.only(left: 70, right:70, bottom: 40),
                  child: ButtonWidget.defaultContainer(
                    onPressed: skuProvider.selectedSkuIndex.isEmpty ? null : (){
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Center(
                            child: Text(
                              "Validasi Pembina",
                              style: TextStyleWidget.headlineH4(
                                fontWeight: FontWeightStyle.bold,
                                color: ColorThemeStyle.brown100
                              ),
                            ),
                          ),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Username",
                                style: TextStyleWidget.bodyB1(
                                  fontWeight: FontWeightStyle.bold,
                                  color: ColorThemeStyle.brown100
                                ),
                              ),
                              Consumer<UsernameValidatorProvider>(
                                builder: (context, usernameValidatorProvider, child) {
                                  return  TextFieldWidget(
                                    controller: usernameValidatorProvider.usernameController,
                                    labelText: 'Username',
                                    hintText: 'Username',
                                    onChanged: (_) => usernameValidatorProvider.validateUsername(),
                                    errorText: usernameValidatorProvider.usernameError,
                                    textCapitalization: TextCapitalization.none,
                                    prefixIcon: const FractionallySizedBox(
                                      widthFactor: 0.06,
                                      child: Icon(Icons.person)
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Password",
                                style: TextStyleWidget.bodyB1(
                                  fontWeight: FontWeightStyle.bold,
                                  color: ColorThemeStyle.brown100
                                ),
                              ),
                              Consumer<PasswordValidatorProvider>(
                                builder: (context, passwordValidatorProvider, child) {
                                  return  TextFieldWidget(
                                    controller: passwordValidatorProvider.passwordController,
                                    labelText: 'Password',
                                    hintText: 'Password',
                                    onChanged: (_) => passwordValidatorProvider.validatePassword(),
                                    errorText: passwordValidatorProvider.passwordError,
                                    obscureText: !passwordValidatorProvider.isPasswordVisible,
                                    textCapitalization: TextCapitalization.none,
                                    suffixIcon: GestureDetector(
                                      child: Icon(
                                        passwordValidatorProvider.isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onTap: () {
                                        passwordValidatorProvider.togglePasswordVisibility();
                                      },
                                    ),
                                    prefixIcon: const FractionallySizedBox(
                                      widthFactor: 0.06,
                                      child: Icon(Icons.lock)
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          actions: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                              child: Consumer3<SkuProvider,UsernameValidatorProvider,PasswordValidatorProvider>(
                                builder: (context, skuProvider, usernameValidatorProvider, passwordValidatorProvider, child) {
                                  return skuProvider.isLoadingSubmit ? const Center(child: CircularProgressIndicator())
                                  : ButtonWidget.defaultContainer(
                                      onPressed: (usernameValidatorProvider.isUsernameValid && passwordValidatorProvider.isPasswordValid) ? () async {
                                          skuProvider.setLoading();
                                          bool isPembinaValid = await skuProvider.checkPembinaSku(
                                            username: usernameValidatorProvider.usernameController.text,
                                            password: passwordValidatorProvider.passwordController.text,
                                            classCode: userProvider.profileData!.classCode!
                                          );
                                          if(isPembinaValid){
                                            if (!context.mounted) return;
                                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                            bool isSuccess = await skuProvider.submitProgress(
                                              userId: userProvider.userData!.userId,
                                              currentProgress: userProvider.progressData!
                                            );
                                            if(isSuccess){
                                              await skuProvider.clearProvider();
                                              await userProvider.getStudentData(userProvider.userData!);
                                              await skuProvider.setInitialValue(
                                                skuProgress: userProvider.progressData!.skuProgress,
                                                agama: userProvider.userData!.agama!
                                              );
                                              if(!context.mounted) return;
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBarWidget.snackBarWidget(
                                                  message: "Update data SKU berhasil",
                                                  backgroundColor: ColorThemeStyle.greenCarbon
                                                ),
                                              );
                                              skuProvider.setLoading();
                                              usernameValidatorProvider.clearProvider();
                                              passwordValidatorProvider.clearProvider();
                                          } else {
                                            if(!context.mounted) return;
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBarWidget.snackBarWidget(
                                                  message: "Submit SKU Error!",
                                                  backgroundColor: ColorThemeStyle.red
                                                ),
                                              );
                                            skuProvider.setLoading();
                                            }
                                          } else {
                                            if(!context.mounted) return;
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBarWidget.snackBarWidget(
                                                  message: "Data Pembina salah atau tidak sesuai dengan pembina kelas! Coba lagi",
                                                  backgroundColor: ColorThemeStyle.red
                                                ),
                                              );
                                            skuProvider.setLoading();
                                            usernameValidatorProvider.clearProvider();
                                            passwordValidatorProvider.clearProvider();
                                          }
                                        } : null,
                                        text: "Validasi"
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        text: "Validasi"
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}