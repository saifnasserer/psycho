import '../../domain/entities/session.dart';

class SessionModel extends Session {
  const SessionModel({
    required super.id,
    required super.specialistId,
    required super.specialistName,
    required super.specialistSpecialization,
    required super.scheduledAt,
    super.completedAt,
    required super.status,
    super.notes,
    required super.duration,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'] as String,
      specialistId: json['specialistId'] as String,
      specialistName: json['specialistName'] as String,
      specialistSpecialization: json['specialistSpecialization'] as String,
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      status: json['status'] as String,
      notes: json['notes'] as String?,
      duration: json['duration'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'specialistId': specialistId,
      'specialistName': specialistName,
      'specialistSpecialization': specialistSpecialization,
      'scheduledAt': scheduledAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'status': status,
      'notes': notes,
      'duration': duration,
    };
  }

  // Mock data factory for UI development
  factory SessionModel.mock({
    required String specialistName,
    required String specialistSpecialization,
    required DateTime scheduledAt,
    required String status,
    String? notes,
  }) {
    return SessionModel(
      id: 'session_${DateTime.now().millisecondsSinceEpoch}',
      specialistId: 'specialist_001',
      specialistName: specialistName,
      specialistSpecialization: specialistSpecialization,
      scheduledAt: scheduledAt,
      completedAt: status == 'completed'
          ? scheduledAt.add(const Duration(minutes: 50))
          : null,
      status: status,
      notes: notes,
      duration: 50,
    );
  }
}
