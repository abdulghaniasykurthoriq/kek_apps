import 'package:flutter/material.dart';
import 'package:kek_app/components/button_primary.dart';
import 'package:kek_app/components/special_appbar.dart';
// import 'package:kek_app/theme.dart';

class EvaluasiScreen extends StatefulWidget {
  const EvaluasiScreen({Key? key}) : super(key: key);

  @override
  State<EvaluasiScreen> createState() => _EvaluasiScreenState();
}

class _EvaluasiScreenState extends State<EvaluasiScreen> {
  // const AdditioanFoodScreen({Key? key, this.patient, this.resultDiagnosis})
  @override
  Widget build(BuildContext context) {
    Container pengetahuanKesehatan() {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Makanan Tambahan'),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Makanan tambahan terpenuhi?'),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text('Pendidikan Kesehatan'),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Menyebutkan tanda dan gejala kekurangan nutrisi!'),
                    Text('Menyebutkan manfaat nutrisi bagi ibu hamil!'),
                    Text(
                        'Menyebutkan akibat kekurangan nutrisi pada ibu hamil!'),
                    Text(
                        'Menyebutkan akibat kekurangan nutrisi pada ibu hamil!'),
                  ],
                ),
              ),
            ],
          ));
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: specialAppbar('Evaluasi', '', 'Pasien', () {
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
          ],
        ),
      ),
    );
  }
}
