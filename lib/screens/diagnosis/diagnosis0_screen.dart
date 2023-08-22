import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:http/http.dart';
import 'package:kek_app/components/button_primary.dart';
import 'package:kek_app/components/header.dart';
import 'package:kek_app/components/input_special.dart';
import 'package:kek_app/models/diagnosis_provider.dart';
// import 'package:kek_app/components/special_appbar.dart';
import 'package:kek_app/models/patient.dart';
import 'package:kek_app/screens/diagnosis/diagnosis1_screen.dart';
// import 'package:kek_app/screens/diagnosis/diagnosis2_screen.dart';
// import 'package:kek_app/screens/implementation/additional_food_screen.dart';
import 'package:kek_app/theme.dart';
import 'package:provider/provider.dart';

class Diagnosis0 extends StatefulWidget {
  // final RiwayatPatient? riwayatPatient;
  final Patient? patient;
  const Diagnosis0({Key? key, this.patient}) : super(key: key);

  @override
  State<Diagnosis0> createState() => _Diagnosis0State();
}

class _Diagnosis0State extends State<Diagnosis0> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController txt1 = TextEditingController();
  final TextEditingController txt2 = TextEditingController();
  final TextEditingController txt3 = TextEditingController();

  void checkKek() {
    var diagnosisProvider =
        Provider.of<DiagnosisProvider>(context, listen: false);

    diagnosisProvider.updateGravida(int.parse(txt1.text));
    diagnosisProvider.updatePara(int.parse(txt2.text));
    diagnosisProvider.updateAbortus(int.parse(txt3.text));

    // double lila = double.parse(txt2.text);
    // double height = double.parse(txt1.text);
    // diagnosisProvider.updateTingginBadan(height);
    // diagnosisProvider.updateUkuranLila(lila);

    // ANDA KENA KEK

    // Navigator.pushNamed(context, '/diagnosis2');
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Diagnosis1Screen(patient: widget.patient!)));
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
          header('Status', 'Kehamilan', '', () {
            Navigator.pop(context);
          }, 'Pasien'),
          Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(children: [
                TextFormField(
                    controller: txt1,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter
                          .digitsOnly, // Hanya menerima digit (angka)
                    ],
                    maxLength: 2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon Isi Gravida';
                      }
                      return null;
                    },
                    decoration: SpecialInput('Gravida')),
                TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon Isi Para';
                      }
                      return null;
                    },
                    controller: txt2,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter
                          .digitsOnly, // Hanya menerima digit (angka)
                    ],
                    maxLength: 2,
                    decoration: SpecialInput('Para')),
                TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon Isi Abortus';
                      }
                      return null;
                    },
                    controller: txt3,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter
                          .digitsOnly, // Hanya menerima digit (angka)
                    ],
                    maxLength: 2,
                    decoration: SpecialInput('Abortus')),
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
