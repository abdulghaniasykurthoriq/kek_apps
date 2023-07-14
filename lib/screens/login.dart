import 'package:flutter/material.dart';
import 'package:kek_app/components/button_primary.dart';
import 'package:kek_app/components/input_special2.dart';
import 'package:kek_app/components/special_appbar2.dart';
import 'package:kek_app/models/api_response.dart';
import 'package:kek_app/models/user.dart';
import 'package:kek_app/screens/home.dart';
import 'package:kek_app/services/user_services.dart';
import 'package:kek_app/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  Future<void> _loginUser() async {
    ApiResponse response = await login(txtEmail.text, txtPassword.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Home()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: specialAppbar2('Login', 'KeK', 'App'),
      body: GestureDetector(
        onTap: () {
          // Menghilangkan fokus dari TextField saat area di luar TextField ditekan
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtEmail,
                      validator: (val) =>
                          val!.isEmpty ? 'Invalid email address' : null,
                      decoration: SpecialInput2('Email'),
                      textInputAction: TextInputAction.next,
                    ),
                    TextFormField(
                      controller: txtPassword,
                      obscureText: true,
                      validator: (val) =>
                          val!.isEmpty ? 'required at least 6 char' : null,
                      decoration: SpecialInput2('Password'),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) {
                        // Saat tombol "Done" pada keyboard ditekan, lakukan login
                        if (formkey.currentState!.validate()) {
                          _loginUser();
                        }
                      },
                    ),
                    const SizedBox(height: 200),
                    BtnPrimary(
                      'login',
                      () {
                        if (formkey.currentState!.validate()) {
                          _loginUser();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
