import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import '../cubits/specialist_home_cubit.dart';

class ClientCardNew extends StatelessWidget {
  final Client client;
  final VoidCallback? onTap;

  const ClientCardNew({super.key, required this.client, this.onTap});

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
            // Client Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client.name,
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(context, 18),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: Responsive.getSpacing(context, 4)),

                  // Last Session
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Colors.grey[400],
                        size: Responsive.getFontSize(context, 16),
                      ),
                      SizedBox(width: Responsive.getSpacing(context, 4)),
                      Text(
                        'Last: ${client.lastSession}',
                        style: TextStyle(
                          fontSize: Responsive.getFontSize(context, 14),
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.getSpacing(context, 4)),

                  // Total Sessions
                  Row(
                    children: [
                      Icon(
                        Icons.psychology,
                        color: const Color(0xFF5BA89A),
                        size: Responsive.getFontSize(context, 16),
                      ),
                      SizedBox(width: Responsive.getSpacing(context, 4)),
                      Text(
                        '${client.totalSessions} sessions',
                        style: TextStyle(
                          fontSize: Responsive.getFontSize(context, 14),
                          color: const Color(0xFF5BA89A),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Arrow indicator
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: Responsive.getFontSize(context, 16),
            ),
          ],
        ),
      ),
    );
  }
}
