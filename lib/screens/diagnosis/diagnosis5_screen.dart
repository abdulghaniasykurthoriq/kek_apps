import 'package:flutter/material.dart';
import 'package:kek_app/components/button_secondary.dart';
import 'package:kek_app/components/special_appbar.dart';
import 'package:kek_app/models/patient.dart';
import 'package:kek_app/screens/implementation/additional_food_screen.dart';
// import 'package:kek_app/screens/implementation/healthy_food_screen.dart';
// import 'package:kek_app/pages/home_screen.dart';
import 'package:kek_app/theme.dart';

class Diagnosis5Screen extends StatefulWidget {
  final Patient? patient;
  const Diagnosis5Screen({Key? key, this.patient}) : super(key: key);

  @override
  State<Diagnosis5Screen> createState() => _Diagnosis5ScreenState();
}

class _Diagnosis5ScreenState extends State<Diagnosis5Screen> {
  void patientIsKeK() {
    // ANDA KENA KEK
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AdditioanFoodScreen(
            status: 'kek',
            patient: widget.patient!,
            resultDiagnosis: 'Terlihat Letih Lesuh Lunglai')));
  }

  void patientIsNormal() {
    // ANDA TIDAK KENA KEK
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AdditioanFoodScreen(
            status: 'normal',
            patient: widget.patient!,
            resultDiagnosis: 'normal')));
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
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: specialAppbar('Terlihat', 'Letih Lesuh', 'Lunglai?', () {
        Navigator.pop(context);
      }, ''),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                Row(
                  children: [
                    BtnCustom('Ya', () {
                      patientIsKeK();
                    }, blueColor2),
                    BtnCustom('Tidak', () {
                      patientIsNormal();
                    }, redColor)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
