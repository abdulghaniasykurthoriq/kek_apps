import 'package:flutter/material.dart';
import 'package:kek_app/components/button_primary.dart';
import 'package:kek_app/components/header.dart';
import 'package:kek_app/components/input_special.dart';
import 'package:kek_app/models/diagnosis_provider.dart';
// import 'package:kek_app/components/special_appbar.dart';
import 'package:kek_app/models/patient.dart';
import 'package:flutter/services.dart';
import 'package:kek_app/screens/diagnosis/diagnosis4_screen.dart';
import 'package:kek_app/screens/implementation/additional_food_screen.dart';
import 'package:kek_app/theme.dart';
import 'package:provider/provider.dart';

class Diagnosis3Screen extends StatefulWidget {
  final Patient? patient;
  const Diagnosis3Screen({Key? key, this.patient}) : super(key: key);

  @override
  State<Diagnosis3Screen> createState() => _Diagnosis3ScreenState();
}

class _Diagnosis3ScreenState extends State<Diagnosis3Screen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _txtBeratIbuPadaTrimester =
      TextEditingController();

  void checkKek() {
    var diagnosisProvider =
        Provider.of<DiagnosisProvider>(context, listen: false);
    // print('halaman diagnosis 4');
    // print(diagnosisProvider.beratBadanSebelumHamil);
    // ANDA KENA KEK
    double beratPadaTrimester = double.parse(_txtBeratIbuPadaTrimester.text);

    diagnosisProvider.updateBeratBadanTrimesterHamil(beratPadaTrimester);
    if (beratPadaTrimester < 45) {
      // print('kekk');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AdditioanFoodScreen(
              status: 'kek',
              patient: widget.patient!,
              resultDiagnosis: 'Berat Pada Trimester III < 45')));
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('anda kena kek')));
    } else {
      // Navigator.pushNamed(context, '/diagnosis2');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Diagnosis4Screen(patient: widget.patient!)));
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
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(children: [
            header('Berat', 'Badan Ibu Pada', 'Trimester III', () {
              Navigator.pop(context);
            }, 'Kehamilan'),
            Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  children: [
                    TextFormField(
                        controller: _txtBeratIbuPadaTrimester,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        maxLength: 5,
                        validator: (val) {
                          if (val == "" || val == null) {
                            return "tidak boleh kosong";
                          }
                          return null;
                        },
                        decoration:
                            SpecialInput('Berat Badan Ibu Pada Trimester')),
                    // const SizedBox(height: 200),
                  ],
                ),
              ),
            ),
            BtnPrimary(
              'Selanjutnya',
              () {
                if (formKey.currentState!.validate()) {
                  checkKek();
                }
                // Navigator.pushNamed(context, '/diagnosis3');
              },
            ),
          ]),
          //   appBar: specialAppbar('Berat', 'badan ibu pada ', 'trimester III', () {
          //     Navigator.pop(context);
          //   }, 'kehamilan'),
          //   body: Column(
          //     children: [
          //       Expanded(
          //         child: Form(
          //           key: formKey,
          //           child: Padding(
          //             padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          //             child: Column(
          //               children: [
          //                 TextFormField(
          //                     controller: _txtBeratIbuPadaTrimester,
          //                     keyboardType: const TextInputType.numberWithOptions(
          //                         decimal: true),
          //                     inputFormatters: [
          //                       FilteringTextInputFormatter.allow(
          //                           RegExp(r'^\d+\.?\d{0,2}')),
          //                     ],
          //                     maxLength: 5,
          //                     validator: (val) {
          //                       if (val == "" || val == null) {
          //                         return "tidak boleh kosong";
          //                       }
          //                       return null;
          //                     },
          //                     decoration: SpecialInput('Berat Badan')),
          //                 // const SizedBox(height: 200),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //       BtnPrimary(
          //         'Selanjutnya',
          //         () {
          //           if (formKey.currentState!.validate()) {
          //             checkKek();
          //           }
          //           // Navigator.pushNamed(context, '/diagnosis4');
          //         },
          //       ),
          //     ],
          //   ),
          // )
          // ,
        ));
  }
}
