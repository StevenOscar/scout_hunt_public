import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class TaliTemaliScreen extends StatelessWidget {
  const TaliTemaliScreen({super.key});

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
                "Tali Temali",
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
                      "assets/images/tali_temali_value.jpg",
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(height: 10),
                    Html(
                      data: """
<h2><b>Tali Temali</b></h2>
<h3><b>1. Simpul Mati</b></h3>
<p>Simpul mati adalah simpul yang biasanya digunakan untuk mengakhiri suatu simpul. Walaupun simpul ini terlihat mudah dalam membuatnya, namun banyak juga yang salah dalam membuatnya.</p>
<p><b>Fungsi:</b> Simpul ini berfungsi untuk menyambung dua utas tali yang sama besarnya dan tidak licin.</p>

<h3><b>2. Simpul Pangkal</b></h3>
<p>Simpul Pangkal merupakan salah satu simpul yang sering sekali digunakan untuk mengawali atau mengakhiri suatu simpul lainnya.</p>
<p><b>Fungsi:</b> Simpul pangkal berfungsi untuk permulaan ikatan dalam mengikat tali pada tongkat atau tiang, kayu.</p>

<h3><b>3. Simpul Jangkar</b></h3>
<p>Dalam cara pembuatan simpul jangkar tidak begitu sulit alias mudah. Ada beberapa cara dalam membuat tali temali simpul jangkar ini salah satunya adalah:</p>
<ul>
  <li>Bagilah tali menjadi dua kemudian lingkarkan pada benda yang ingin ditali.</li>
  <li>Tariklah kedua badan tali, sehingga semua tali masuk ke dalam sosok.</li>
</ul>
<p><b>Fungsi:</b> Fungsi dari tali temali simpul ini adalah untuk membuat tanduk darurat atau dapat juga digunakan untuk mengikat timba atau ember.</p>

<h3><b>4. Simpul Tarik</b></h3>
<p>Tali Temali simpul tarik (bowline knot) menghasilkan loop tali yang tidak bisa mengecil ataupun membesar lagi.</p>
<p><b>Fungsi:</b> Fungsi dari tali temali simpul tarik adalah untuk turun ke jurang atau dari atas pohon.</p>

<h3><b>5. Simpul Lasso</b></h3>
<p><b>Fungsi:</b> Kegunaan dari simpul lasso ini adalah untuk mengikat leher binatang, baik binatang buas maupun tidak buas.</p>

<h3><b>6. Simpul Anyam Tunggal</b></h3>
<p><b>Fungsi:</b> Fungsi dari simpul anyam adalah untuk menyambung dua utas tali yang tidak sama besarnya dan dalam keadaan kering.</p>

<h3><b>7. Simpul Anyam Ganda</b></h3>
<p><b>Fungsi:</b> Kegunaan atau fungsi dari temali simpul anyaman berganda adalah untuk menyambung dua utas tali yang ukurannya tidak sama besar dan tidak licin.</p>

<h3><b>8. Simpul Rantai</b></h3>
<p><b>Fungsi:</b> Kegunaan dari temali anyaman rantai adalah untuk memendekkan tali.</p>

<h3><b>9. Simpul Kembar</b></h3>
<p><b>Fungsi:</b> Kegunaan dari temali simpul kembar adalah untuk menyambung dua utas tali yang sama besarnya bisa digunakan dalam keadaan basah atau licin.</p>

<h3><b>10. Simpul Tambat</b></h3>
<p><b>Fungsi:</b> Temali simpul tambat juga berfungsi sebagai awalan pada simpul-simpul yang lainnya, seperti simpul silang dan simpul palang. Kegunaan lainnya adalah untuk memulai ikatan bisa juga digunakan untuk menyeret balok.</p>

<h3><b>11. Simpul Hidup</b></h3>
<p>Simpul hidup adalah simpul yang mudah dilepas dengan satu tarikan.</p>
<p><b>Fungsi:</b> Digunakan untuk mengikat benda yang mudah dilepas kembali.</p>

<h3><b>12. Simpul Ujung Tali</b></h3>
<p>Simpul ujung tali adalah simpul yang digunakan untuk mengakhiri tali agar tidak mudah terurai.</p>
<p><b>Fungsi:</b> Untuk mencegah tali terurai di ujungnya.</p>

<h3><b>13. Simpul Tiang</b></h3>
<p>Simpul tiang adalah simpul yang digunakan untuk mengikat tali pada tiang atau benda yang berbentuk silinder.</p>
<p><b>Fungsi:</b> Untuk mengikat tali pada tiang atau benda berbentuk silinder.</p>

<h3><b>14. Simpul Penarik</b></h3>
<p>Simpul penarik adalah simpul yang digunakan untuk menarik benda dengan aman.</p>
<p><b>Fungsi:</b> Untuk menarik benda dengan aman.</p>

<h3><b>15. Simpul Prusik</b></h3>
<p>Simpul prusik adalah simpul yang dapat digerakkan dan dikunci pada tali utama.</p>
<p><b>Fungsi:</b> Digunakan untuk mendaki atau memanjat tali utama.</p>
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
                          textAlign: TextAlign.left,
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
