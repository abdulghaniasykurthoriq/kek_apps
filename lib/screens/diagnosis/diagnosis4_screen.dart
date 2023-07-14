import 'package:flutter/material.dart';
import 'package:kek_app/components/button_primary.dart';
import 'package:kek_app/components/input_special.dart';
import 'package:kek_app/components/special_appbar.dart';
import 'package:kek_app/models/patient.dart';
import 'package:kek_app/screens/diagnosis/diagnosis5_screen.dart';
import 'package:kek_app/screens/implementation/additional_food_screen.dart';
import 'package:flutter/services.dart';

import 'package:kek_app/theme.dart';

class Diagnosis4Screen extends StatefulWidget {
  final Patient? patient;
  const Diagnosis4Screen({Key? key, this.patient}) : super(key: key);

  @override
  State<Diagnosis4Screen> createState() => _Diagnosis4ScreenState();
}

class _Diagnosis4ScreenState extends State<Diagnosis4Screen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _txtKadarHemoglobin = TextEditingController();
  void checkKek() {
    // ANDA KENA KEK
    double kadarHemoglobin = double.parse(_txtKadarHemoglobin.text);
    if (kadarHemoglobin < 11) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AdditioanFoodScreen(
              status: 'kek',
              patient: widget.patient!,
              resultDiagnosis: 'Kadar HB di bawah 11 gram %')));
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('anda kena kek')));
    } else {
      // Navigator.pushNamed(context, '/diagnosis2');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Diagnosis5Screen(patient: widget.patient!)));
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
        appBar: specialAppbar('Kadar', 'Hemoglobin', 'Ibu?', () {
          Navigator.pop(context);
        }, ''),
        body: Column(
          children: [
            Expanded(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Column(
                    children: [
                      TextFormField(
                          controller: _txtKadarHemoglobin,
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
                          decoration: SpecialInput('Kadar HB ibu dalam gram')),
                      // const SizedBox(height: 200),
                    ],
                  ),
                ),
              ),
            ),
            BtnPrimary(
              'Selanjutnya',
              () {
                if (formKey.currentState!.validate()) {
                  checkKek();
                }
                // Navigator.pushNamed(context, '/diagnosis5');
              },
            ),
          ],
        ),
      ),
    );
  }
}
