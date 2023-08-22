import 'package:flutter/material.dart';
import 'package:kek_app/components/button_primary.dart';
import 'package:kek_app/components/input_special.dart';
import 'package:kek_app/components/special_appbar.dart';
import 'package:kek_app/models/api_response.dart';
import 'package:kek_app/models/diagnosis_provider.dart';
import 'package:kek_app/models/patient.dart';
import 'package:kek_app/screens/implementation/healthy_food_screen.dart';
import 'package:kek_app/services/riwayat_patient_service.dart';
// import 'package:kek_app/pages/home_screen.dart';
import 'package:kek_app/theme.dart';
import 'package:provider/provider.dart';

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

  void _pushRiwayatPasient() async {
    // print(_txtAdditionalFood.text);
    // createRiwayatPasient(status, patientId, resultDiagnosis, additionalFood, healthyFood)
    // print(widget.status.toString());
    // print(widget.patient!.id!.toInt());
    // print(widget.resultDiagnosis.toString());
    // print(widget.additionalFood.toString());
    // print(_txtHealthyFood.text);
    // print('gatau kenapasss');
    // print(context.read<DiagnosisProvider>().beratBadanSebelumHamil.toDouble());
    ApiResponse response = await createRiwayatPasient(
        widget.status.toString(),
        widget.patient!.id.toInt(),
        context.read<DiagnosisProvider>().gravida.toInt(),
        context.read<DiagnosisProvider>().para.toInt(),
        context.read<DiagnosisProvider>().abortus.toInt(),
        context.read<DiagnosisProvider>().tinggiBadan.toDouble(),
        context.read<DiagnosisProvider>().ukuranLila.toDouble(),
        context.read<DiagnosisProvider>().beratBadanSebelumHamil.toDouble(),
        context.read<DiagnosisProvider>().indeksMasaTubuh.toDouble(),
        context.read<DiagnosisProvider>().beratBadanTrimesterHamil.toDouble(),
        context.read<DiagnosisProvider>().kadarHemoglobin.toDouble(),
        widget.resultDiagnosis.toString(),
        _txtAdditionalFood.text.toString()
        // _txtHealthyFood.text
        );
// ignore: use_build_context_synchronously
    context.read<DiagnosisProvider>().updateTingginBadan(0);
    // ignore: use_build_context_synchronously
    context.read<DiagnosisProvider>().updateUkuranLila(0);
    // ignore: use_build_context_synchronously
    context.read<DiagnosisProvider>().updateIndeksMasaTubuh(0);
    // ignore: use_build_context_synchronously
    context.read<DiagnosisProvider>().updateBeratBadanSebelumHamil(0);
    // ignore: use_build_context_synchronously
    context.read<DiagnosisProvider>().updateBeratBadanTrimesterHamil(0);
    // ignore: use_build_context_synchronously
    context.read<DiagnosisProvider>().updateKadarHemoglobin(0);

    // ignore: use_build_context_synchronously
    context.read<DiagnosisProvider>().updateGravida(0);
    // ignore: use_build_context_synchronously
    context.read<DiagnosisProvider>().updatePara(0);
    // ignore: use_build_context_synchronously
    context.read<DiagnosisProvider>().updateAbortus(0);
    if (response.error == null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const HealthyFoodScreen()));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.resultDiagnosis);
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
                  _pushRiwayatPasient();
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => HealthyFoodScreen(
                  //         patient: widget.patient,
                  //         resultDiagnosis: widget.resultDiagnosis,
                  //         status: widget.status,
                  //         additionalFood: _txtAdditionalFood.text)));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
