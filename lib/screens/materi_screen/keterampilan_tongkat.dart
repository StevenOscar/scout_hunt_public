import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class KeterampilanTongkatScreen extends StatelessWidget {
  const KeterampilanTongkatScreen({super.key});

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
                "Keterampilan Tongkat",
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
                      "assets/images/keterampilan_tongkat_value.png",
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(height: 10),
                    Html(
                      data: """
<h3><b>Tata Cara Menggunakan Tongkat dalam Baris Berbaris</b></h3>
<p>Pelaksanaan dalam kegiatan baris-berbaris atau (PBB) dalam kepramukaan dapat juga menggunakan tongkat pramuka. Baris-berbaris dengan menggunakan tongkat ini memiliki tata cara dan pedoman tersendiri yang telah diatur oleh kwartir Nasional Gerakan Pramuka.</p>
<ol>
  <li><b>Pindah Tongkat:</b> Tongkat digenggam dengan tangan kiri (ibu jari dengan keempat jari lainnya) di depan dada.</li>
  <li><b>Posisi Tongkat:</b> Tongkat miring (bagian bawah di sisi kanan tubuh sedangkan bagian atas di sisi kiri tubuh) di depan dada.</li>
  <li><b>Tangan Kanan:</b> Mengambil jarak satu lengan dengan menggapai dan menyentuh bahu kiri kanan di sebelahnya.</li>
  <li><b>Pandangan:</b> Melihat ke kanan dan meluruskan.</li>
</ol>

<h3><b>Cara Membawa Tongkat Tanpa Mengikuti Aba-Aba Baris Berbaris</b></h3>
<p>Membawa tongkat pramuka tanpa mengikuti aba-aba berbaris saat pramuka berjalan jauh atau berbaris tetapi dengan aba-aba santai atau bebas. Cara membawa tongkat bisa dengan cara:</p>
<ol>
  <li><b>Disandang:</b> Seperti sikap membawa tongkat saat sedang berjalan atau berlari.</li>
  <li><b>Dipanggul:</b> Di pundak sebelah kiri dan ujung bawah tongkat dipegang tangan kiri.</li>
  <li><b>Dibawa dengan diikat tali:</b> Kemudian disandang di bahu.</li>
</ol>

<h3><b>Sikap dalam Memberi Salam Biasa dan Salam Hormat Menggunakan Tongkat</b></h3>
<p><b>Salam Biasa:</b> Pramuka atau penghormatan yang diberikan kepada sesama pramuka maupun kakak pembina baik di luar upacara maupun saat upacara.</p>
<ol>
  <li><b>Dari Sikap Sempurna:</b> Tongkat digenggam dan diangkat lurus ke atas, dengan posisi tangan kanan setinggi ikat pinggang.</li>
  <li><b>Tangan Kiri:</b> Dibuka, diletakkan rata di depan dada dengan telapak tangan menghadap ke bawah, ujung jari kiri menyentuh tongkat.</li>
  <li><b>Pandangan Mata:</b> Lurus ke depan melihat ke arah yang diberi salam.</li>
</ol>
<p><b>Salam Hormat:</b> Salam atau penghormatan yang diberikan kepada bendera merah putih saat dikibarkan, lagu Indonesia Raya saat dikumandangkan, kepala dan wakil kepala negara, para duta negara, panglima tinggi, para mentri dan pejabat lainnya, jenazah yang sedang diusung atau dikuburkan saat memasuki makam pahlawan.</p>
<ol>
  <li><b>Pindah Tongkat:</b> Tongkat digenggam dengan tangan kiri (ibu jari dengan keempat jari lainnya), dengan posisi tongkat miring (bagian bawah di sisi kanan tubuh sedangkan bagian atas di sisi kiri tubuh) di depan dada.</li>
  <li><b>Tangan Kanan:</b> Memberi salam hormat, yaitu diangkat pada pelipis dengan posisi telapak tangan miring, terbuka, punggung tangan di bagian atas dan kelima jari rapat.</li>
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
