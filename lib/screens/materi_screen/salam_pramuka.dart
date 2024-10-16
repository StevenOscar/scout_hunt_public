import 'package:flutter/material.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class SalamPramukaScreen extends StatelessWidget {
  const SalamPramukaScreen({super.key});

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
                "Salam Pramuka",
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/salam_pramuka_value.jpg",
                        fit: BoxFit.fitWidth,
                      ),
                      const SizedBox(height: 10),
                      Html(
                        data: """
                  <p>Salam (penghormatan) diberikan kepada semua anggota Pramuka. Salam dalam Gerakan Pramuka tidak hanya diberikan kepada mereka yang mempunyai pangkat, tetapi diberikan kepada seluruh anggota Pramuka, sebab hal tersebut merupakan pengingat tentang Janji Pramuka.</p>
                  
                  <h3><b>Makna dan Tujuan Salam</b></h3>
                  <p>Salam penghormatan adalah suatu perwujudan dari penghargaan seseorang terhadap orang lain atas dasar susila yang sesuai dengan kepribadian Bangsa Indonesia. Tujuan salam adalah untuk melahirkan kedisiplinan, tata-tertib yang mewujudkan suatu ikatan jiwa yang kuat ke dalam maupun ke luar, yang hanya dapat dicapai antara lain dengan adanya saling menyampaikan penghormatan yang dilakukan dengan tertib, sempurna dan penuh keikhlasan.</p>
                  
                  <h3><b>Cara Memberikan Salam</b></h3>
                  <p>Secara umum, sikap seseorang memberikan salam dengan memakai topi ataupun tidak sama saja, sesudah ia mengambil sikap sempurna, sebagai berikut:</p>
                  <ul>
                    <li>Dengan gerakan cepat tangan kanan diangkat ke arah pelipis kanan, siku-siku 15° serong ke depan, kelima jari lurus dan rapat satu sama lain, telapak tangan serong ke bawah dan ke kiri, ujung jari tengah dan telunjuk mengenai pelipis.</li>
                    <li>Pergelangan tangan lurus, bahu seperti dalam sikap sempurna, pandangan muka tetap tertuju kepada yang diberi hormat.</li>
                    <li>Jika selesai menghormat, maka lengan kanan dikembalikan secara cepat ke sikap sempurna lagi.</li>
                  </ul>
                  
                  <h3><b>Jenis-Jenis Salam Pramuka</b></h3>
                  <ol>
                    <li><b>Salam Biasa</b>
                      <p>Digunakan apabila seorang Pramuka berjumpa dengan Pramuka lain, untuk pertama kali atau yang terakhir kali pada hari itu. Siapa yang melihat dulu, dia harus memberikan penghormatan terlebih dahulu tanpa aba-aba, tanpa mengenal pangkat maupun usia. Salam ini dapat diberikan sambil berjalan, duduk, ataupun dalam berkendara. Cara memberikan salam: dengan cara mengangkat tangan kanan ke pelipis mata bila tidak sedang membawa sesuatu. Jika tangan kanan membawa tongkat, maka tongkat itu diangkat lurus ke atas kira-kira 10 cm, tangan kiri diletakkan merata ke depan dada dengan telapak tangan menghadap ke bawah dan ibu jari menempel pada tongkat.</p>
                    </li>
                    <li><b>Salam Hormat</b>
                      <p>Dipergunakan apabila seorang Pramuka:</p>
                      <ul>
                        <li>Bertemu dengan orang yang wajib dihormati, seperti Presiden, Wakil Presiden, Menteri, Gubernur, Walikota, dan sebagainya. Termasuk para pejabat, guru, tokoh masyarakat serta orang tua.</li>
                        <li>Melihat bendera Merah Putih sedang dikibarkan atau diturunkan. Jika sedang sibuk melakukan sesuatu kemudian mendengar peluit tanda Sang Merah Putih sedang dikibarkan atau diturunkan, maka segera berhenti dan berdiri tegak di tempat dan menghadap bendera dan memberi Salam Hormat.</li>
                        <li>Dalam suatu upacara mendengarkan lagu Indonesia Raya. Tetapi jika dia ikut bernyanyi maka tidak harus memberikan Salam Hormat, melainkan cukup berdiri tegak saja.</li>
                        <li>Jika bertemu dengan rombongan jenazah yang dibawa ke makam, jika sedang duduk atau berjalan, maka segera berdiri tegak menghadap ke arah jenazah sambil memberi hormat.</li>
                      </ul>
                      <p>Cara memberikan Salam Hormat pada dasarnya sama dengan Salam Biasa, juga jika sedang membawa tongkat.</p>
                    </li>
                    <li><b>Salam Janji</b>
                      <p>Digunakan seorang Pramuka dalam suatu upacara mendengar temannya mengucapkan Janji Trisatya. Begitu kita mendengar ucapan: "Demi kehormatanku aku berjanji" dan seterusnya dalam suatu upacara pelantikan, maka semua Pramuka yang hadir wajib memberikan Salam Janji secara otomatis, tanpa disertai aba-aba.</p>
                    </li>
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
