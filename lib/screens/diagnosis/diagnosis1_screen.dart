import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:http/http.dart';
import 'package:kek_app/components/button_primary.dart';
import 'package:kek_app/components/header.dart';
import 'package:kek_app/components/input_special.dart';
// import 'package:kek_app/components/special_appbar.dart';
import 'package:kek_app/models/patient.dart';
import 'package:kek_app/screens/diagnosis/diagnosis2_screen.dart';
import 'package:kek_app/screens/implementation/additional_food_screen.dart';
import 'package:kek_app/theme.dart';

class Diagnosis1Screen extends StatefulWidget {
  // final RiwayatPatient? riwayatPatient;
  final Patient? patient;
  const Diagnosis1Screen({Key? key, this.patient}) : super(key: key);

  @override
  State<Diagnosis1Screen> createState() => _Diagnosis1ScreenState();
}

class _Diagnosis1ScreenState extends State<Diagnosis1Screen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _txtWeight = TextEditingController();
  final TextEditingController _txtLILA = TextEditingController();

  void checkKek() {
    double lila = double.parse(_txtLILA.text);
    // ANDA KENA KEK
    if (widget.patient!.tinggiBadan! < 145 && lila < 23.5) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AdditioanFoodScreen(
              status: 'kek',
              patient: widget.patient!,
              resultDiagnosis:
                  'Lingkar Lengan < 23.5 dan tinggi badan < 145')));
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('anda kena kek')));
    }
    // ADA KEMUNGKINAN KENA KEK
    else {
      // Navigator.pushNamed(context, '/diagnosis2');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Diagnosis2Screen(patient: widget.patient!)));
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.patient == null) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: specialAppbar(
      //     'Kajian', 'Kekurangan', widget.patient!.name.toString(), () {
      //   Navigator.pop(context);
      // }, 'Energi Kronik'),
      body: ListView(
        children: [
          header('Kajian', 'Kekurangan', '', () {
            Navigator.pop(context);
          }, 'Energi Kronik'),
          Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(children: [
                TextFormField(
                    controller: _txtWeight,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    maxLength: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon Isi Berat Badan Saat Ini';
                      }
                      return null;
                    },
                    decoration: SpecialInput('Berat Badan Saat ini')),
                TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon isi Lingkar Lengan Atas';
                      }
                      return null;
                    },
                    controller: _txtLILA,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    maxLength: 5,
                    decoration: SpecialInput('Ukuran Lingkar Lengan Atas')),
                // const SizedBox(height: 200),
              ]),
            ),
          ),
          BtnPrimary(
            'Selanjutnya',
            () {
              if (formKey.currentState!.validate()) {
                checkKek();
              }
              // Navigator.pushNamed(context, '/diagnosis2');
            },
          ),
        ],
      ),
    );
  }
}
