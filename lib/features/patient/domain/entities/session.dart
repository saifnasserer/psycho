class Session {
  final String id;
  final String specialistId;
  final String specialistName;
  final String specialistSpecialization;
  final DateTime scheduledAt;
  final DateTime? completedAt;
  final String status; // scheduled, completed, cancelled
  final String? notes;
  final int duration; // in minutes

  const Session({
    required this.id,
    required this.specialistId,
    required this.specialistName,
    required this.specialistSpecialization,
    required this.scheduledAt,
    this.completedAt,
    required this.status,
    this.notes,
    required this.duration,
  });

  Session copyWith({
    String? id,
    String? specialistId,
    String? specialistName,
    String? specialistSpecialization,
    DateTime? scheduledAt,
    DateTime? completedAt,
    String? status,
    String? notes,
    int? duration,
  }) {
    return Session(
      id: id ?? this.id,
      specialistId: specialistId ?? this.specialistId,
      specialistName: specialistName ?? this.specialistName,
      specialistSpecialization:
          specialistSpecialization ?? this.specialistSpecialization,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      duration: duration ?? this.duration,
    );
  }
}
