import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import '../cubits/specialist_home_cubit.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback? onTap;

  const AppointmentCard({super.key, required this.appointment, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Responsive.getSpacing(context, 18)),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(
            Responsive.getBorderRadius(context, 18),
          ),
        ),
        child: Row(
          children: [
            // Appointment Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.clientName,
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(context, 18),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: Responsive.getSpacing(context, 4)),

                  // Time
                  Row(
                    children: [
                      Text(
                        _formatTime(appointment.time),
                        style: TextStyle(
                          fontSize: Responsive.getFontSize(context, 15),
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.getSpacing(context, 4)),

                  // Goal
                  Row(
                    children: [
                      Text(
                        "Goal ",
                        style: TextStyle(
                          fontSize: Responsive.getFontSize(context, 14),
                          color: Color(0xffB8A8D9),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        appointment.goal,
                        style: TextStyle(
                          fontSize: Responsive.getFontSize(context, 14),
                          color: Color(0xff5BA89A),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
