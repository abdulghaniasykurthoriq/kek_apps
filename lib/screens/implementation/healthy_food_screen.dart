import 'package:flutter/material.dart';
import 'package:kek_app/components/button_primary.dart';
// import 'package:kek_app/components/input_special.dart';
import 'package:kek_app/components/special_appbar.dart';
import 'package:kek_app/theme.dart';
// import 'package:kek_app/models/api_response.dart';
// import 'package:kek_app/models/diagnosis_provider.dart';
// import 'package:kek_app/models/patient.dart';
// import 'package:kek_app/services/riwayat_patient_service.dart';
// import 'package:kek_app/pages/home_screen.dart';
// import 'package:kek_app/theme.dart';
// import 'package:provider/provider.dart';

class HealthyFoodScreen extends StatefulWidget {
  const HealthyFoodScreen({Key? key}) : super(key: key);

  @override
  State<HealthyFoodScreen> createState() => _HealthyFoodScreenState();
}

class _HealthyFoodScreenState extends State<HealthyFoodScreen> {
  // const AdditioanFoodScreen({Key? key, this.patient, this.resultDiagnosis})
  @override
  Widget build(BuildContext context) {
    Column pengetahuanKesehatan() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'KEBUTUHAN NUTRISI IBU HAMIL',
            style:
                popinsBlackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PENGERTIAN',
                  style: popinsBlackTextStyle.copyWith(
                      fontWeight: bold, fontSize: 16),
                ),
                const Text(
                  'Nutrisi Ibu Hamil adalah salah satu hal penting yang harus diperhatikan selama masa kehamilan. Ibu hamil membutuhkan banyak nutrisi untuk membantu tumbuh kembang janin. Tujuannya adalah agar saat si kecil lahir, ia dapat tumbuh menjadi anak yang sehat dan cerdas.',
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'TANDA DAN GEJALA KURANGNYA NUTRISI IBU HAMIL',
                  style: popinsBlackTextStyle.copyWith(
                      fontWeight: bold, fontSize: 16),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1. Kelelahan dan kekurangan energi',
                    ),
                    Text(
                      '2. Pusing',
                    ),
                    Text(
                      '3. Sistem kekebalan tubuh rendah yang mengakibatkan tubuh kesulitan untuk melawan infeksi',
                    ),
                    Text(
                      '4. Kulit kering',
                    ),
                    Text(
                      '5. Gusi bengkak dan berdarah',
                    ),
                    Text(
                      '6. Sulit untuk berkonsentrasi dan mempunyai reaksi lambat',
                    ),
                    Text(
                      '7. Berat badan berkurang',
                    ),
                    Text(
                      '8. Pertumbuhan yang lambat',
                    ),
                    Text(
                      '9. Kelemahan pada otot',
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'MANFAAT NUTRISI BAGI IBU HAMIL',
                  style: popinsBlackTextStyle.copyWith(
                      fontWeight: bold, fontSize: 16),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1. Menjaga kesehatan ibu hamil',
                    ),
                    Text(
                      '2. Menjaga kesehatan janin yang ada dalam kandungan',
                    ),
                    Text(
                      '3. Persiapan untuk menghadapi persalinan',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'AKIBAT KEKURANGAN NUTRISI PADA IBU HAMIL',
                  style: popinsBlackTextStyle.copyWith(
                      fontWeight: bold, fontSize: 16),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A. Pada Janin',
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.0), // Padding untuk menggeser Row
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '1. Proses perkembangan dan pertumbuhan akan terganggu',
                          ),
                          Text(
                            '2. Risiko keguguran, cacat pada janin',
                          ),
                          Text(
                            '3. BBLR',
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'B. Pada Ibu',
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.0), // Padding untuk menggeser Row
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '1. Ibu lemah dan kurang nafsu makan',
                          ),
                          Text(
                            '2. Perdarahan dalam masa kehamilan',
                          ),
                          Text(
                            '3. Kemungkinan terjadi infeksi tinggi',
                          ),
                          Text(
                            '4. Kurang darah atau anemia',
                          ),
                          Text(
                            '5. Preeklampsia',
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'KEBUTUHAN NUTRISI IBU HAMIL',
                  style: popinsBlackTextStyle.copyWith(
                      fontWeight: bold, fontSize: 16),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1. Karbohidrat dan lemak sebagai sumber zat tenaga untuk menghasilkan kalori dapat diperoleh dari serealia, umbi-umbian.l',
                    ),
                    Text(
                      '2. Protein dapat diperoleh dari  tahu, tempe, daging, ayam, ikan, susu, dan telur. ',
                    ),
                    Text(
                      '3. Mineral sebagai zat pengatur dapat diperoleh dari buah-buahan dan sayur–sayuran',
                    ),
                    Text(
                      '4. Vitamin B kompleks berguna untuk menjaga sistem saraf, otot dan jantung agar berfungsi secara normal. Dapat dijumpai pada serealia, biji – bijian, kacang-kacangan, sayuran hijau, ragi, telur dan produk susu.',
                    ),
                    Text(
                      '5. Vitamin D berguna untuk pertumbuhan dan pembentukan tulang bayi Anda. Sumbernya terdapat pada minyak hati ikan, kuning telur dan susu',
                    ),
                    Text(
                      '6. Vitamin E berguna bagi pembentukan sel darah merah yang sehat. Makanlah lembaga biji-bijian terutama gandum, kacang-kacangan, minyak sayur dan sayuran hijau.n',
                    ),
                    Text(
                      '7. Asam folat berguna untuk perkembangan sistem saraf dan sel darah, banyak terdapat pada sayuran berwarna hijau gelap seperti bayam, kembang kol dan brokoli. Pada buah-buahan, asam folat terdapat dalam jeruk, pisang, wortel dan tomat',
                    ),
                    Text(
                      '8. Zat besi yang dibutuhkan ibu hamil agar terhindar dari anemia, banyak terdapat pada sayuran hijau (seperti bayam, kangkung, daun singkong, daun pepaya), daging dan hati',
                    ),
                    Text(
                      '9. Kalsium, diperlukan untuk pertumbuhan tulang dan gigi janin, serta melindungi ibu hamil dari osteoporosis Sumber kalsium adalah sayuran hijau dan kacang-kacangan. Saat ini kalsium paling baik diperoleh dari susu serta produk olahannya. Susu juga mengandung banyak vitamin, seperti vitamin A, D, B2, B3, dan vitamin C',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'HAL YANG PERLU DIHINDARI OLEH IBU HAMIL',
                  style: popinsBlackTextStyle.copyWith(
                      fontWeight: bold, fontSize: 16),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1. Menghindari mengkonsumsi makanan kaleng, makanan manis yang berlebihan, makanan yang sudah tidak segar.',
                    ),
                    Text(
                      '2. Mengurangi bahan makanan yang banyak mengandung gas, seperti sawi, kool, kubis dan lain-lain.',
                    ),
                    Text(
                      '3. Mengurangi bumbu yang merangsang, seperti pedas, santan kental',
                    ),
                    Text(
                      '4. Menghindari merokok dan minum-minuman keras.',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: specialAppbar('Pendidikan', 'Kesehatan', 'Pasien', () {
          Navigator.pop(context);
        }, ''),
        body: ListView(
          children: [
            // Consumer<DiagnosisProvider>(
            //   builder: (context, diagnosis, child) {
            //     return Text(diagnosis.tinggiBadan.toString());
            //   },
            // ),
            // BtnPrimary(
            //   'Selesai',
            //   () {},
            // ),
            pengetahuanKesehatan(),
            // Container(
            //   height: 100,
            //   color: redColor,
            // ),
            BtnPrimary(
              'Selesai',
              () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              },
            ),
            BtnPrimary(
              'Evaluasi',
              () {
                Navigator.pushNamed(context, '/evaluasi',
                    arguments: (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
