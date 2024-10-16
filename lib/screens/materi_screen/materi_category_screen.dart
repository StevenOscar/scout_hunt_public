import 'package:flutter/material.dart';
import 'package:scout_hunt/screens/materi_screen/keterampilan_tongkat.dart';
import 'package:scout_hunt/screens/materi_screen/kode_kehormatan_pramuka.dart';
import 'package:scout_hunt/screens/materi_screen/kompas.dart';
import 'package:scout_hunt/screens/materi_screen/salam_pramuka.dart';
import 'package:scout_hunt/screens/materi_screen/peraturan_baris.dart';
import 'package:scout_hunt/screens/materi_screen/sandi_kotak.dart';
import 'package:scout_hunt/screens/materi_screen/sandi_morse.dart';
import 'package:scout_hunt/screens/materi_screen/sandi_rumput.dart';
import 'package:scout_hunt/screens/materi_screen/sejarah_pramuka.dart';
import 'package:scout_hunt/screens/materi_screen/semaphore.dart';
import 'package:scout_hunt/screens/materi_screen/tali_temali.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/font_weight_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class MateriCategoryScreen extends StatelessWidget {
  const MateriCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> listRouting = [
      const SejarahPramukaScreen(),
      const SalamPramukaScreen(),
      const KodeKehormatanPramukaScreen(),
      const TaliTemaliScreen(),
      const SemaphoreScreen(),
      const SandiRumputScreen(),
      const SandiMorseScreen(),
      const SandiKotakScreen(),
      const KeterampilanTongkatScreen(),
      const KompasScreen(),
      const PeraturanBarisScreen(),
    ];

    final List<String> listMateri = [
      "Sejarah Gerakan Pramuka",
      "Salam Pramuka",
      "Kode Kehormatan Pramuka",
      "Tali Temali",
      "Semaphore",
      "Sandi Rumput",
      "Sandi Morse",
      "Sandi Kotak",
      "Keterampilan Tongkat",
      "Kompas",
      "Peraturan Baris berbaris"
    ];

    final List<String> imagePaths = [
      "assets/images/sejarah_pramuka.png",
      "assets/images/salam_pramuka.png",
      "assets/images/kode_kehormatan_pramuka.png",
      "assets/images/tali_temali.png",
      "assets/images/semaphore.png",
      "assets/images/sandi_rumput.png",
      "assets/images/sandi_morse.png",
      "assets/images/sandi_kotak.png",
      "assets/images/keterampilan_tongkat.png",
      "assets/images/kompas.png",
      "assets/images/peraturan_baris_berbaris.png",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kategori Materi",
          style: TextStyleWidget.titleT1(
            color: ColorThemeStyle.white100,
            fontWeight: FontWeightStyle.medium
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorThemeStyle.brown100,
        iconTheme: const IconThemeData(color: ColorThemeStyle.white100),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: ColorThemeStyle.brown60,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: Colors.black),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: listMateri
                .length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => listRouting[index]));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: ColorThemeStyle.blue100),
                        color: const Color.fromARGB(255, 206, 110,
                            0),
                        image: DecorationImage(
                          image: AssetImage(imagePaths[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        listMateri[index],
                        textAlign: TextAlign.center,
                        style: TextStyleWidget.bodyB2(
                          color: ColorThemeStyle.white100,
                          fontWeight: FontWeightStyle.semiBold
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
