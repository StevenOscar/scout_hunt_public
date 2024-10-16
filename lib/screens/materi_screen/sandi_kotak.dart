import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class SandiKotakScreen extends StatelessWidget {
  const SandiKotakScreen({super.key});

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
                "Sandi Kotak",
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
                      "assets/images/sandi_kotak_value.png",
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(height: 10),
                    Html(
                      data: """
<h3><b> Pengertian Sandi Kotak</b></h3>
<p>Sandi kotak merupakan sandi yang ditulis dengan kotak. Sandi kotak 1 merupakan sandi yang terdiri atas palang-palang atau kotak dan sudut-sudut dengan kunci khusus. Penulisan sandi kotak 1 terdiri dari dua huruf alfabet dan titik dalam satu kotak. Selain itu, sandi kotak 1 terdiri dari dua jenis kotak, yaitu menyilang dan vertikal-horizontal.</p>


<p> Pada sandi kotak 1, Setiap 2 huruf akan dikelompokkan ke dalam sebuah kotak, apabila ingin mengisyaratkan huruf pertama dari sebuah kotak, maka gambarkanlah bentuk dari kotak tersebut, apabila ingin mengisyaratkan huruf kedua dari sebuah kotak, maka gambarkan bentuk dari kotak tersebut dan berikan tanda titik di tengahnya.</p>
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
                        "h3": Style(
                          textAlign: TextAlign.center,
                          fontSize: FontSize(24),
                          fontWeight: FontWeight.bold,
                        ),
                        "ol": Style(),
                        "ul": Style(),
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
