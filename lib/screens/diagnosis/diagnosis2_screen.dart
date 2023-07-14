import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kek_app/components/button_primary.dart';
import 'package:kek_app/components/header.dart';
import 'package:kek_app/components/input_special.dart';
import 'package:kek_app/models/patient.dart';
import 'package:kek_app/screens/diagnosis/diagnosis3_screen.dart';
import 'package:kek_app/screens/implementation/additional_food_screen.dart';
// import 'package:kek_app/pages/home_screen.dart';
import 'package:kek_app/theme.dart';

class Diagnosis2Screen extends StatefulWidget {
  final Patient? patient;
  const Diagnosis2Screen({Key? key, this.patient}) : super(key: key);

  @override
  State<Diagnosis2Screen> createState() => _Diagnosis2ScreenState();
}

class _Diagnosis2ScreenState extends State<Diagnosis2Screen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _txtBeratIbuSebelumHamil =
      TextEditingController();
  void checkKek() {
    // ANDA KENA KEK
    double beratSebelumHamil = double.parse(_txtBeratIbuSebelumHamil.text);
    // double weightInKilo = beratSebelumHamil * beratSebelumHamil;
    double heightPatient = double.parse(widget.patient!.tinggiBadan.toString());
    double heightPatientInMeter = heightPatient / 100;
    double heightPatientInMeterQuadrat =
        heightPatientInMeter * heightPatientInMeter;
    double indeksMasaTubuh = beratSebelumHamil / heightPatientInMeterQuadrat;

    if (beratSebelumHamil < 42) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AdditioanFoodScreen(
              status: 'kek',
              patient: widget.patient!,
              resultDiagnosis: 'Berat Sebelum Hamil < 42')));
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('anda kena kek')));
    } else if (indeksMasaTubuh < 17.00) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AdditioanFoodScreen(
              status: 'kek',
              patient: widget.patient!,
              resultDiagnosis: 'Index Masa Tubuh < 17.00')));
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('anda kena kek')));
    }
    // ADA KEMUNGKINAN KENA KEK
    else {
      // Navigator.pushNamed(context, '/diagnosis2');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Diagnosis3Screen(patient: widget.patient!)));
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
          header('Berat', 'Badan Ibu', 'Hamil?', () {
            Navigator.pop(context);
          }, 'Sebelum'),
          Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                children: [
                  TextFormField(
                      controller: _txtBeratIbuSebelumHamil,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
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
                          SpecialInput('Berat Badan Ibu Sebelum Hamil')),
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
        // appBar: specialAppbar('Berat', 'Badan Ibu', 'Hamil?', () {
        //   Navigator.pop(context);
        // }, 'Sebeleum'),
        // body: Column(
        //   children: [
        //     Expanded(
        //       child: Form(
        //         key: formKey,
        //         child: Padding(
        //           padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        //           child: Column(
        //             children: [
        //               TextFormField(
        //                   controller: _txtBeratIbuSebelumHamil,
        //                   keyboardType: const TextInputType.numberWithOptions(
        //                       decimal: true),
        //                   inputFormatters: [
        //                     FilteringTextInputFormatter.allow(
        //                         RegExp(r'^\d+\.?\d{0,2}')),
        //                   ],
        //                   maxLength: 5,
        //                   validator: (val) {
        //                     if (val == "" || val == null) {
        //                       return "tidak boleh kosong";
        //                     }
        //                     return null;
        //                   },
        //                   decoration:
        //                       SpecialInput('Berat Badan Ibu Sebelum Hamil')),
        //               // const SizedBox(height: 200),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //     BtnPrimary(
        //       'Selanjutnya',
        //       () {
        //         if (formKey.currentState!.validate()) {
        //           checkKek();
        //         }
        //         // Navigator.pushNamed(context, '/diagnosis3');
        //       },
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
