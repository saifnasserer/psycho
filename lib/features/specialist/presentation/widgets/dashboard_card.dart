import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(Responsive.getSpacing(context, 16)),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(
            Responsive.getBorderRadius(context, 12),
          ),
          border: Border.all(color: color.withOpacity(0.2), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(Responsive.getSpacing(context, 8)),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(context, 8),
                ),
              ),
              child: Icon(
                icon,
                color: color,
                size: Responsive.getFontSize(context, 20),
              ),
            ),
            SizedBox(height: Responsive.getSpacing(context, 12)),

            // Title
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: Responsive.getFontSize(context, 14),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: Responsive.getSpacing(context, 2)),

            // Subtitle
            Flexible(
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: Responsive.getFontSize(context, 10),
                  color: Colors.grey[400],
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
