class BmiRecord {
  final int? id;
  final String username;
  final double heightCm;
  final double weightKg;
  final double? bmi;

  BmiRecord({
    this.id,
    required this.username,
    required this.heightCm,
    required this.weightKg,
    required this.bmi,
  });

  factory BmiRecord.fromJson(Map<String, dynamic> json) {
    return BmiRecord(
      id: json['id'],
      username: json['username'],
      heightCm: json['heightCm'],
      weightKg: json['weightKg'],
      bmi: json['bmi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'heightCm': heightCm,
      'weightKg': weightKg,
    };
  }
}
