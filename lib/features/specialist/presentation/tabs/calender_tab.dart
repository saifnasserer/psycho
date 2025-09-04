import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import '../cubits/specialist_home_cubit.dart';
import '../widgets/appointment_card.dart';
import '../screens/session_details_screen.dart';

class HomeTab extends StatelessWidget {
  final SpecialistHomeState state;

  const HomeTab({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return _buildTodaySchedule(context);
  }

  Widget _buildTodaySchedule(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCalendarButton(context),
        SizedBox(height: Responsive.getSpacing(context, 24)),
        Text(
          'Today\'s Sessions',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 22),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: Responsive.getSpacing(context, 16)),
        if (state.todayAppointments.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(Responsive.getSpacing(context, 20)),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 16),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.event_available,
                  color: Colors.grey[600],
                  size: Responsive.getFontSize(context, 48),
                ),
                SizedBox(height: Responsive.getSpacing(context, 12)),
                Text(
                  'No appointments today',
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 16),
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: Responsive.getSpacing(context, 8)),
                Text(
                  'Enjoy your free time!',
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 14),
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          )
        else
          ...state.todayAppointments.map((appointment) {
            // Find the corresponding client for this appointment
            final client = state.recentClients.firstWhere(
              (c) => c.name == appointment.clientName,
              orElse: () => Client(
                id: appointment.id,
                name: appointment.clientName,
                avatar: appointment.clientAvatar,
                lastSession: 'Today',
                totalSessions: 1,
              ),
            );

            return Padding(
              padding: EdgeInsets.only(
                bottom: Responsive.getSpacing(context, 12),
              ),
              child: AppointmentCard(
                appointment: appointment,
                onTap: () {
                  // Navigate to session details screen
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SessionDetailsScreen(
                        appointment: appointment,
                        client: client,
                      ),
                    ),
                  );
                },
              ),
            );
          }),
      ],
    );
  }

  Widget _buildCalendarButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Responsive.getFontSize(context, 120),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 20),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO: Navigate to calendar/scheduling screen
            print('Calendar button tapped');
          },
          borderRadius: BorderRadius.circular(
            Responsive.getBorderRadius(context, 16),
          ),
          child: Padding(
            padding: EdgeInsets.all(Responsive.getSpacing(context, 20)),
            child: Row(
              children: [
                // Calendar Icon
                Container(
                  width: Responsive.getFontSize(context, 60),
                  height: Responsive.getFontSize(context, 60),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(
                      Responsive.getBorderRadius(context, 12),
                    ),
                  ),
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: Responsive.getFontSize(context, 28),
                  ),
                ),
                SizedBox(width: Responsive.getSpacing(context, 16)),
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Calendar',
                        style: TextStyle(
                          fontSize: Responsive.getFontSize(context, 20),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: Responsive.getSpacing(context, 4)),
                      Text(
                        'Add new sessions and organize your schedule',
                        style: TextStyle(
                          fontSize: Responsive.getFontSize(context, 14),
                          color: Colors.white.withValues(alpha: 0.9),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                // Arrow Icon
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withValues(alpha: 0.8),
                  size: Responsive.getFontSize(context, 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
