import 'package:kek_app/models/auth_provider.dart';
import 'package:kek_app/models/diagnosis_provider.dart';
import 'package:kek_app/screens/diagnosis/diagnosis1_screen.dart';
import 'package:kek_app/screens/diagnosis/diagnosis2_screen.dart';
import 'package:kek_app/screens/diagnosis/diagnosis3_screen.dart';
import 'package:kek_app/screens/diagnosis/diagnosis4_screen.dart';
import 'package:kek_app/screens/diagnosis/diagnosis5_screen.dart';
import 'package:kek_app/screens/home.dart';
import 'package:kek_app/screens/implementation/additional_food_screen.dart';
import 'package:kek_app/screens/implementation/evaluasi_screen.dart';
import 'package:kek_app/screens/implementation/healthy_food_screen.dart';
// import 'package:kek_app/screens/loading.dart';
import 'package:flutter/material.dart';
// import 'package:kek_app/screens/loading.dart';
import 'package:kek_app/screens/login.dart';
// import 'package:kek_app/screens/patients/detail_riwayat_patient.dart';
import 'package:kek_app/screens/patients/patient_screen.dart';
import 'package:kek_app/screens/patients/new_patient_screen.dart';
import 'package:kek_app/screens/patients/riwayat_screen.dart';
import 'package:kek_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
// import 'package:kek_app/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DiagnosisProvider())
      ],
      child: MaterialApp(
        // home: Loading(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        // theme: ThemeData(primarySwatch: Colors.deepPurple),
        routes: {
          // '/detail': (context) => const DetailRiwayat(),
          '/': (context) => const SplashScreen(),
          '/sign-in': (context) => const Login(),
          '/home': (context) => const Home(),
          '/riwayat': (context) => const RiwayatScreen(),
          '/patients': (context) => const PatientScreen(),
          '/create-patients': (context) => const CreatePatientScreen(),
          '/diagnosis1': (context) => const Diagnosis1Screen(),
          '/diagnosis2': (context) => const Diagnosis2Screen(),
          '/diagnosis3': (context) => const Diagnosis3Screen(),
          '/diagnosis4': (context) => const Diagnosis4Screen(),
          '/diagnosis5': (context) => const Diagnosis5Screen(),
          '/additional-food': (context) => const AdditioanFoodScreen(),
          '/healthy-food': (context) => const HealthyFoodScreen(),
          '/evaluasi': (context) => const EvaluasiScreen(),
        },
      ),
    );
  }
}
