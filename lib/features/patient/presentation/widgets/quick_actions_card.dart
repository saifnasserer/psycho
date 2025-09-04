import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/constants/app_constants.dart';

class QuickActionsCard extends StatelessWidget {
  final VoidCallback onScheduleSession;
  final VoidCallback onEmergencyContact;

  const QuickActionsCard({
    super.key,
    required this.onScheduleSession,
    required this.onEmergencyContact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Responsive.getDynamicPadding(context, basePadding: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 16),
        ),
        border: Border.all(color: Colors.grey[800]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          _buildActionsGrid(context),
        ],
      ),
    );
  }

  Widget _buildActionsGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: Responsive.getSpacing(context, 12),
      mainAxisSpacing: Responsive.getSpacing(context, 12),
      childAspectRatio: 1.2,
      children: [
        _buildActionItem(
          context,
          title: 'Schedule Session',
          subtitle: 'Book with specialist',
          icon: Icons.event_available,
          color: const Color(AppConstants.mintGreen),
          onTap: onScheduleSession,
        ),
        _buildActionItem(
          context,
          title: 'Emergency Contact',
          subtitle: 'Crisis support',
          icon: Icons.emergency,
          color: Colors.red[400]!,
          onTap: onEmergencyContact,
        ),
        _buildActionItem(
          context,
          title: 'AI Assistant',
          subtitle: 'Mental health support',
          icon: Icons.bolt_rounded,
          color: const Color(AppConstants.sereneBlue),
          onTap: () {
            // TODO: Navigate to AI assistant
            print('AI Assistant tapped');
          },
        ),
        _buildActionItem(
          context,
          title: 'Progress Report',
          subtitle: 'View insights',
          icon: Icons.trending_up,
          color: const Color(AppConstants.softLavender),
          onTap: () {
            // TODO: Navigate to progress report
            print('Progress Report tapped');
          },
        ),
      ],
    );
  }

  Widget _buildActionItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: Responsive.getDynamicPadding(context, basePadding: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(
            Responsive.getBorderRadius(context, 12),
          ),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(Responsive.getSpacing(context, 8)),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
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
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[600],
                  size: Responsive.getFontSize(context, 14),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 14),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: Responsive.getSpacing(context, 4)),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 12),
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
