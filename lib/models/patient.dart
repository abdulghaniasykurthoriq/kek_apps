class Patient {
  int id;
  String name;
  String alamat;
  DateTime tanggalLahir;
  int createdBy;
  DateTime createdAt;
  DateTime updatedAt;

  Patient({
    required this.id,
    required this.name,
    required this.alamat,
    required this.tanggalLahir,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      alamat: json['alamat'],
      tanggalLahir: DateTime.parse(json['tanggal_lahir']),
      createdBy: json['create_by'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
