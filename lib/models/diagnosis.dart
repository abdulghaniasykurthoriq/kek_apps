class Diagnosis {
  int? id;
  int? riwayatId;
  String? resultDiagnosis;
  DateTime? createdAt;
  DateTime? updatedAt;

  Diagnosis({
    this.id,
    this.riwayatId,
    this.resultDiagnosis,
    this.createdAt,
    this.updatedAt,
  });

  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    return Diagnosis(
      id: json['id'],
      riwayatId: json['riwayat_id'],
      resultDiagnosis: json['result_diagnosis'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
