import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:scout_hunt/style/color_theme_style.dart';
import 'package:scout_hunt/style/text_style_widget.dart';

class SemaphoreScreen extends StatelessWidget {
  const SemaphoreScreen({super.key});

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
                "Semaphore",
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
                      "assets/images/semaphore_value.png",
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(height: 10),
                    Html(
                      data: """
<h2><b>Pengertian Semaphore</b></h2>
<p>Semaphore adalah suatu cara untuk mengirim dan menerima berita dengan menggunakan bendera, dayung, batang, tangan kosong atau dengan memakai sarung tangan. Informasi yang disampaikan dibaca melalui posisi bendera atau tangan. Namun saat ini yang umum digunakan adalah bendera, yang dinamakan dengan bendera semaphore. Pengiriman sandi atau kode melalui bendera semaphore ini memakai dua bendera, yang masing-masing ukuran bendera 45 x 45 cm. Bentuknya yang persegi merupakan gabungan dua buah segitiga sama kaki yang berbeda warna. Warna yang digunakan sebenarnya bisa bermacam-macam, namun yang biasa digunakan adalah warna merah dan kuning, dimana posisi warna merah selalu berada dekat kayu bendera. Semaphore digunakan dalam komunikasi kelautan pada awal abad ke-19.</p>

<h2><b>Prinsip Semaphore</b></h2>
<p>Dua proses bisa saling berkaitan atau menentukan sebuah proses yang lain dengan menggunakan signal-signal. Sebuah proses dapat dihentikan oleh proses yang lain, ketika menemukan signal tertentu. Suatu proses akan menunggu diproses setelah nilai integer menjadi 0. Selanjutnya sinyal akan dilakukan increamen dengan penambahan 1. Semaphore termasuk variable bertipe integer yang disampaikan oleh 2 operasi atomik standar, yaitu signal dan wait terdapat dua operasi di semaphore yaitu Down dan Up. Nama aslinya: P dan V.</p>
<p>Berikut ini merupakan simbol-simbol dalam semaphore yang diterjemahkan menjadi huruf dan angka. Untuk merumuskan sandi angka, sebelum memulai sandi maka harus diawali dengan sandi pula. “Nomor” dan jika ingin kembali membuat sandi huruf maka patut membuat sinyal “J”. Beberapa sandi lainnya yang sudah biasa digunakan dalam semaphore adalah:</p>
<ul>
  <li><b>U-R:</b> berita siap dimulai</li>
  <li><b>K:</b> siap menerima berita</li>
  <li><b>E (8 kali):</b> error / ada kesalahan</li>
  <li><b>I-N-I:</b> ulangi</li>
  <li><b>A-R:</b> berita selesai</li>
  <li><b>R:</b> dapat menerima dengan baik</li>
  <li><b>A-S:</b> tunggu</li>
  <li><b>M-K:</b> geser kanan</li>
  <li><b>M-L:</b> geser kiri</li>
</ul>

<h2><b>Prosedur Mengirim/Menerima Isyarat Semaphore</b></h2>
<h3><b>Pengirim:</b></h3>
<ol>
  <li>Memanggil, minta perhatian kepada penerima dengan isyarat “VE – VE – VE – …” dst atau yang lebih mudah dan sering digunakan “UR – UR – UR … dst.” Tanda hubung (-) dengan isyarat interval.</li>
  <li>Jika sudah ada jawaban K (siap) segera kirim berita kata demi kata lalu ditutup dengan isyarat spasi/interval, apabila selesai pengiriman kata tidak dijawab dengan C / A, maka diulangi kata terakhir.</li>
  <li>Karena diminta untuk berpindah tempat, maka pindahlah tempat yang sekiranya lebih mudah dilihat oleh penerima.</li>
  <li>Untuk memulai mengirim karakter angka/nomor, harus didahului isyarat angka (numerik) = 45, kemudian kirim angka/nomor dan sesudah selesai tutup dengan isyarat huruf (alphabet) = 47/V untuk kembali ke pengiriman karakter huruf.</li>
  <li>Apabila terjadi kesalahan dalam pengiriman isyarat, kirim tanda pembatalan/salah (Anulir) = 37 kemudian ulang kata terakhir.</li>
  <li>Apabila pesan/berita sudah selesai maka kirimkan isyarat “AR – AR – AR … dst.”</li>
</ol>

<h3><b>Penerima:</b></h3>
<ol>
  <li>Menjawab siap = “K” Dan apabila belum siap kirim Tunggu = “Q“</li>
  <li>Mengirim isyarat A atau C apabila mengerti untuk setiap kata.</li>
  <li>Bila karena suatu hal menghendaki pengirim untuk berpindah tempat, silangkan bendera di atas kepala.</li>
  <li>Mengulangi setiap angka yang telah dikirim sebagai tanda mengerti.</li>
  <li>Penerima menjawab dengan R= tanda berita telah diterima dan dimengerti.</li>
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
                        "ol": Style(),
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
