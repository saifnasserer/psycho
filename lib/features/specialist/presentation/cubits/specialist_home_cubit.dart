import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Models
class Appointment {
  final String id;
  final String clientName;
  final String clientAvatar;
  final DateTime time;
  final String goal;
  final String notes;

  const Appointment({
    required this.id,
    required this.clientName,
    required this.clientAvatar,
    required this.time,
    required this.goal,
    required this.notes,
  });
}

class Client {
  final String id;
  final String name;
  final String avatar;
  final String lastSession;
  final int totalSessions;

  const Client({
    required this.id,
    required this.name,
    required this.avatar,
    required this.lastSession,
    required this.totalSessions,
  });
}

// State
class SpecialistHomeState extends Equatable {
  final int selectedTabIndex;
  final int todayAppointmentsCount;
  final int activeClients;
  final int weeklySessions;
  final int unreadMessages;
  final List<Appointment> todayAppointments;
  final List<Client> recentClients;

  const SpecialistHomeState({
    this.selectedTabIndex = 0,
    this.todayAppointmentsCount = 0,
    this.activeClients = 0,
    this.weeklySessions = 0,
    this.unreadMessages = 0,
    this.todayAppointments = const [],
    this.recentClients = const [],
  });

  SpecialistHomeState copyWith({
    int? selectedTabIndex,
    int? todayAppointmentsCount,
    int? activeClients,
    int? weeklySessions,
    int? unreadMessages,
    List<Appointment>? todayAppointments,
    List<Client>? recentClients,
  }) {
    return SpecialistHomeState(
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      todayAppointmentsCount:
          todayAppointmentsCount ?? this.todayAppointmentsCount,
      activeClients: activeClients ?? this.activeClients,
      weeklySessions: weeklySessions ?? this.weeklySessions,
      unreadMessages: unreadMessages ?? this.unreadMessages,
      todayAppointments: todayAppointments ?? this.todayAppointments,
      recentClients: recentClients ?? this.recentClients,
    );
  }

  @override
  List<Object?> get props => [
    selectedTabIndex,
    todayAppointmentsCount,
    activeClients,
    weeklySessions,
    unreadMessages,
    todayAppointments,
    recentClients,
  ];
}

// Cubit
class SpecialistHomeCubit extends Cubit<SpecialistHomeState> {
  SpecialistHomeCubit() : super(const SpecialistHomeState()) {
    _loadMockData();
  }

  void setTabIndex(int index) {
    emit(state.copyWith(selectedTabIndex: index));
  }

  void _loadMockData() {
    final mockAppointments = [
      Appointment(
        id: '1',
        clientName: 'John Doe',
        clientAvatar: 'https://i.pravatar.cc/150?img=1',
        time: DateTime.now().add(const Duration(hours: 1)),
        goal: 'Anxiety Therapy',
        notes: 'Follow-up session',
      ),
      Appointment(
        id: '2',
        clientName: 'Jane Smith',
        clientAvatar: 'https://i.pravatar.cc/150?img=2',
        time: DateTime.now().add(const Duration(hours: 3)),
        goal: 'Depression Counseling',
        notes: 'Weekly session',
      ),
      Appointment(
        id: '3',
        clientName: 'Mike Johnson',
        clientAvatar: 'https://i.pravatar.cc/150?img=3',
        time: DateTime.now().add(const Duration(hours: 5)),
        goal: 'PTSD Treatment',
        notes: 'First session',
      ),
    ];

    final mockClients = [
      Client(
        id: '1',
        name: 'John Doe',
        avatar: 'https://i.pravatar.cc/150?img=1',
        lastSession: '2 days ago',
        totalSessions: 12,
      ),
      Client(
        id: '2',
        name: 'Jane Smith',
        avatar: 'https://i.pravatar.cc/150?img=2',
        lastSession: '1 week ago',

        totalSessions: 8,
      ),
      Client(
        id: '3',
        name: 'Mike Johnson',
        avatar: 'https://i.pravatar.cc/150?img=3',
        lastSession: '3 days ago',
        totalSessions: 5,
      ),
      Client(
        id: '4',
        name: 'Sarah Wilson',
        avatar: 'https://i.pravatar.cc/150?img=4',
        lastSession: '2 weeks ago',

        totalSessions: 5,
      ),
    ];

    emit(
      state.copyWith(
        todayAppointmentsCount: mockAppointments.length,
        activeClients: mockClients.length,
        weeklySessions: 18,
        unreadMessages: 3,
        todayAppointments: mockAppointments,
        recentClients: mockClients,
      ),
    );
  }
}
