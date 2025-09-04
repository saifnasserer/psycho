import '../../domain/entities/health_metric.dart';

class HealthMetricModel extends HealthMetric {
  const HealthMetricModel({
    required super.id,
    required super.type,
    required super.value,
    required super.timestamp,
    super.note,
    super.unit,
  });

  factory HealthMetricModel.fromJson(Map<String, dynamic> json) {
    return HealthMetricModel(
      id: json['id'] as String,
      type: json['type'] as String,
      value: (json['value'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      note: json['note'] as String?,
      unit: json['unit'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'value': value,
      'timestamp': timestamp.toIso8601String(),
      'note': note,
      'unit': unit,
    };
  }

  // Mock data factory for UI development
  factory HealthMetricModel.mock({
    required String type,
    required double value,
    required String unit,
    String? note,
  }) {
    return HealthMetricModel(
      id: 'metric_${DateTime.now().millisecondsSinceEpoch}',
      type: type,
      value: value,
      timestamp: DateTime.now(),
      note: note,
      unit: unit,
    );
  }
}
