import 'package:flutter/material.dart';
import 'package:kek_app/components/button_primary.dart';
import 'package:kek_app/components/input_special.dart';
import 'package:kek_app/components/special_appbar.dart';
import 'package:kek_app/models/api_response.dart';
import 'package:kek_app/models/patient.dart';
import 'package:kek_app/services/riwayat_patient_service.dart';
// import 'package:kek_app/pages/home_screen.dart';
import 'package:kek_app/theme.dart';

class HealthyFoodScreen extends StatefulWidget {
  final Patient? patient;
  final String? resultDiagnosis;
  final String? additionalFood;
  final String? status;

  const HealthyFoodScreen(
      {Key? key,
      this.patient,
      this.status,
      this.resultDiagnosis,
      this.additionalFood})
      : super(key: key);

  @override
  State<HealthyFoodScreen> createState() => _HealthyFoodScreenState();
}

class _HealthyFoodScreenState extends State<HealthyFoodScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtHealthyFood = TextEditingController();

  void _pushRiwayatPasient() async {
    // createRiwayatPasient(status, patientId, resultDiagnosis, additionalFood, healthyFood)
    // print(widget.status.toString());
    // print(widget.patient!.id!.toInt());
    // print(widget.resultDiagnosis.toString());
    // print(widget.additionalFood.toString());
    // print(_txtHealthyFood.text);

    ApiResponse response = await createRiwayatPasient(
        widget.status.toString(),
        widget.patient!.id!.toInt(),
        widget.resultDiagnosis.toString(),
        widget.additionalFood.toString(),
        _txtHealthyFood.text);
    if (response.error == null) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  // const AdditioanFoodScreen({Key? key, this.patient, this.resultDiagnosis})
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: specialAppbar('Makanan', 'Sehat', 'Pasien', () {
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mohon Isi Makanan Sehat';
                          }
                          return null;
                        },
                        controller: _txtHealthyFood,
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
                  _pushRiwayatPasient();
                  // Navigator.pushNamed(context, '/healthy-food');
                }
                // Navigator.pushNamedAndRemoveUntil(
                //     context, '/home', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
