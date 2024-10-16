import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class SandiMorseScreen extends StatelessWidget {
  const SandiMorseScreen({super.key});

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
                "Sandi Morse",
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
                      "assets/images/sandi_morse_value.jpeg",
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(height: 10),
                    Html(
                      data: """
<h2><b>Kode Morse</b></h2>
<p>Kode Morse atau 'Sandi Morse' adalah sistem representasi huruf, angka, tanda baca, dan sinyal dengan menggunakan kode titik dan garis yang disusun mewakili karakter tertentu pada alfabet atau sinyal (pertanda) tertentu yang disepakati penggunaannya di seluruh dunia. Kode Morse diciptakan oleh Samuel F.B. Morse dan Alfred Vail pada tahun 1835.</p>
<p>Kode morse juga digunakan dan dipelajari di dunia kepramukaan atau kepanduan. Dalam dunia kepramukaan, kode morse disampaikan menggunakan senter atau peluit pramuka. Kode morse disampaikan dengan cara meniup peluit dengan durasi pendek untuk mewakili titik dan meniup peluit dengan durasi panjang untuk mewakili garis. Untuk menghafalkan kode ini digunakan metode yang mengelompokkan huruf-huruf berdasarkan bagaimana huruf ini diwakili oleh kode morsenya. Pengelompokan tersebut antara lain Alphabet dengan kode morse yang berkebalikan antara titik dan garis, misalnya huruf K yang diwakili oleh -.- berkebalikan dengan huruf R yang diwakili oleh .-. dan alfabet dengan kode morse berlawanan. Misalnya, huruf A yang diwakili oleh .- dan huruf N yang diwakili oleh -..</p>
<p>Kemampuan menerima dan mengirimkan kode morse merupakan salah satu dari kecakapan yang dapat menerima Tanda Kecakapan Khusus. Kode morse juga digunakan sebagai kunci dalam memecahkan Sandi Rumput.</p>
<h3>Metode Pembelajaran Kode Morse</h3>
<ul>
  <li><b>Metode Koch:</b> Metode Koch adalah metode pembelajaran pengiriman kode morse dengan sistem gradual. Latihan dengan metode Koch dimulai dengan menggunakan dua huruf yang diulang terus menerus (umumnya E dan T untuk alasan pembiasaan dengan interval). Setelah seseorang menguasai dua huruf ini dan dapat membaca maupun mengirimkannya dengan cepat, maka satu huruf ditambahkan, dan seterusnya hingga seseorang yang mempelajari kode morse dapat menguasai pembacaan maupun pengiriman kode melalui pembiasaan.</li>
  <li><b>Metode Substitusi:</b> Metode ini umum digunakan di kepramukaan Indonesia, yaitu dengan membuat padanan kata yang berawal dari alfabet latin, dan setiap O mewakili garis ( - ), dan setiap huruf vokal lain mewakili titik (.).</li>
  <li><b>Pengelompokan:</b> Metode yang mengelompokkan huruf-huruf berdasarkan bagaimana huruf ini diwakili oleh kode morsenya. Pengelompokan tersebut antara lain Alphabet dengan kode morse yang berkebalikan antara titik dan garis, misalnya huruf K yang diwakili oleh -.- berkebalikan dengan huruf R yang diwakili oleh .-. dan alfabet dengan kode morse berlawanan. Misalnya, huruf A yang diwakili oleh .- dan huruf N yang diwakili oleh -..</li>
</ul>
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
                          fontSize: FontSize(24),
                          fontWeight: FontWeight.bold,
                        ),
                        "ul": Style(),
                        "li": Style(
                          fontSize: FontSize(16),
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
