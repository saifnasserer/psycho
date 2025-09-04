import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/session.dart';

class RecentSessionsCard extends StatelessWidget {
  final List<Session> sessions;
  final VoidCallback onViewAll;

  const RecentSessionsCard({
    super.key,
    required this.sessions,
    required this.onViewAll,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Sessions',
                style: TextStyle(
                  fontSize: Responsive.getFontSize(context, 18),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: onViewAll,
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 14),
                    color: const Color(AppConstants.mintGreen),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          if (sessions.isEmpty)
            _buildEmptyState(context)
          else
            _buildSessionsList(context),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.getSpacing(context, 20)),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 12),
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
            'No sessions yet',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 16),
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 8)),
          Text(
            'Schedule your first session to get started',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 14),
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSessionsList(BuildContext context) {
    return Column(
      children: sessions.take(3).map((session) {
        return Padding(
          padding: EdgeInsets.only(bottom: Responsive.getSpacing(context, 12)),
          child: _buildSessionItem(context, session),
        );
      }).toList(),
    );
  }

  Widget _buildSessionItem(BuildContext context, Session session) {
    return Container(
      padding: Responsive.getDynamicPadding(context, basePadding: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 12),
        ),
        border: Border.all(
          color: _getStatusColor(session.status).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Status indicator
          Container(
            width: Responsive.getFontSize(context, 12),
            height: Responsive.getFontSize(context, 12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getStatusColor(session.status),
            ),
          ),
          SizedBox(width: Responsive.getSpacing(context, 12)),

          // Session info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.specialistName,
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 16),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: Responsive.getSpacing(context, 4)),
                Text(
                  session.specialistSpecialization,
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 14),
                    color: const Color(AppConstants.mintGreen),
                  ),
                ),
                SizedBox(height: Responsive.getSpacing(context, 4)),
                Text(
                  _formatSessionTime(session),
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 12),
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),

          // Status badge
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.getSpacing(context, 8),
              vertical: Responsive.getSpacing(context, 4),
            ),
            decoration: BoxDecoration(
              color: _getStatusColor(session.status).withOpacity(0.2),
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 8),
              ),
            ),
            child: Text(
              _getStatusText(session.status),
              style: TextStyle(
                fontSize: Responsive.getFontSize(context, 10),
                fontWeight: FontWeight.w600,
                color: _getStatusColor(session.status),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return const Color(AppConstants.sereneBlue);
      case 'completed':
        return const Color(AppConstants.mintGreen);
      case 'cancelled':
        return Colors.red[400]!;
      default:
        return Colors.grey[400]!;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return 'Upcoming';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }

  String _formatSessionTime(Session session) {
    final now = DateTime.now();
    final sessionTime = session.scheduledAt;
    final difference = sessionTime.difference(now);

    if (session.status == 'completed') {
      return 'Completed ${_formatDate(session.completedAt ?? sessionTime)}';
    } else if (session.status == 'scheduled') {
      if (difference.inDays > 0) {
        return 'In ${difference.inDays} day${difference.inDays == 1 ? '' : 's'}';
      } else if (difference.inHours > 0) {
        return 'In ${difference.inHours} hour${difference.inHours == 1 ? '' : 's'}';
      } else if (difference.inMinutes > 0) {
        return 'In ${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'}';
      } else {
        return 'Starting soon';
      }
    } else {
      return _formatDate(sessionTime);
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today at ${_formatTime(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday at ${_formatTime(date)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  String _formatTime(DateTime date) {
    final hour = date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }
}
