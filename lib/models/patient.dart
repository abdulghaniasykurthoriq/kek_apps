class Patient {
  int? id;
  String? name;
  String? alamat;
  int? tinggiBadan;
  DateTime? tanggalLahir;
  int? createBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Patient({
    this.id,
    this.name,
    this.alamat,
    this.tinggiBadan,
    this.tanggalLahir,
    this.createBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      alamat: json['alamat'],
      tinggiBadan: json['tinggi_badan'],
      tanggalLahir: DateTime.parse(json['tanggal_lahir']),
      createBy: json['create_by'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}


// class Patient {
//   int? id;
//   String? name;
//   String? alamat;
//   int? tinggiBadan;
//   String? tanggalLahir;
//   int? createBy;

//   Patient(
//       {this.id,
//       this.name,
//       this.alamat,
//       this.tinggiBadan,
//       this.tanggalLahir,
//       this.createBy});

//   factory Patient.fromJson(Map<String, dynamic> json) {
//     return Patient(
//       id: json['id'] as int?,
//       name: json['name'] as String?,
//       alamat: json['alamat'] as String?,
//       tinggiBadan: json['tinggi_badan'] as int?,
//       tanggalLahir: json['tanggal_lahir'] as String?,
//       createBy: json['create_by'] as int?,
//     );
//   }
// }
