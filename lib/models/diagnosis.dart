class Diagnosis {
  int id;
  int riwayatId;
  int gravida;
  int para;
  int abortus;
  double tinggiBadan;
  double ukuranLila;
  double? beratSebelumHamil;
  double? indeksMasaTubuh;
  double? beratBadanTrimesterHamil;
  double? kadarHemoglobin;
  String resultDiagnosis;
  DateTime createdAt;
  DateTime updatedAt;

  Diagnosis({
    required this.id,
    required this.riwayatId,
    required this.gravida,
    required this.para,
    required this.abortus,
    required this.tinggiBadan,
    required this.ukuranLila,
    this.beratSebelumHamil,
    this.indeksMasaTubuh,
    this.beratBadanTrimesterHamil,
    this.kadarHemoglobin,
    required this.resultDiagnosis,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    return Diagnosis(
      id: json['id'],
      riwayatId: json['riwayat_id'],
      gravida: json['gravida'],
      para: json['para'],
      abortus: json['abortus'],
      tinggiBadan: json['tinggi_badan'].toDouble(),
      ukuranLila: json['ukuran_lila'].toDouble(),
      beratSebelumHamil: json['berat_sebelum_hamil']?.toDouble(),
      indeksMasaTubuh: json['indeks_masa_tubuh']?.toDouble(),
      beratBadanTrimesterHamil: json['berat_badan_trimester_hamil']?.toDouble(),
      kadarHemoglobin: json['kadar_hemoglobin']?.toDouble(),
      resultDiagnosis: json['result_diagnosis'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}


// class Diagnosis {
//   int? id;
//   int? riwayatId;
//   String? resultDiagnosis;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   Diagnosis({
//     this.id,
//     this.riwayatId,
//     this.resultDiagnosis,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Diagnosis.fromJson(Map<String, dynamic> json) {
//     return Diagnosis(
//       id: json['id'],
//       riwayatId: json['riwayat_id'],
//       resultDiagnosis: json['result_diagnosis'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }
// }
