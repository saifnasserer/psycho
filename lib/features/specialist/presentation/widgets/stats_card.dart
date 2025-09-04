import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.getSpacing(context, 12)),
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(Responsive.getSpacing(context, 6)),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    Responsive.getBorderRadius(context, 8),
                  ),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: Responsive.getFontSize(context, 16),
                ),
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 10),
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.getSpacing(context, 8)),
          Text(
            value,
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 20),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 2)),
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
    );
  }
}
