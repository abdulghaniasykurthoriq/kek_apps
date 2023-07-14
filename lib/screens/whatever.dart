import 'package:flutter/material.dart';
import 'package:kek_app/constant.dart';
// import 'package:kek_app/models/api_response.dart';
import 'package:kek_app/services/user_services.dart';
import 'package:kek_app/theme.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class WahatEver extends StatefulWidget {
  const WahatEver({Key? key}) : super(key: key);

  @override
  State<WahatEver> createState() => _WahatEverState();
}

class _WahatEverState extends State<WahatEver> {
  int totalPerawat = 0;
  int totalPatient = 0;
  int totalRiwayatPatient = 0;

  Future<void> getTotalPerawat() async {
    String token = await getToken();

    try {
      final response = await http.get(
        Uri.parse(totalUser),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      // print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        setState(() {
          totalPerawat = jsonResponse['total'];
        });
      } else {
        // print('Something went wrong');
      }
    } catch (e) {
      // print('Error: $e');
    }
  }

  Future<void> getTotalPatient() async {
    String token = await getToken();

    try {
      final response = await http.get(
        Uri.parse(totalPatientURL),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      // print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        setState(() {
          totalPatient = jsonResponse['total'];
        });
      } else {
        // print('Something went wrong');
      }
    } catch (e) {
      // print('Error: $e');
    }
  }

  Future<void> getTotalRiwayatPatient() async {
    String token = await getToken();

    try {
      final response = await http.get(
        Uri.parse(totalRiwayatPatientURL),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      // print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        setState(() {
          totalRiwayatPatient = jsonResponse['total'];
        });
      } else {
        // print('Something went wrong');
      }
    } catch (e) {
      // print('Error: $e');
    }
  }

  Widget cardPasienTerbaru() {
    return Container(
      height: 130,
      width: 130,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: redColor3,
        borderRadius: BorderRadius.circular(20),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 2,
        //     blurRadius: 5,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
      ),
      child: const Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('23'), Text('Pasien')],
      )),
    );
  }

  @override
  void initState() {
    getTotalPerawat();
    getTotalPatient();
    getTotalRiwayatPatient();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(defaultMargin),
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container(
                  width: 41,
                  height: 50,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/doctordoctor.png'))),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Perawat',
                      style: comfortaaBlueTextStyle.copyWith(fontWeight: bold),
                    ),
                    Text(
                      '$totalPerawat orang',
                      style: comfortaaBlueTextStyle,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  width: 41,
                  height: 50,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/doctordoctor.png'))),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Pasien',
                      style: comfortaaBlueTextStyle.copyWith(fontWeight: bold),
                    ),
                    Text(
                      '$totalPatient orang',
                      style: comfortaaBlueTextStyle,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  width: 41,
                  height: 50,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/doctordoctor.png'))),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Riwayat Pasien',
                      style: comfortaaBlueTextStyle.copyWith(fontWeight: bold),
                    ),
                    Text(
                      '$totalRiwayatPatient orang',
                      style: comfortaaBlueTextStyle,
                    )
                  ],
                )
              ],
            ),
          ]),
        )
      ],
    );
  }
}
