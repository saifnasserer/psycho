class HealthMetric {
  final String id;
  final String type; // HRV, mood, sleep, anxiety, etc.
  final double value;
  final DateTime timestamp;
  final String? note;
  final String? unit; // bpm, score, hours, etc.

  const HealthMetric({
    required this.id,
    required this.type,
    required this.value,
    required this.timestamp,
    this.note,
    this.unit,
  });

  HealthMetric copyWith({
    String? id,
    String? type,
    double? value,
    DateTime? timestamp,
    String? note,
    String? unit,
  }) {
    return HealthMetric(
      id: id ?? this.id,
      type: type ?? this.type,
      value: value ?? this.value,
      timestamp: timestamp ?? this.timestamp,
      note: note ?? this.note,
      unit: unit ?? this.unit,
    );
  }
}
