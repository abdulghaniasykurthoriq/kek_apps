import 'package:kek_app/models/additional_food.dart';
import 'package:kek_app/models/diagnosis.dart';
import 'package:kek_app/models/patient.dart';

class RiwayatPatient {
  int id;
  String status;
  int patientId;
  DateTime createdAt;
  DateTime updatedAt;
  Diagnosis diagnosis;
  List<AdditionalFood> additionalFood;
  Patient patient;
  User createdBy;

  RiwayatPatient({
    required this.id,
    required this.status,
    required this.patientId,
    required this.createdAt,
    required this.updatedAt,
    required this.diagnosis,
    required this.additionalFood,
    required this.patient,
    required this.createdBy,
  });

  factory RiwayatPatient.fromJson(Map<String, dynamic> json) {
    return RiwayatPatient(
      id: json['id'],
      status: json['status'],
      patientId: json['patient_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      diagnosis: Diagnosis.fromJson(json['diagnosis']),
      additionalFood: List<AdditionalFood>.from(
        json['additional_food'].map((item) => AdditionalFood.fromJson(item)),
      ),
      patient: Patient.fromJson(json['patient']),
      createdBy: User.fromJson(json['created_by']),
    );
  }
}

class User {
  int id;
  String name;
  String username;
  String email;
  String genre;
  DateTime? emailVerifiedAt;
  String role;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.genre,
    this.emailVerifiedAt,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      genre: json['genre'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
      role: json['role'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}




// class RiwayatPatient {
//   int id;
//   String status;
//   int patientId;
//   DateTime createdAt;
//   DateTime updatedAt;
//   Diagnosis diagnosis;
//   List<AdditionalFood> additionalFood;
//   Patient patient;
//   User createdBy;

//   RiwayatPatient({
//     required this.id,
//     required this.status,
//     required this.patientId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.diagnosis,
//     required this.additionalFood,
//     // required this.healthyFood,
//     required this.patient,
//     required this.createdBy,
//   });

//   factory RiwayatPatient.fromJson(Map<String, dynamic> json) {
//     return RiwayatPatient(
//       id: json['id'],
//       status: json['status'],
//       patientId: json['patient_id'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       // diagnosis: Diagnosis.fromJson(json['diagnosis']),
//       diagnosis: json['diagnosis'] != null
//           ? Diagnosis.fromJson(json['diagnosis'])
//           : Diagnosis(
//               id: 0,
//               riwayatId: 0,
//               tinggiBadan: 0,
//               ukuranLila: 0,
//               beratSebelumHamil: 0,
//               beratBadanTrimesterHamil: 0,
//               kadarHemoglobin: 0,
//               resultDiagnosis: "",
//               createdAt: DateTime(2000),
//               updatedAt: DateTime(2000)),

//       additionalFood: json['additional_food'] != null
//           ? List<AdditionalFood>.from(json['additional_food']
//               .map((food) => AdditionalFood.fromJson(food)))
//           : [],
//       // healthyFood: List<HealthyFood>.from(
//       //     json['healthy_food'].map((food) => HealthyFood.fromJson(food))),
//       patient: json['patient'] != null
//           ? Patient.fromJson(json['patient'])
//           : Patient(
//               id: 0,
//               name: '',
//               alamat: '',
//               // tinggiBadan: 0,
//               tanggalLahir: DateTime.now(),
//               createdBy: 0,
//               createdAt: DateTime.now(),
//               updatedAt: DateTime.now()),
//       createdBy: User.fromJson(json['created_by']),
//     );
//   }
// }

// class Diagnosis {
//   int id;
//   int riwayatId;
//   double tinggiBadan;
//   double ukuranLila;
//   double beratSebelumHamil;
//   double beratBadanTrimesterHamil;
//   double kadarHemoglobin;
//   String resultDiagnosis;
//   DateTime createdAt;
//   DateTime updatedAt;

//   Diagnosis({
//     required this.id,
//     required this.riwayatId,
//     required this.tinggiBadan,
//     required this.ukuranLila,
//     required this.beratSebelumHamil,
//     required this.beratBadanTrimesterHamil,
//     required this.kadarHemoglobin,
//     required this.resultDiagnosis,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Diagnosis.fromJson(Map<String, dynamic> json) {
//     return Diagnosis(
//       id: json['id'],
//       riwayatId: json['riwayat_id'],
//       tinggiBadan: json['tinggi_badan'] ?? 0,
//       ukuranLila: json['ukuran_lila'] ?? 0,
//       beratSebelumHamil: json['berat_sebelum_hamil'] ?? 0,
//       beratBadanTrimesterHamil: json['berat_badan_trimester_hamil'] ?? 0,
//       kadarHemoglobin: json['kadar_hemoglobin'] ?? 0,
//       resultDiagnosis: json['result_diagnosis'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }
// }

// class AdditionalFood {
//   int id;
//   int riwayatId;
//   String food;
//   DateTime createdAt;
//   DateTime updatedAt;

//   AdditionalFood({
//     required this.id,
//     required this.riwayatId,
//     required this.food,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory AdditionalFood.fromJson(Map<String, dynamic> json) {
//     return AdditionalFood(
//       id: json['id'],
//       riwayatId: json['riwayat_id'],
//       food: json['food'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }
// }

// class Patient {
//   int id;
//   String name;
//   String alamat;
//   // int tinggiBadan;
//   DateTime tanggalLahir;
//   int createdBy;
//   DateTime createdAt;
//   DateTime updatedAt;

//   Patient({
//     required this.id,
//     required this.name,
//     required this.alamat,
//     // required this.tinggiBadan,
//     required this.tanggalLahir,
//     required this.createdBy,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Patient.fromJson(Map<String, dynamic> json) {
//     return Patient(
//       id: json['id'],
//       name: json['name'],
//       alamat: json['alamat'],
//       // tinggiBadan: json['tinggi_badan'],
//       tanggalLahir: DateTime.parse(json['tanggal_lahir']),
//       createdBy: json['create_by'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }
// }

// class User {
//   int id;
//   String name;
//   String username;
//   String email;
//   DateTime? emailVerifiedAt;
//   String role;
//   DateTime createdAt;
//   DateTime updatedAt;

//   User({
//     required this.id,
//     required this.name,
//     required this.username,
//     required this.email,
//     this.emailVerifiedAt,
//     required this.role,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       name: json['name'],
//       username: json['username'],
//       email: json['email'],
//       emailVerifiedAt: json['email_verified_at'] != null
//           ? DateTime.parse(json['email_verified_at'])
//           : null,
//       role: json['role'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }
// }


