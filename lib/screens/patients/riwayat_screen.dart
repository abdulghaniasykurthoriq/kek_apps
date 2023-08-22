import 'package:flutter/material.dart';
import 'package:kek_app/constant.dart';
import 'package:kek_app/models/api_response.dart';
import 'package:kek_app/models/auth_provider.dart';
import 'package:kek_app/models/riwayat_patient.dart';
import 'package:kek_app/screens/patients/detail_riwayat_patient.dart';
import 'package:kek_app/services/riwayat_patient_service.dart';
import 'package:kek_app/services/user_services.dart';
import 'package:kek_app/theme.dart';
import 'package:kek_app/utils/format_date.dart';
import 'package:kek_app/utils/pascal_case.dart';
import 'package:kek_app/utils/truncate_string.dart';
import 'package:provider/provider.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({Key? key}) : super(key: key);

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  final scrollControler = ScrollController();
  int userId = 0;
  bool _loading = true;
  bool _loadMore = false;
  List<dynamic> riwayatList = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _txtSearch = TextEditingController();
  int page = 1;
  late int lastPage;

  Future<void> retrievePatients() async {
    userId = await getUserId();
    ApiResponse response = await retrieveRiwayatPatients(_txtSearch.text, page);

    if (response.error == null) {
      // print(response.currentPage);
      if (mounted) {
        setState(() {
          lastPage = response.lastPage ?? response.lastPage!;
          riwayatList = [...riwayatList, ...response.data as List<dynamic>];
          // _loading = _loading ? !_loading : _loading;
          _loading = false;
        });
      }
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
    // print(riwayatList);
  }

  void _deleteRiwayatPatient(int id) async {
    ApiResponse response = await deleteRiwayatPatient(id);
    if (response.error == null) {
      setState(() {
        riwayatList = [];
      });
      retrievePatients();
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

  @override
  void initState() {
    retrievePatients();
    scrollControler.addListener(_scrollListener);
    super.initState();
  }

  void filter() {
    setState(() {
      riwayatList = [];
      page = 1;
      lastPage = 1;
    });
    retrievePatients();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    // if (!mounted) return const SizedBox();

    PreferredSize appBar() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 140,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: defaultMargin),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  // color: const Color(0xffF9FAFF),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(Icons.arrow_back, color: blueColor),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Daftar',
                                      style: redTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'Riwayat',
                                      style: blueTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Pasien',
                                  style: blueTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: ClipOval(
                          child: Consumer<AuthProvider>(
                            builder: (context, authProvider, _) {
                              String imageUrl = authProvider.urlPhotoUser;
                              // print(imageUrl);
                              return Image.asset(
                                imageUrl,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
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
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            validator: (val) {
                              if (val == "" || val == null) {
                                return "tidak boleh kosong";
                              }
                              return null;
                            },
                            controller: _txtSearch,
                            decoration: const InputDecoration(
                              // labelText: 'Name',
                              hintText: 'Search . . .',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: Container(
                            height: 45,
                            width: 60,
                            decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                )),
                            child: const Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget cardPasien(RiwayatPatient riwayatPatient) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: redColor3, borderRadius: BorderRadius.circular(25)),
              child: Image.asset(
                'assets/cewe_riwayat.png',
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  truncateString(toPascalCase(riwayatPatient.patient.name), 17),
                  style: comfortaaBlueTextStyle.copyWith(fontWeight: bold),
                ),
                Text(
                  truncateString(riwayatPatient.patient.alamat.toString(), 15),
                  style: comfortaaBlueTextStyle.copyWith(fontSize: 12),
                )
              ],
            ),
            const Expanded(child: SizedBox()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                riwayatPatient.createdBy.id == userId
                    ? PopupMenuButton(
                        child: const Padding(
                            padding: EdgeInsets.only(bottom: 1),
                            child: Icon(
                              Icons.more_horiz,
                            )),
                        onSelected: (val) {
                          if (val == 'hapus') {
                            _deleteRiwayatPatient(riwayatPatient.id);
                          }
                        },
                        itemBuilder: (context) => [
                              const PopupMenuItem(
                                  value: 'hapus', child: Text('Hapus'))
                            ])
                    : const SizedBox(),
                Text(
                  formatDate(riwayatPatient.createdAt.toString()),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: appBar(),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                semiGray,
              ],
              stops: const [0.3, 0.7],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: _loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  controller: scrollControler,
                  itemCount:
                      _loadMore ? riwayatList.length + 1 : riwayatList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < riwayatList.length) {
                      RiwayatPatient riwayatPatient = riwayatList[index];

                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailRiwayat(
                                      riwayat: riwayatPatient,
                                    )));
                          },
                          behavior: HitTestBehavior.translucent,
                          child: cardPasien(riwayatPatient));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  })),
    );
  }

  Future<void> _scrollListener() async {
    if (scrollControler.position.pixels ==
        scrollControler.position.maxScrollExtent) {
      if (page < lastPage) {
        setState(() {
          _loadMore = true;
        });
        page = page + 1;
        // print('scroll listener called');
        // print('last page is $lastPage');
        // print(page);
        await retrievePatients();
        setState(() {
          _loadMore = false;
        });
      }
    }
  }
}
