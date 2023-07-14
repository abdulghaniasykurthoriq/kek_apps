import 'package:flutter/material.dart';
import 'package:kek_app/screens/login.dart';
// import 'package:kek_app/models/pages_model.dart';
import 'package:kek_app/services/user_services.dart';
import 'package:kek_app/theme.dart';
// import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const SizedBox(
            height: 130,
          ),
          SizedBox(
            height: 65,
            width: 65,
            child: ClipOval(
              child: Image.asset(
                'assets/doctor_cewe.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Abdul Ghani Asykur',
            style:
                comfortaaBlueTextStyle.copyWith(fontWeight: bold, fontSize: 16),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () async {
              // await logout();

              logout().then((value) => {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const Login()),
                        (route) => false)
                  });

              // context
              //     .read<Pages>()
              //     .reset(); // Reset semua konfigurasi pada model Pages

              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const Login()),
                (Route<dynamic> route) => false,
              );
              // Navigator.pushNamedAndRemoveUntil(
              //   context,
              //   '/sign-in', // Nama rute untuk halaman masuk (SignIn)
              //   (route) =>
              //       false, // Menghapus semua halaman yang ada dari tumpukan navigasi
              // );
            },
            // onTap: () {
            //   logout().then((value) {
            //     context.read<Pages>().updateCurrentPage(1);
            //     context.read<Pages>().setIsHome(true);
            //     Navigator.of(context).push(
            //       MaterialPageRoute(builder: (context) => const SignIn()),
            //     );
            //     //s Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => SignIn() ), (Route<dynamic> route) => false);
            //   });
            // },
            child: const Text('Logout'),
          ),
          // Consumer<Pages>(
          //   builder: (_, pages, __) {
          //     return Text(
          //       '${context.watch<Pages>().currentPage}',
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
