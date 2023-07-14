// import 'dart:typed_data';

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kek_app/components/button_primary.dart';
import 'package:kek_app/models/riwayat_patient.dart';
import 'package:kek_app/utils/count_age.dart';
import 'package:kek_app/utils/pascal_case.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// import 'package:pdf/widgets.dart' as pw;
import 'package:kek_app/theme.dart';

import '../../utils/format_date.dart';

class DetailRiwayat extends StatefulWidget {
  final RiwayatPatient? riwayat;
  const DetailRiwayat({Key? key, this.riwayat}) : super(key: key);

  @override
  State<DetailRiwayat> createState() => _DetailRiwayatState();
}

@override
class _DetailRiwayatState extends State<DetailRiwayat> {
  int _currentIndex = 0;
  final int nowYear = DateTime.now().year;
  int patientAge = 0;
  void getPdf() async {
    // print(countAge(widget.riwayat!.patient.tanggalLahir.toString()));
    final pdf = pw.Document();
    String tanggalLahir = widget.riwayat!.patient.tanggalLahir.toString();
    List<String> tanggalLahirSplit = tanggalLahir.split("-");

    if (tanggalLahirSplit.length >= 3) {
      String tahun = tanggalLahirSplit[0];
      // print(tahun);
      setState(() {
        patientAge = nowYear - int.parse(tahun);
      });
      // Gunakan variabel tahun, bulan, dan hari sesuai kebutuhan
    }

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                    child: pw.Text(
                  'LAPORAN PEMERIKSAAN KEKURANGAN ENERGI KRONIK',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                )),
                pw.SizedBox(height: 30),
                pw.Text(
                  'BIODATA PASIEN',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Row(children: [
                  pw.Container(width: 100, child: pw.Text('Nama')),
                  pw.Text(':  ${widget.riwayat!.patient.name.toString()}')
                ]),
                pw.Row(children: [
                  pw.Container(width: 100, child: pw.Text('Status')),
                  pw.Text(':  ${widget.riwayat!.status.toString()}')
                ]),
                pw.Row(children: [
                  pw.Container(width: 100, child: pw.Text('Umur')),
                  pw.Text(
                      ':  ${countAge(widget.riwayat!.patient.tanggalLahir.toString())} tahun')
                ]),
                pw.Row(children: [
                  pw.Container(width: 100, child: pw.Text('Alamat')),
                  pw.Text(':  ${widget.riwayat!.patient.alamat.toString()}')
                ]),
                pw.Row(children: [
                  pw.Container(width: 100, child: pw.Text('Tanggal')),
                  pw.Text(
                      ':  ${formatDate(widget.riwayat!.createdAt.toString())}')
                ]),
                pw.Row(children: [
                  pw.Container(width: 100, child: pw.Text('dicek oleh')),
                  pw.Text(':  ${widget.riwayat!.createdBy.name.toString()}')
                ]),
                pw.SizedBox(height: 30),
                pw.Text(
                  'Makanan Tambahan',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  children: [
                    pw.SizedBox(width: 50),
                    pw.Text('-'),
                    ...widget.riwayat!.additionalFood
                        .map((e) => pw.Text(' ${e.food.toString()}'))
                        .toList(),
                    // pw.Text('-  Sering makan yang enak tambhn')
                  ],
                ),
                pw.SizedBox(height: 30),
                pw.Text(
                  'Saran Makanan Sehat',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  children: [
                    pw.SizedBox(width: 50),
                    pw.Text('-'),
                    ...widget.riwayat!.healthyFood
                        .map((e) => pw.Text(' ${e.food.toString()}'))
                        .toList(),
                    // pw.Text('-  Sering makan yang enak tambhn')
                  ],
                ),
                pw.SizedBox(height: 30),
                pw.Text(
                  'Evaluasi',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Row(children: [pw.SizedBox(width: 50), pw.Text('-')]),
              ]); // Center
        })); // Page

    // simpan
    Uint8List bytes = await pdf.save();

    // buat file kosong di direktori
    final dir = await getApplicationDocumentsDirectory();
    final file =
        File('${dir.path}/${toPascalCase(widget.riwayat!.patient.name)}.pdf');

    // timpa file kosong dengan file pdf
    await file.writeAsBytes(bytes);

    //open file
    await OpenFile.open(file.path);
  }

  Widget showMakananOrEvaluasi() {
    return Row(
      children: [
        Expanded(
            child: GestureDetector(
          onTap: () {
            setState(() {
              _currentIndex = 0;
            });
          },
          child: Container(
            height: 35,
            margin: const EdgeInsets.only(left: 10, right: 5),
            decoration: BoxDecoration(
                color:
                    _currentIndex == 0 ? blueColor3 : const Color(0xffe7e7e7),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: Text(
              'Makanan',
              style: popinsWhiteTextStyle,
            )),
          ),
        )),
        Expanded(
            child: GestureDetector(
          onTap: () {
            setState(() {
              _currentIndex = 1;
            });
          },
          child: Container(
            height: 35,
            margin: const EdgeInsets.only(left: 5, right: 10),
            decoration: BoxDecoration(
                color:
                    _currentIndex == 1 ? blueColor3 : const Color(0xffe7e7e7),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: Text(
              'Evaluasi',
              style: popinsWhiteTextStyle,
            )),
          ),
        )),
      ],
    );
  }

  Widget valueMakananOrEvaluasi() {
    switch (_currentIndex) {
      case 0:
        // ignore: avoid_unnecessary_containers
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Makanan Tambahan',
                style: popinsBlackTextStyle.copyWith(fontWeight: bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  children: widget.riwayat!.additionalFood
                      .map((additionalFood) =>
                          Text(additionalFood.food.toString()))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Makanan Sehat',
                style: popinsBlackTextStyle.copyWith(fontWeight: bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, bottom: 40),
                child: Column(
                  children: widget.riwayat!.healthyFood
                      .map((healthyFood) => Text(healthyFood.food.toString()))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      default:
        // ignore: avoid_unnecessary_containers
        return Container(
          child: const Column(
            children: [Text("-")],
          ),
        );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.riwayat == null) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Detail Riwayat'),
                SizedBox(
                  width: 50,
                )
              ],
            ),
          ),
          backgroundColor: blueColor3,
          automaticallyImplyLeading: true),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  height: 200,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/riwayat_doctor_blue.png'))),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                toPascalCase(
                                    widget.riwayat!.patient.name.toString()),
                                style: popinsBlackTextStyle.copyWith(
                                    fontWeight: bold),
                              ),
                              Text(
                                toPascalCase(
                                    widget.riwayat!.patient.alamat.toString()),
                                style:
                                    popinsGreykTextStyle.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          // Image.asset('assets/femenine.png'),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: redColor)),
                            child: Text(
                              widget.riwayat!.status.toString(),
                              style: comfortaaRedTextStyle.copyWith(
                                  fontWeight: bold),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xffe7e7e7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: showMakananOrEvaluasi()),
                      const SizedBox(
                        height: 30,
                      ),
                      // Expanded(
                      //   child: Container(
                      //     color: Colors.white,
                      //   ),
                      // ),
                      valueMakananOrEvaluasi(),
                      Center(
                        child: BtnPrimary('EXPORT PDF', () {
                          // downloadRiwayatPatientPdf();
                          // main();
                          getPdf();
                        }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
