import 'package:flutter/material.dart';
import 'package:kek_app/constant.dart';
import 'package:kek_app/models/api_response.dart';
import 'package:kek_app/models/auth_provider.dart';
import 'package:kek_app/models/patient.dart';
import 'package:kek_app/screens/diagnosis/diagnosis0_screen.dart';
// import 'package:kek_app/screens/diagnosis/diagnosis1_screen.dart';
import 'package:kek_app/screens/patients/new_patient_screen.dart';
import 'package:kek_app/services/patient_services.dart';
import 'package:kek_app/services/user_services.dart';
import 'package:kek_app/theme.dart';
import 'package:kek_app/utils/count_age.dart';
import 'package:kek_app/utils/pascal_case.dart';
import 'package:kek_app/utils/truncate_string.dart';
import 'package:provider/provider.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({Key? key}) : super(key: key);

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  int userId = 0;
  bool _loading = true;
  TextEditingController txtFilter = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final scrollController = ScrollController();
  bool _loadMore = false;
  int page = 1;
  int lastPage = 1; // Set default value to 1
  String? kelamin;

  List<dynamic> _patientList = [];

  Future<void> retrievePatients() async {
    userId = await getUserId();
    kelamin = await getGenre();
    ApiResponse response = await getPatients(txtFilter.text.toString(), page);

    if (response.error == null) {
      if (mounted) {
        setState(() {
          lastPage = response.lastPage ?? lastPage; // Update lastPage value
          _patientList = [..._patientList, ...response.data as List<dynamic>];
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
  }

  void _handleDeletePatient(int patientId) async {
    ApiResponse response = await deletePatient(patientId);
    if (response.error == null) {
      setState(() {
        _patientList = [];
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

  void handleFilter() {
    setState(() {
      _patientList = []; // Clear patient list
      page = 1; // Reset page to 1
      lastPage = 1; // Reset lastPage to 1
    });
    retrievePatients();
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    retrievePatients();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                                      'Pasien',
                                      style: blueTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Puskesmas',
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
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  padding: const EdgeInsets.only(left: 20),
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: formkey,
                    child: Row(
                      children: [
                        Image.asset('assets/icon_search.png'),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: txtFilter,
                            decoration: const InputDecoration(
                              hintText: 'Search . . .',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            handleFilter();
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

    Widget cardPasien(Patient patient) {
      // int lahir = int.parse(patient.tanggalLahir!.split('-').first);
      // int umur = DateTime.now().year - lahir;
      String age = countAge(patient.tanggalLahir.toString());
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
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
                  toPascalCase(truncateString(patient.name, 20)),
                  style: comfortaaBlueTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  truncateString(patient.alamat, 20),
                  style: comfortaaBlueTextStyle.copyWith(fontSize: 12),
                )
              ],
            ),
            const Expanded(child: SizedBox()),
            Column(
              children: [
                if (patient.createdBy == userId)
                  PopupMenuButton(
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Icon(
                        Icons.more_horiz,
                        color: Colors.black,
                      ),
                    ),
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'edit', child: Text('Edit')),
                      const PopupMenuItem(
                          value: 'delete', child: Text('Delete')),
                    ],
                    onSelected: (val) {
                      if (val == 'edit') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreatePatientScreen(
                                  title: 'Edit',
                                  patient: patient,
                                )));
                      } else {
                        _handleDeletePatient(patient.id);
                      }
                    },
                  )
                else
                  const SizedBox(),
                Text(
                  // '0 tahun',

                  age,
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
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
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
              child: ListView.builder(
                controller: scrollController,
                itemCount: _patientList.length + (_loadMore ? 1 : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index < _patientList.length) {
                    Patient patient = _patientList[index];
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Diagnosis0(
                            patient: patient,
                          ),
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                        child: cardPasien(patient),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
    );
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (page < lastPage) {
        setState(() {
          _loadMore = true;
        });
        page = page + 1;
        await retrievePatients();
        setState(() {
          _loadMore = false;
        });
      }
    }
  }
}
