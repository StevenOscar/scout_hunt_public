import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class KodeKehormatanPramukaScreen extends StatelessWidget {
  const KodeKehormatanPramukaScreen({super.key});

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
                  "Kode Kehormatan Pramuka",
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
                        "assets/images/kode_kehormatan_value.jpeg",
                        fit: BoxFit.fitWidth,
                      ),
                      const SizedBox(height: 10),
                      Html(
                        data: """
                  <h3><b>Kode Kehormatan bagi Pramuka Siaga</b></h3>
                  <p>Meliputi Dwisatya (janji dan komitmen diri) dan Dwidarma (ketentuan moral).</p>
                  <ul>
                    <li><b>Dwisatya</b>
                      <p>Demi kehormatanku aku berjanji akan bersungguh-sungguh:</p>
                      <ul>
                        <li>Menjalankan kewajibanku terhadap Tuhan Yang Maha Esa, Negara Kesatuan Republik Indonesia dan menurut aturan keluarga.</li>
                        <li>Setiap hari berbuat kebaikan.</li>
                      </ul>
                    </li>
                    <li><b>Dwidarma</b>
                      <ul>
                        <li>Siaga berbakti pada ayah dan ibundanya.</li>
                        <li>Siaga berani dan tidak putus asa.</li>
                      </ul>
                    </li>
                  </ul>
                  
                  <h3><b>Kode Kehormatan bagi Pramuka Penggalang</b></h3>
                  <p>Meliputi Trisatya (janji dan komitmen diri) dan Dasadarma (ketentuan moral).</p>
                  <ul>
                    <li><b>Trisatya</b>
                      <p>Demi kehormatanku aku berjanji akan bersungguh-sungguh:</p>
                      <ul>
                        <li>Menjalankan kewajibanku terhadap Tuhan Yang Maha Esa, Negara Kesatuan Republik Indonesia dan mengamalkan Pancasila.</li>
                        <li>Menolong sesama hidup dan mempersiapkan diri membangun masyarakat.</li>
                        <li>Menepati Dasadarma.</li>
                      </ul>
                    </li>
                    <li><b>Dasadarma</b>
                      <ul>
                        <li>Takwa kepada Tuhan Yang Maha Esa.</li>
                        <li>Cinta alam dan kasih sayang sesama manusia.</li>
                        <li>Patriot yang sopan dan kesatria.</li>
                        <li>Patuh dan suka bermusyawarah.</li>
                        <li>Rela menolong dan tabah.</li>
                        <li>Rajin, terampil, dan gembira.</li>
                        <li>Hemat, cermat, dan bersahaja.</li>
                        <li>Disiplin, berani, dan setia.</li>
                        <li>Bertanggung jawab dan dapat dipercaya.</li>
                        <li>Suci dalam pikiran, perkataan dan perbuatan.</li>
                      </ul>
                    </li>
                  </ul>
                  
                  <h3><b>Kode Kehormatan bagi Pramuka Penegak, Pramuka Pandega, dan Anggota Dewasa</b></h3>
                  <p>Meliputi Trisatya (janji dan komitmen diri) dan Dasadarma (ketentuan moral).</p>
                  <ul>
                    <li><b>Trisatya</b>
                      <p>Demi kehormatanku aku berjanji akan bersungguh-sungguh:</p>
                      <ul>
                        <li>Menjalankan kewajibanku terhadap Tuhan Yang Maha Esa, Negara Kesatuan Republik Indonesia dan mengamalkan Pancasila.</li>
                        <li>Menolong sesama hidup dan ikut serta membangun masyarakat.</li>
                        <li>Menepati Dasadarma.</li>
                      </ul>
                    </li>
                    <li><b>Dasadarma</b>
                      <ul>
                        <li>Takwa kepada Tuhan Yang Maha Esa.</li>
                        <li>Cinta alam dan kasih sayang sesama manusia.</li>
                        <li>Patriot yang sopan dan kesatria.</li>
                        <li>Patuh dan suka bermusyawarah.</li>
                        <li>Rela menolong dan tabah.</li>
                        <li>Rajin, terampil, dan gembira.</li>
                        <li>Hemat, cermat, dan bersahaja.</li>
                        <li>Disiplin, berani, dan setia.</li>
                        <li>Bertanggung jawab dan dapat dipercaya.</li>
                        <li>Suci dalam pikiran, perkataan dan perbuatan.</li>
                      </ul>
                    </li>
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
