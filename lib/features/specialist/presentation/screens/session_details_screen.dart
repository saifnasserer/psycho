import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/constants/app_constants.dart';
import '../cubits/specialist_home_cubit.dart';

class SessionDetailsScreen extends StatelessWidget {
  final Appointment appointment;
  final Client client;

  const SessionDetailsScreen({
    super.key,
    required this.appointment,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: Responsive.getFontSize(context, 20),
          ),
        ),
        title: Text(
          'Session Details',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 18),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Edit session
              print('Edit session');
            },
            icon: Icon(
              Icons.edit,
              color: Colors.white,
              size: Responsive.getFontSize(context, 20),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.getSpacing(context, 20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Client Info Card
            _buildClientInfoCard(context),
            SizedBox(height: Responsive.getSpacing(context, 20)),

            // Session Info Card
            _buildSessionInfoCard(context),
            SizedBox(height: Responsive.getSpacing(context, 20)),

            // Session Notes Card
            _buildSessionNotesCard(context),
            SizedBox(height: Responsive.getSpacing(context, 20)),

            // Goals Card
            _buildGoalsCard(context),
            SizedBox(height: Responsive.getSpacing(context, 20)),

            // AI Report Card
            _buildAIReportCard(context),
            // SizedBox(height: Responsive.getSpacing(context, 20)),

            // Action Buttons
            // _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildClientInfoCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.getSpacing(context, 20)),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 16),
        ),
      ),
      child: Row(
        children: [
          // Client Avatar
          Container(
            width: Responsive.getFontSize(context, 60),
            height: Responsive.getFontSize(context, 60),
            decoration: BoxDecoration(
              color: const Color(AppConstants.mintGreen).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 30),
              ),
            ),
            child: Icon(
              Icons.person,
              color: const Color(AppConstants.mintGreen),
              size: Responsive.getFontSize(context, 30),
            ),
          ),
          SizedBox(width: Responsive.getSpacing(context, 16)),

          // Client Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client.name,
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 20),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: Responsive.getSpacing(context, 4)),
                Text(
                  'Total Sessions: ${client.totalSessions}',
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 14),
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionInfoCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.getSpacing(context, 20)),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Session Information',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),

          // Date and Time
          _buildInfoRow(
            context,
            Icons.calendar_today,
            'Date',
            _formatDate(appointment.time),
          ),
          SizedBox(height: Responsive.getSpacing(context, 12)),

          _buildInfoRow(
            context,
            Icons.access_time,
            'Time',
            _formatTime(appointment.time),
          ),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildInfoRow(
            context,
            Icons.repeat,
            'Recurrence',
            'Weekly', // Mock data
          ),
        ],
      ),
    );
  }

  Widget _buildSessionNotesCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.getSpacing(context, 20)),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Session Notes',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          Text(
            'This session focused on anxiety management techniques. The client showed significant progress in identifying triggers and implementing coping strategies. We discussed breathing exercises and mindfulness practices.',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 14),
              color: Colors.grey[300],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.getSpacing(context, 20)),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Session Goals',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          Wrap(
            spacing: Responsive.getSpacing(context, 8),
            runSpacing: Responsive.getSpacing(context, 8),
            children: [
              _buildGoalTag(context, appointment.goal),
              _buildGoalTag(context, 'Anxiety Management'),
              _buildGoalTag(context, 'Mindfulness'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAIReportCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.getSpacing(context, 20)),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.psychology,
                color: const Color(AppConstants.mintGreen),
                size: Responsive.getFontSize(context, 20),
              ),
              SizedBox(width: Responsive.getSpacing(context, 8)),
              Text(
                'AI Analysis Report',
                style: TextStyle(
                  fontSize: Responsive.getFontSize(context, 18),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          Text(
            'The AI analysis indicates positive progress in the client\'s anxiety management. Key improvements noted in emotional regulation and coping mechanism implementation.',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 14),
              color: Colors.grey[300],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(AppConstants.mintGreen),
          size: Responsive.getFontSize(context, 18),
        ),
        SizedBox(width: Responsive.getSpacing(context, 12)),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 14),
            color: Colors.grey[400],
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 14),
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGoalTag(BuildContext context, String goal) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.getSpacing(context, 12),
        vertical: Responsive.getSpacing(context, 6),
      ),
      decoration: BoxDecoration(
        color: const Color(AppConstants.mintGreen).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 16),
        ),
        border: Border.all(color: const Color(AppConstants.mintGreen)),
      ),
      child: Text(
        goal,
        style: TextStyle(
          fontSize: Responsive.getFontSize(context, 12),
          color: const Color(AppConstants.mintGreen),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Widget _buildActionButtons(BuildContext context) {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: OutlinedButton.icon(
  //           onPressed: () {
  //             // TODO: Start session
  //             print('Start session');
  //           },
  //           icon: Icon(Icons.play_arrow, color: Colors.white),
  //           label: Text('Start Session'),
  //           style: OutlinedButton.styleFrom(
  //             side: BorderSide(color: const Color(AppConstants.mintGreen)),
  //             foregroundColor: const Color(AppConstants.mintGreen),
  //             padding: EdgeInsets.symmetric(
  //               vertical: Responsive.getSpacing(context, 16),
  //             ),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(
  //                 Responsive.getBorderRadius(context, 12),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //       SizedBox(width: Responsive.getSpacing(context, 16)),
  //       Expanded(
  //         child: ElevatedButton.icon(
  //           onPressed: () {
  //             // TODO: Reschedule session
  //             print('Reschedule session');
  //           },
  //           icon: Icon(Icons.schedule, color: Colors.white),
  //           label: Text('Reschedule'),
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: const Color(AppConstants.mintGreen),
  //             foregroundColor: Colors.white,
  //             padding: EdgeInsets.symmetric(
  //               vertical: Responsive.getSpacing(context, 16),
  //             ),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(
  //                 Responsive.getBorderRadius(context, 12),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12
        ? hour - 12
        : hour == 0
        ? 12
        : hour;
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }
}
