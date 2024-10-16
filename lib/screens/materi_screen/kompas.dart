import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class KompasScreen extends StatelessWidget {
  const KompasScreen({super.key});

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
                "Kompas",
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
                      "assets/images/kompas_value.jpg",
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(height: 10),
                    Html(
                      data: """
<p><b>Pengantar:</b> Kompas adalah alat bantu untuk menentukan arah mata angin. Di hutan, kompas sangat berperan penting dalam membantu menentukan kemana kita akan pergi dan agar tidak tersesat, tentunya dengan melihat peta juga. Namun, kompas sangat berguna karena dapat menentukan arah dengan tepat hanya dengan memegangnya dengan rata atau meletakkannya di dataran yang rata.</p>

<h3><b>Bagian-bagian Kompas</b></h3>
<ol>
  <li><b>Dial:</b> Permukaan di mana tertera angka dan huruf seperti pada permukaan jam.</li>
  <li><b>Visir:</b> Pembidik sasaran.</li>
  <li><b>Kaca Pembesar:</b> Untuk pembacaan pada angka.</li>
  <li><b>Jarum Penunjuk:</b> Menunjukkan arah utara magnetis.</li>
  <li><b>Tutup Dial:</b> Dengan dua garis bersudut 45 derajat.</li>
  <li><b>Alat Penggantung:</b> Dapat juga digunakan sebagai penyangkut ibu jari untuk menopang kompas pada saat membidik.</li>
</ol>

<h3><b>Angka-angka pada Kompas dan Istilahnya</b></h3>
<ul>
  <li><b>North:</b> Utara = 0°</li>
  <li><b>North East:</b> Timur Laut = 45°</li>
  <li><b>East:</b> Timur = 90°</li>
  <li><b>South East:</b> Tenggara = 135°</li>
  <li><b>South:</b> Selatan = 180°</li>
  <li><b>South West:</b> Barat Daya = 225°</li>
  <li><b>West:</b> Barat = 270°</li>
  <li><b>North West:</b> Barat Laut = 315°</li>
</ul>

<h3><b>Cara Menggunakan Kompas</b></h3>
<ol>
  <li><b>Letakkan kompas:</b> Letakkan kompas di atas permukaan yang datar. Setelah jarum kompas tidak bergerak lagi, maka jarum tersebut menunjuk ke arah utara magnetis (merah) dan belakangnya arah selatan magnetis (putih).</li>
  <li><b>Bidik sasaran:</b> Bidik sasaran melalui visir dengan kaca pembesar. Miringkan sedikit letak kaca pembesar, kira-kira 50° di mana berfungsi untuk membidik ke arah visir dan mengintai angka pada dial.</li>
  <li><b>Luruskan garis:</b> Apabila visir diragukan karena kurang jelas dilihat dari kaca pembesar, luruskan saja garis yang terdapat pada tutup dial ke arah visir, searah dengan sasaran bidik agar mudah dilihat melalui kaca pembesar.</li>
</ol>
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
