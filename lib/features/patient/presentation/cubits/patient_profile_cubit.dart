import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/patient_model.dart';
import '../../data/models/health_metric_model.dart';
import '../../data/models/session_model.dart';
import '../../domain/entities/patient.dart';
import '../../domain/entities/health_metric.dart';
import '../../domain/entities/session.dart';

// States
abstract class PatientProfileState {}

class PatientProfileInitial extends PatientProfileState {}

class PatientProfileLoading extends PatientProfileState {}

class PatientProfileLoaded extends PatientProfileState {
  final Patient patient;
  final List<HealthMetric> healthMetrics;
  final List<Session> recentSessions;
  final int selectedTabIndex;

  PatientProfileLoaded({
    required this.patient,
    required this.healthMetrics,
    required this.recentSessions,
    this.selectedTabIndex = 0,
  });

  PatientProfileLoaded copyWith({
    Patient? patient,
    List<HealthMetric>? healthMetrics,
    List<Session>? recentSessions,
    int? selectedTabIndex,
  }) {
    return PatientProfileLoaded(
      patient: patient ?? this.patient,
      healthMetrics: healthMetrics ?? this.healthMetrics,
      recentSessions: recentSessions ?? this.recentSessions,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }
}

class PatientProfileError extends PatientProfileState {
  final String message;

  PatientProfileError({required this.message});
}

// Cubit
class PatientProfileCubit extends Cubit<PatientProfileState> {
  final String? patientId;

  PatientProfileCubit({this.patientId}) : super(PatientProfileInitial()) {
    _loadMockData();
  }

  void _loadMockData() {
    emit(PatientProfileLoading());

    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 1000), () {
      try {
        final patient = _getPatientById(patientId);
        final healthMetrics = _generateMockHealthMetrics();
        final recentSessions = _generateMockSessions();

        emit(
          PatientProfileLoaded(
            patient: patient,
            healthMetrics: healthMetrics,
            recentSessions: recentSessions,
          ),
        );
      } catch (e) {
        emit(PatientProfileError(message: 'Failed to load profile data'));
      }
    });
  }

  Patient _getPatientById(String? id) {
    // Mock patient data based on ID
    switch (id) {
      case '1':
        return PatientModel.mock(
          id: '1',
          name: 'John Doe',
          email: 'john.doe@email.com',
        );
      case '2':
        return PatientModel.mock(
          id: '2',
          name: 'Jane Smith',
          email: 'jane.smith@email.com',
        );
      case '3':
        return PatientModel.mock(
          id: '3',
          name: 'Mike Johnson',
          email: 'mike.johnson@email.com',
        );
      case '4':
        return PatientModel.mock(
          id: '4',
          name: 'Sarah Wilson',
          email: 'sarah.wilson@email.com',
        );
      default:
        return PatientModel.mock(); // Default patient
    }
  }

  List<HealthMetric> _generateMockHealthMetrics() {
    return [
      HealthMetricModel.mock(
        type: 'HRV',
        value: 45.2,
        unit: 'ms',
        note: 'Good recovery',
      ),
      HealthMetricModel.mock(
        type: 'Mood',
        value: 7.5,
        unit: '/10',
        note: 'Feeling positive today',
      ),
      HealthMetricModel.mock(
        type: 'Sleep',
        value: 7.8,
        unit: 'hours',
        note: 'Restful sleep',
      ),
      HealthMetricModel.mock(
        type: 'Anxiety',
        value: 3.2,
        unit: '/10',
        note: 'Low anxiety levels',
      ),
    ];
  }

  List<Session> _generateMockSessions() {
    final now = DateTime.now();
    return [
      SessionModel.mock(
        specialistName: 'Dr. Emily Chen',
        specialistSpecialization: 'Psychotherapist',
        scheduledAt: now.add(const Duration(days: 2)),
        status: 'scheduled',
        notes: 'Weekly check-in session',
      ),
      SessionModel.mock(
        specialistName: 'Dr. Michael Rodriguez',
        specialistSpecialization: 'Psychologist',
        scheduledAt: now.subtract(const Duration(days: 3)),
        status: 'completed',
        notes: 'Great progress on anxiety management techniques',
      ),
      SessionModel.mock(
        specialistName: 'Dr. Sarah Williams',
        specialistSpecialization: 'Psychiatrist',
        scheduledAt: now.subtract(const Duration(days: 10)),
        status: 'completed',
        notes: 'Medication review and adjustment',
      ),
    ];
  }

  void setTabIndex(int index) {
    final currentState = state;
    if (currentState is PatientProfileLoaded) {
      emit(currentState.copyWith(selectedTabIndex: index));
    }
  }

  void refreshProfile() {
    _loadMockData();
  }

  void scheduleSession() {
    // TODO: Navigate to session scheduling
    print('Schedule session tapped');
  }

  void viewAllSessions() {
    // TODO: Navigate to sessions list
    print('View all sessions tapped');
  }

  void editProfile() {
    // TODO: Navigate to profile editing
    print('Edit profile tapped');
  }

  void openSettings() {
    // TODO: Navigate to settings
    print('Settings tapped');
  }

  void openEmergencyContact() {
    // TODO: Show emergency contact info
    print('Emergency contact tapped');
  }
}
