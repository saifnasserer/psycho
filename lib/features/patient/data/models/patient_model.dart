import '../../domain/entities/patient.dart';

class PatientModel extends Patient {
  const PatientModel({
    required super.id,
    required super.name,
    required super.email,
    required super.dateOfBirth,
    super.profileImageUrl,
    required super.preferences,
    super.emergencyContact,
    required super.createdAt,
    required super.updatedAt,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      profileImageUrl: json['profileImageUrl'] as String?,
      preferences: List<String>.from(json['preferences'] as List),
      emergencyContact: json['emergencyContact'] != null
          ? EmergencyContactModel.fromJson(
              json['emergencyContact'] as Map<String, dynamic>,
            )
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'profileImageUrl': profileImageUrl,
      'preferences': preferences,
      'emergencyContact': emergencyContact != null
          ? (emergencyContact as EmergencyContactModel).toJson()
          : null,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Mock data factory for UI development
  factory PatientModel.mock({String? id, String? name, String? email}) {
    return PatientModel(
      id: id ?? 'patient_001',
      name: name ?? 'Sarah Johnson',
      email: email ?? 'sarah.johnson@email.com',
      dateOfBirth: DateTime(1995, 3, 15),
      profileImageUrl: null,
      preferences: ['anxiety_management', 'mindfulness', 'cognitive_therapy'],
      emergencyContact: EmergencyContactModel.mock(),
      createdAt: DateTime(2024, 1, 15),
      updatedAt: DateTime.now(),
    );
  }
}

class EmergencyContactModel extends EmergencyContact {
  const EmergencyContactModel({
    required super.name,
    required super.phoneNumber,
    required super.relationship,
  });

  factory EmergencyContactModel.fromJson(Map<String, dynamic> json) {
    return EmergencyContactModel(
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      relationship: json['relationship'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'relationship': relationship,
    };
  }

  factory EmergencyContactModel.mock() {
    return EmergencyContactModel(
      name: 'Michael Johnson',
      phoneNumber: '+1 (555) 123-4567',
      relationship: 'Brother',
    );
  }
}
