import 'package:flutter/material.dart';
import 'package:kek_app/components/button_primary.dart';
import 'package:kek_app/components/input_special.dart';
import 'package:kek_app/components/special_appbar.dart';
import 'package:kek_app/models/patient.dart';
import 'package:kek_app/screens/implementation/healthy_food_screen.dart';
// import 'package:kek_app/pages/home_screen.dart';
import 'package:kek_app/theme.dart';

class AdditioanFoodScreen extends StatefulWidget {
  // const Diagnosis1Screen({Key? key, this.patient}) : super(key: key);
  final Patient? patient;
  final String? resultDiagnosis;
  final String? status;

  const AdditioanFoodScreen(
      {Key? key, this.patient, this.status, this.resultDiagnosis})
      : super(key: key);

  @override
  State<AdditioanFoodScreen> createState() => _AdditioanFoodScreenState();
}

class _AdditioanFoodScreenState extends State<AdditioanFoodScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtAdditionalFood = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: specialAppbar('Makanan', 'Tambahan', 'Pasien', () {
          Navigator.pop(context);
        }, ''),
        body: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Column(children: [
                    TextFormField(
                        controller: _txtAdditionalFood,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mohon Isi Tambahan Makanan';
                          }
                          return null;
                        },
                        decoration: SpecialInput('Makanan Tambahan')),
                    // const SizedBox(height: 200),
                  ]),
                ),
              ),
            ),
            BtnPrimary(
              'Selanjutnya',
              () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HealthyFoodScreen(
                          patient: widget.patient,
                          resultDiagnosis: widget.resultDiagnosis,
                          status: widget.status,
                          additionalFood: _txtAdditionalFood.text)));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
