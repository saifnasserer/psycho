class Patient {
  final String id;
  final String name;
  final String email;
  final DateTime dateOfBirth;
  final String? profileImageUrl;
  final List<String> preferences;
  final EmergencyContact? emergencyContact;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Patient({
    required this.id,
    required this.name,
    required this.email,
    required this.dateOfBirth,
    this.profileImageUrl,
    required this.preferences,
    this.emergencyContact,
    required this.createdAt,
    required this.updatedAt,
  });

  Patient copyWith({
    String? id,
    String? name,
    String? email,
    DateTime? dateOfBirth,
    String? profileImageUrl,
    List<String>? preferences,
    EmergencyContact? emergencyContact,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      preferences: preferences ?? this.preferences,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class EmergencyContact {
  final String name;
  final String phoneNumber;
  final String relationship;

  const EmergencyContact({
    required this.name,
    required this.phoneNumber,
    required this.relationship,
  });
}
