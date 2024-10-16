import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class PeraturanBarisScreen extends StatelessWidget {
  const PeraturanBarisScreen({super.key});

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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Peraturan Baris Berbaris",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/peraturan_berbaris_value.jpg",
                        fit: BoxFit.fitWidth,
                      ),
                      const SizedBox(height: 10),
                      Html(
                        data: """
                <div class="section">
                    <h3>1. Pengertian Baris Berbaris</h3>
                    <p>Baris berbaris adalah suatu wujud latihan fisik, yang diperlukan guna menanamkan kebiasaan dalam tata cara kehidupan yang diarahkan kepada terbentuknya suatu perwatakan tertentu. Sikap lahir yang diperoleh adalah: ketegaran, keseragaman, ketangkasan, kesigapan, kelincahan, keindahan, kerapihan, ketanggapan, ketertiban, kewajaran tenaga, kekhidmatan, kesopanan, kekompakan, dan ketelitian. Sikap batin yang diperoleh adalah: ketenangan, keberanian, ketaatan, kekuatan, keikhlasan, kesadaran, konsentrasi, kesetiakawanan, dan berani berkorban.</p>
                </div>
                
                <div class="section">
                    <h3>2. Maksud dan Tujuan Peraturan Baris Berbaris</h3>
                    <p>Maksud dari PBB dapat dibagi menjadi 2:</p>
                    <ul>
                        <li><strong>Maksud Umum:</strong> Suatu latihan awal membela negara dan dapat membedakan hak dan kewajiban.</li>
                        <li><strong>Maksud Khusus:</strong> Menanamkan rasa disiplin, mempertebal rasa semangat kebersamaan.</li>
                    </ul>
                    <p>Adapun tujuan dari PBB:</p>
                    <ul>
                        <li>Guna menumbuhkan sikap jasmani yang tegap dan tangkas, rasa persatuan, disiplin, sehingga dengan demikian senantiasa dapat mengutamakan kepentingan tugas di atas kepentingan individu dan secara tidak langsung juga menanamkan rasa tanggung jawab.</li>
                        <li>Yang dimaksud dengan menumbuhkan sikap jasmani yang tegap dan tangkas adalah mengarahkan pertumbuhan tubuh yang diperlukan oleh tugas pokok tersebut dengan sempurna.</li>
                        <li>Yang dimaksud dengan rasa persatuan adalah rasa senasib dan sepenanggungan serta ikatan batin yang sangat diperlukan dalam menjalankan tugas.</li>
                        <li>Yang dimaksud dengan disiplin adalah mengutamakan kepentingan tugas di atas individu yang hakikatnya tidak lain daripada keikhlasan menyisihkan pilihan hati sendiri.</li>
                        <li>Yang dimaksud dengan rasa tanggung jawab adalah keberanian untuk bertindak yang mengandung risiko terhadap dirinya tetapi menguntungkan tugas atau sebaliknya tidak mudah melakukan tindakan yang akan dapat merugikan kesatuan.</li>
                    </ul>
                </div>
                
                <div class="section">
                    <h3>3. Gerakan dalam Peraturan Baris Berbaris</h3>
                    <p><strong>1. Aba-Aba:</strong> Aba-aba adalah suatu perintah yang diberikan oleh seseorang Pemimpin kepada yang dipimpin untuk dilaksanakannya pada waktunya secara serentak atau berturut-turut. Ada tiga macam aba-aba yaitu:</p>
                    <ul>
                        <li><strong>Aba-aba petunjuk:</strong> Digunakan jika perlu untuk menegaskan maksud dari pada aba-aba peringatan/pelaksanaan. Contoh: Kepada Pemimpin Upacara-Hormat – GERAK.</li>
                        <li><strong>Aba-aba peringatan:</strong> Inti perintah yang cukup jelas, untuk dapat dilaksanakan tanpa ragu-ragu. Contoh: Lencang kanan – GERAK.</li>
                        <li><strong>Aba-aba pelaksanaan:</strong> Ketegasan mengenai saat untuk melaksanakan aba-aba. Contoh: Jalan ditempat - GERAK.</li>
                    </ul>

                    <p><strong>2. Gerakan pada PBB:</strong> PBB terdiri dari 2 gerakan yaitu Gerak ditempat dan Gerak berjalan. Berikut adalah beberapa gerakan pada PBB:</p>
                    <ul>
                        <li><strong>Sikap Sempurna:</strong> Badan berdiri tegap, kedua tumit rapat, lutut lurus, dan sebagainya.</li>
                        <li><strong>Hormat:</strong> Mengangkat tangan kanan sedikit ditekuk ke depan, jari telunjuk menyentuh pelipis kanan bawah.</li>
                        <li><strong>Lencang Kanan / Kiri:</strong> Mengangkat tangan kanan/kiri ke samping, kepala dipalingkan ke kanan/kiri.</li>
                        <li><strong>Berhitung:</strong> Menyebut nomor berturut-turut mulai dari penjuru menyebut nomor.</li>
                        <li><strong>Hadap Kanan/Kiri:</strong> Kaki kanan/kiri melintang di depan kaki kanan/kiri, berat badan berpindah ke kaki kanan/kiri.</li>
                        <li><strong>Hadap Serong Kanan/Kiri:</strong> Kaki kanan/kiri diajukan ke depan, sejajar dengan kaki kanan/kiri, berputar arah 45° ke kanan/kiri.</li>
                        <li><strong>Balik Kanan:</strong> Kaki kiri diajukan melintang, tumit kaki kanan diputar ke kanan 180°.</li>
                        <li><strong>Istirahat ditempat:</strong> Kaki kiri dipindahkan kesamping kiri, kedua belah lengan dibawa ke belakang di bawah pinggang.</li>
                    </ul>

                    <p><strong>3. Cara memberi aba-aba:</strong> Pemberi aba-aba harus berdiri dalam sikap sempurna, menghadap pasukan, dan sebagainya.</p>
                </div>
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
