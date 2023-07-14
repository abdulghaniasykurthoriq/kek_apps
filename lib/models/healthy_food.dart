import 'package:kek_app/models/patient.dart';

class HealthyFood {
  int? id;
  int? riwayatId;
  String? food;
  DateTime? createdAt;
  DateTime? updatedAt;

  HealthyFood({
    this.id,
    this.riwayatId,
    this.food,
    this.createdAt,
    this.updatedAt,
    Patient? patient,
  });

  factory HealthyFood.fromJson(Map<String, dynamic> json) {
    return HealthyFood(
      id: json['id'],
      riwayatId: json['riwayat_id'],
      food: json['food'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
