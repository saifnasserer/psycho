import 'package:flutter/material.dart';
import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../domain/entities/health_metric.dart';

class SleepDetailScreen extends StatelessWidget {
  final HealthMetric sleepMetric;

  const SleepDetailScreen({super.key, required this.sleepMetric});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Sleep Quality',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 18),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: Responsive.getFontSize(context, 24),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.getSpacing(context, 20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Card
            _buildSummaryCard(context),
            SizedBox(height: Responsive.getSpacing(context, 24)),

            // Sleep Score Card
            _buildSleepScoreCard(context),
            SizedBox(height: Responsive.getSpacing(context, 24)),

            // Sleep Stages Chart
            _buildSleepStagesCard(context),
            SizedBox(height: Responsive.getSpacing(context, 24)),

            // Sleep Statistics
            _buildSleepStatsCard(context),
            SizedBox(height: Responsive.getSpacing(context, 24)),

            // Insights and Recommendations
            _buildInsightsCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.getSpacing(context, 20)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withValues(alpha: 0.1),
            Colors.blue.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 16),
        ),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(Responsive.getSpacing(context, 8)),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(
                    Responsive.getBorderRadius(context, 8),
                  ),
                ),
                child: Icon(
                  Icons.bedtime,
                  color: Colors.blue,
                  size: Responsive.getFontSize(context, 20),
                ),
              ),
              SizedBox(width: Responsive.getSpacing(context, 12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sleep Quality',
                      style: TextStyle(
                        fontSize: Responsive.getFontSize(context, 18),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Rest & Recovery Monitor',
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
          SizedBox(height: Responsive.getSpacing(context, 16)),
          Text(
            'Quality sleep is essential for mental health and recovery. This metric tracks your sleep patterns, duration, and quality to help optimize your rest.',
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

  Widget _buildSleepScoreCard(BuildContext context) {
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
        children: [
          Text(
            'Sleep Score',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 16),
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: Responsive.getFontSize(context, 120),
                height: Responsive.getFontSize(context, 120),
                child: CircularProgressIndicator(
                  value: sleepMetric.value / 100,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey[800],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getSleepColor(sleepMetric.value),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    '${sleepMetric.value}',
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(context, 32),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _getSleepQuality(sleepMetric.value),
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(context, 12),
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSleepStagesCard(BuildContext context) {
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
            'Sleep Stages',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          _buildSleepStage(context, 'Deep Sleep', '2h 15m', 25.0, Colors.blue),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildSleepStage(context, 'Light Sleep', '4h 30m', 50.0, Colors.cyan),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildSleepStage(context, 'REM Sleep', '1h 45m', 20.0, Colors.purple),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildSleepStage(context, 'Awake', '30m', 5.0, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildSleepStage(
    BuildContext context,
    String stage,
    String duration,
    double percentage,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: Responsive.getFontSize(context, 12),
          height: Responsive.getFontSize(context, 12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              Responsive.getBorderRadius(context, 6),
            ),
          ),
        ),
        SizedBox(width: Responsive.getSpacing(context, 12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stage,
                style: TextStyle(
                  fontSize: Responsive.getFontSize(context, 14),
                  color: Colors.white,
                ),
              ),
              Text(
                duration,
                style: TextStyle(
                  fontSize: Responsive.getFontSize(context, 12),
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
        Text(
          '${percentage.toInt()}%',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 14),
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildSleepStatsCard(BuildContext context) {
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
            'Sleep Statistics',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  context,
                  'Bedtime',
                  '10:30 PM',
                  Icons.bedtime,
                ),
              ),
              SizedBox(width: Responsive.getSpacing(context, 16)),
              Expanded(
                child: _buildStatItem(
                  context,
                  'Wake Time',
                  '6:45 AM',
                  Icons.wb_sunny,
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  context,
                  'Sleep Duration',
                  '8h 15m',
                  Icons.timer,
                ),
              ),
              SizedBox(width: Responsive.getSpacing(context, 16)),
              Expanded(
                child: _buildStatItem(
                  context,
                  'Efficiency',
                  '92%',
                  Icons.trending_up,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(Responsive.getSpacing(context, 16)),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 12),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.blue,
            size: Responsive.getFontSize(context, 24),
          ),
          SizedBox(height: Responsive.getSpacing(context, 8)),
          Text(
            value,
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 16),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 4)),
          Text(
            label,
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 12),
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsCard(BuildContext context) {
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
            'Insights & Recommendations',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          _buildInsightItem(
            context,
            'Excellent Sleep Quality',
            'Your sleep score indicates excellent rest and recovery.',
            Icons.check_circle,
            const Color(AppConstants.mintGreen),
          ),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildInsightItem(
            context,
            'Consistent Schedule',
            'Maintaining a regular bedtime routine is helping your sleep quality.',
            Icons.schedule,
            Colors.blue,
          ),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildInsightItem(
            context,
            'Deep Sleep Focus',
            'Consider relaxation techniques to increase deep sleep duration.',
            Icons.self_improvement,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(Responsive.getSpacing(context, 8)),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
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
        SizedBox(width: Responsive.getSpacing(context, 12)),
        Expanded(
          child: Column(
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
                description,
                style: TextStyle(
                  fontSize: Responsive.getFontSize(context, 12),
                  color: Colors.grey[400],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getSleepQuality(double score) {
    if (score >= 80) return 'Excellent';
    if (score >= 60) return 'Good';
    if (score >= 40) return 'Fair';
    return 'Poor';
  }

  Color _getSleepColor(double score) {
    if (score >= 80) return const Color(AppConstants.mintGreen);
    if (score >= 60) return Colors.blue;
    if (score >= 40) return Colors.orange;
    return Colors.red;
  }
}
