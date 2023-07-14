import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kek_app/components/button_primary.dart';
import 'package:kek_app/components/input_special.dart';
import 'package:kek_app/components/special_appbar.dart';
import 'package:kek_app/constant.dart';
import 'package:kek_app/models/api_response.dart';
import 'package:kek_app/models/patient.dart';
import 'package:kek_app/services/patient_services.dart';
import 'package:kek_app/services/user_services.dart';
import 'package:kek_app/theme.dart';
import 'package:intl/intl.dart';

class CreatePatientScreen extends StatefulWidget {
  final Patient? patient;
  final String? title;
  const CreatePatientScreen({super.key, this.patient, this.title});

  @override
  State<CreatePatientScreen> createState() => _CreatePatientScreenState();
}

class _CreatePatientScreenState extends State<CreatePatientScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtName = TextEditingController();
  final TextEditingController _txtAlamat = TextEditingController();
  final TextEditingController _txtTinggiBadan = TextEditingController();
  bool isLoading = false;
  String _dateTime = "";

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime(2030),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime = value.toString().split(' ')[0]; // Mengambil tanggal saja
        });
      }
    });
  }

  void _createPost() async {
    setState(() {
      isLoading = true;
    });
    if (_dateTime == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mohon masukan tanggal lahir')));
    } else {
      DateTime dateTime = DateFormat('yyyy-MM-dd').parse(_dateTime);
      ApiResponse response = await createPatient(
        _txtName.text.toLowerCase(),
        _txtAlamat.text.toLowerCase(),
        int.parse(_txtTinggiBadan.text),
        dateTime,
      );

      if (response.error == null) {
        // print('berhasil');
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      } else if (response.error == unauthorized) {
        // print('login dulu');
        logout().then((value) => {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/sign-in',
                (route) => false,
              )
            });
      } else {
        // print('something');
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}')));
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  void _editPost(int patientId) async {
    setState(() {
      isLoading = true;
    });
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(_dateTime);

    ApiResponse response = await editPatient(
      patientId,
      _txtName.text,
      _txtAlamat.text,
      int.parse(_txtTinggiBadan.text),
      dateTime,
    );
    if (response.error == null) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.pushNamedAndRemoveUntil(
                context, '/sign-in', (route) => false)
          });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.patient != null) {
      _txtName.text = widget.patient!.name ?? '';
      _txtAlamat.text = widget.patient!.alamat ?? '';
      _txtTinggiBadan.text = widget.patient!.tinggiBadan.toString();
      _dateTime = widget.patient!.tanggalLahir.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Text isPickDate() {
      switch (_dateTime) {
        case "":
          return const Text("Tanggal Lahir");
        default:
          return Text(_dateTime);
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: specialAppbar(
            widget.patient != null ? 'Edit' : 'Buat',
            widget.patient != null ? 'Data' : 'Pasien',
            widget.patient != null ? 'Pasien' : 'Baru', () {
          Navigator.pop(context);
        }, ''),
        body: ListView(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _txtName,
                      decoration: SpecialInput('Nama Lengkap'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon isi Nama Lengkap';
                        } else if (value.length > 30) {
                          return 'Nama Tidak boleh lebih 30';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _txtAlamat,
                      decoration: SpecialInput('Alamat'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon isi Alamat';
                        } else if (value.length > 30) {
                          return 'alamat Tidak boleh lebih 30';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _txtTinggiBadan,
                      decoration: SpecialInput('Tinggi Badan'),
                      keyboardType:
                          TextInputType.number, // Set keyboard type to number
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ], // Allow only digits
                      maxLength: 3,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon isi Tinggi Badan';
                        } else if (value.length == 1 || value.length > 3) {
                          return 'Mohon masukan tinggi badan yg benar';
                        }
                        return null;
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        _showDatePicker();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isPickDate(),
                            const Icon(Icons.calendar_month),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    isLoading
                        ? BtnPrimary('Loading.....', () {})
                        : BtnPrimary(
                            widget.patient != null
                                ? 'EDIT PASIEN'
                                : 'BUAT PASIEN BARU',
                            () {
                              if (_formKey.currentState!.validate()) {
                                if (widget.patient == null) {
                                  _createPost();
                                } else {
                                  _editPost(widget.patient!.id ?? 0);
                                }
                              }
                            },
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
