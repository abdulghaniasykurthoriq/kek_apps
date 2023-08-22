import 'package:flutter/material.dart';
import 'package:kek_app/constant.dart';
import 'package:kek_app/models/api_response.dart';
import 'package:kek_app/models/riwayat_patient.dart';
import 'package:kek_app/screens/patients/detail_riwayat_patient.dart';
import 'package:kek_app/services/riwayat_patient_service.dart';
import 'package:kek_app/services/user_services.dart';
// import 'package:kek_app/screens/riwayat_screen.dart';
import 'package:kek_app/theme.dart';
import 'package:kek_app/utils/format_date.dart';
import 'package:kek_app/utils/pascal_case.dart';
import 'package:kek_app/utils/truncate_string.dart';
// import 'package:kek_app/screens/riwayat_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int userId = 0;
  bool _loading = true;
  List<dynamic> riwayatList = [];

  Future<void> retrievePatients() async {
    userId = await getUserId();
    ApiResponse response = await retrieveRiwayatMyPatients();

    if (mounted) {
      if (response.error == null) {
        setState(() {
          riwayatList = response.data as List<dynamic>;
          _loading = _loading ? !_loading : _loading;
        });
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
    }
    // print(riwayatList);
  }

  @override
  void initState() {
    retrievePatients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget listMenuPerawat() {
      return Container(
        height: 150,
        padding: const EdgeInsets.only(left: 30),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/create-patients');
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 105,
                decoration: BoxDecoration(
                  color: blueColor2,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(height: defaultMargin),
                    Image.asset('assets/icon_new_pasien.png'),
                    const SizedBox(height: 20),
                    Text(
                      'Pasien',
                      style: popinsWhiteTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Baru',
                      style: popinsWhiteTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/patients');
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 105,
                decoration: BoxDecoration(
                  color: redColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(height: defaultMargin),
                    Image.asset('assets/icon_love_pasien.png'),
                    const SizedBox(height: 20),
                    Text(
                      'Kajian',
                      style: popinsWhiteTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Pasien',
                      style: popinsWhiteTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/riwayat');
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 105,
                decoration: BoxDecoration(
                  color: purpleColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Image.asset('assets/icon_history_pasien.png'),
                    const SizedBox(height: 18),
                    Text(
                      'Riwayat',
                      style: popinsWhiteTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Pasien',
                      style: popinsWhiteTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget cardPasienTerbaru(RiwayatPatient item) {
      return Container(
        height: 105,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: redColor2,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset('assets/cewe.png'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  truncateString(toPascalCase(item.patient.name), 15),
                  style: comfortaaBlueTextStyle.copyWith(
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  truncateString(item.patient.alamat, 15),
                  style: comfortaaBlueTextStyle,
                ),
                const SizedBox(height: 10),
                Text(
                  formatDate(item.createdAt.toString()),
                  style: comfortaaSubtitleTextStyle,
                ),
              ],
            ),
          ],
        ),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Ayo',
                    style: redTextStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Tangani Pasien',
                    style: blueTextStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                'Sekarang',
                style: blueTextStyle.copyWith(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/patients');
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            padding: const EdgeInsets.only(left: 20),
            height: 45,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Image.asset('assets/icon_search.png'),
                const SizedBox(width: 10),
                const Expanded(
                  child:
                      Text('Search ...', style: TextStyle(color: Colors.grey)),
                ),
                Container(
                  height: 45,
                  width: 60,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_right,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Text(
            'Menu Perawat',
            style: blueTextStyle.copyWith(fontSize: 16),
          ),
        ),
        listMenuPerawat(),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Text(
            'Riwayat Pasien anda',
            style: blueTextStyle.copyWith(fontSize: 16),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: riwayatList.map((item) {
              return GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, '/detail');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailRiwayat(
                            riwayat: item,
                          )));
                },
                child: cardPasienTerbaru(item),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
