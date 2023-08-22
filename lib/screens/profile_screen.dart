import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kek_app/models/auth_provider.dart';
import 'package:kek_app/screens/login.dart';
import 'package:kek_app/services/user_services.dart';
import 'package:kek_app/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? kelamin;
  String? nama;
  bool isLoading = false;

  @override
  void initState() {
    setGender();
    super.initState();
  }

  Future<void> setGender() async {
    kelamin = await getGenre();
    nama = await getName();
    setState(() {});
  }

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
          const SizedBox(
            height: 30,
          ),
          Text(
            nama ?? " ",
            style: comfortaaBlueTextStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          // Consumer<AuthProvider>(
          //   builder: (context, authProvider, _) {
          //     return Text(
          //       authProvider.urlPhotoUser,
          //       // key: const Key('counterState'),
          //     );
          //   },
          // ),
          const SizedBox(
            height: 30,
          ),

          GestureDetector(
            onTap: () async {
              setState(() {
                isLoading = true;
              });

              bool isLoggedOut = await logout();
              if (isLoggedOut) {
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Login()),
                  (route) => false,
                );
              }

              setState(() {
                isLoading = false;
              });
            },
            child: isLoading ? const Text('Loading...') : const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
