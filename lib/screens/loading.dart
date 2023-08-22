import 'package:kek_app/constant.dart';
import 'package:kek_app/models/api_response.dart';
import 'package:kek_app/models/auth_provider.dart';
import 'package:kek_app/screens/home.dart';
// import 'package:kek_app/screens/home.dart';
import 'package:kek_app/screens/login.dart';
// import 'package:kek_app/screens/splash_screen.dart';
import 'package:kek_app/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void _loadUserInfo() async {
    String token = await getToken();
    if (token == '') {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Login()),
          (route) => false);
    } else {
      ApiResponse response = await getUserDetail();

      if (response.error == null) {
        // print(response.data as);
        var user = response.data as User;
        if (user.genre == "l") {
          // ignore: use_build_context_synchronously
          context
              .read<AuthProvider>()
              .updateUrlPhotoUser("assets/doctor_cowo.jpg");
        } else if (user.genre == "p") {
          // ignore: use_build_context_synchronously
          context
              .read<AuthProvider>()
              .updateUrlPhotoUser("assets/doctor_cewe.jpg");
        }
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Home()),
            (route) => false);

        // ignore: use_build_context_synchronously
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => const SplashScreen()),
        //     (route) => false);
      } else if (response.error == unauthorized) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}')));
      }
    }
  }

  @override
  void initState() {
    _loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
