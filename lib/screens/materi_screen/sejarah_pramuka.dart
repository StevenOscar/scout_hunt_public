import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class SejarahPramukaScreen extends StatelessWidget {
  const SejarahPramukaScreen({super.key});

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
                "Sejarah Pramuka",
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/sejarah_pramuka_value.jpeg",
                        fit: BoxFit.fitWidth,
                      ),
                      const SizedBox(height: 10),
                      Html(
                        data: """
                  <h2><b>Sejarah Pramuka: Dari Baden-Powell hingga Gerakan Pramuka Indonesia</b></h2>
                  
                  <h3><b>Awal Mula Pramuka</b></h3>
                  <p>Gerakan Pramuka (Scouting) didirikan oleh Lord Robert Baden-Powell, seorang jenderal Inggris, pada awal abad ke-20. Baden-Powell mengorganisir perkemahan pertama di Pulau Brownsea, Inggris, pada tahun 1907. Ia menerbitkan buku "Scouting for Boys" pada tahun 1908, yang menjadi panduan dasar bagi gerakan ini. Tujuannya adalah membentuk karakter dan keterampilan para pemuda melalui kegiatan di alam terbuka.</p>
                  
                  <h3><b>Penyebaran Gerakan Pramuka ke Belanda dan Indonesia</b></h3>
                  <p>Gagasan Baden-Powell dengan cepat menyebar ke berbagai negara, termasuk Belanda, di mana gerakan ini dikenal dengan nama "Padvinder." Pada tahun 1912, Belanda memperkenalkan gerakan Padvinder ke Indonesia, yang saat itu merupakan koloni Belanda. Mereka mendirikan organisasi Nederland Indische Padvinders Vereeniging (NIPV) atau Persatuan Pandu-Pandu Hindia Belanda.</p>
                  
                  <h3><b>Perkembangan Pramuka di Indonesia</b></h3>
                  <p>Pemimpin-pemimpin gerakan nasional di Indonesia melihat potensi gerakan Pramuka untuk membentuk karakter pemuda Indonesia yang baik dan menjadi kader pergerakan nasional. Akibatnya, muncul berbagai organisasi kepanduan, seperti:</p>
                  <ul>
                    <li>WO (Javaanse Padvinders Organizatie)</li>
                    <li>BP (Jong Java Padvindery)</li>
                    <li>NATTPU (Nationale Islamitsche Padvindery)</li>
                    <li>SLAP (Sarekat Islam Afdeling Padvindery)</li>
                    <li>FEW (Hisbul Wathon)</li>
                  </ul>
                  <p>Dengan adanya larangan dari pemerintah Hindia Belanda untuk menggunakan istilah "Padvindery," K.H. Agus Salim menggunakan nama "Pandu" atau "Kepanduan."</p>
                  
                  <h3><b>Era Sumpah Pemuda dan Konsolidasi</b></h3>
                  <p>Kesadaran nasional yang meningkat setelah Sumpah Pemuda pada tahun 1928 mendorong penggabungan organisasi-organisasi kepanduan. Pada tahun 1930, beberapa organisasi seperti IPO, PK (Pandu Kesultanan), dan PPS (Pandu Pemuda Sumatra) bergabung menjadi KBI (Kepanduan Bangsa Indonesia). Pada tahun 1931, terbentuk PAPI (Persatuan Antar Pandu Indonesia), yang kemudian berubah menjadi BPPKI (Badan Pusat Persaudaraan Kepanduan Indonesia) pada tahun 1938.</p>
                  
                  <h3><b>Masa Pendudukan Jepang dan Pasca Kemerdekaan</b></h3>
                  <p>Selama pendudukan Jepang, gerakan kepanduan dilarang, dan banyak tokoh Pandu bergabung dengan organisasi seperti Keibondan, Seinendan, dan PETA. Setelah proklamasi kemerdekaan Indonesia, pada 28 Desember 1945 di Sala, didirikan Pandu Rakyat Indonesia sebagai satu-satunya organisasi kepanduan.</p>
                  
                  <h3><b>Pembentukan Gerakan Pramuka</b></h3>
                  <p>Pada tahun 1961, kepanduan di Indonesia terpecah menjadi sekitar 100 organisasi yang tergabung dalam tiga federasi:</p>
                  <ul>
                    <li>IPINDO (Ikatan Pandu Indonesia, didirikan 13 September 1951)</li>
                    <li>POPPINDO (Persatuan Pandu Puteri Indonesia, didirikan tahun 1954)</li>
                    <li>PKPI (Persatuan Kepanduan Puteri Indonesia)</li>
                  </ul>
                  <p>Menyadari kelemahan federasi tersebut, ketiga federasi melebur menjadi PERKINDO (Persatuan Kepanduan Indonesia). Meskipun demikian, kelemahan internal masih ada, dan ada kekhawatiran bahwa gerakan ini bisa dimanfaatkan oleh pihak komunis.</p>
                  
                  <h3><b>Keputusan Presiden dan Gerakan Pramuka</b></h3>
                  <p>Dengan dukungan Perdana Menteri Ir. Juanda, perjuangan untuk memperkuat gerakan kepanduan menghasilkan Keputusan Presiden (Keppres) No. 238 tahun 1961 tentang Gerakan Pramuka. Keppres ini, yang ditandatangani oleh Pejabat Sementara Presiden RI Ir. Juanda karena Presiden Soekarno sedang berkunjung ke Jepang, menetapkan gerakan Pramuka sebagai satu-satunya badan di wilayah Indonesia yang diperkenankan menyelenggarakan pendidikan kepramukaan.</p>
                  
                  <p>Dengan demikian, terbentuklah Gerakan Pramuka Indonesia, yang hingga kini terus berperan dalam membentuk karakter pemuda Indonesia melalui berbagai kegiatan dan program yang sesuai dengan nilai-nilai kepramukaan.</p>
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
