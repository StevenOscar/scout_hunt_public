import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class SandiRumputScreen extends StatelessWidget {
  const SandiRumputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Baca Materi",
          style: TextStyleWidget.titleT1(color: ColorThemeStyle.white100),
        ),
        centerTitle: true,
        backgroundColor: ColorThemeStyle.brown100,
        iconTheme: const IconThemeData(color: ColorThemeStyle.white100),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                "Sandi Rumput",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 2, color: Colors.black),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(2),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/sandi_rumput_value.png",
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(height: 10),
                    Html(
                      data: """
<h2><b>Pengertian Sandi Rumput</b></h2>
<p>Sandi Rumput adalah sistem representasi huruf, angka, dan tanda baca yang dibuat berdasarkan prinsip kode morse. Berarti kunci utamanya terletak pada sandi morse. Perbedaan antara keduanya hanya terletak pada cara penulisan, dimana titik dan garis pada kode morse diganti dengan rumput kecil dan rumput besar. Sandi rumput memiliki keistimewaan daripada sandi yang lain karena susah dicari dan ditemukan dan sedikit orang yang memahami sandi rumput.</p>
                      """,
                      style: {
                        "p": Style(
                          textAlign: TextAlign.justify,
                          fontSize: FontSize(16),
                        ),
                        "h2": Style(
                          textAlign: TextAlign.center,
                          fontSize: FontSize(30),
                          fontWeight: FontWeight.bold,
                        ),
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
