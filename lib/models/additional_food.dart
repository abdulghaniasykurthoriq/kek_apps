class AdditionalFood {
  int id;
  int riwayatId;
  String food;
  DateTime createdAt;
  DateTime updatedAt;

  AdditionalFood({
    required this.id,
    required this.riwayatId,
    required this.food,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdditionalFood.fromJson(Map<String, dynamic> json) {
    return AdditionalFood(
      id: json['id'],
      riwayatId: json['riwayat_id'],
      food: json['food'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}




// class AdditionalFood {
//   int? id;
//   int? riwayatId;
//   String? food;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   AdditionalFood({
//     this.id,
//     this.riwayatId,
//     this.food,
//     this.createdAt,
//     this.updatedAt,
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
