import 'package:flutter/material.dart';
import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../domain/entities/health_metric.dart';

class MoodDetailScreen extends StatelessWidget {
  final HealthMetric moodMetric;

  const MoodDetailScreen({super.key, required this.moodMetric});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Mood Tracking',
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

            // Current Mood Card
            _buildCurrentMoodCard(context),
            SizedBox(height: Responsive.getSpacing(context, 24)),

            // Weekly Mood Chart
            _buildWeeklyMoodCard(context),
            SizedBox(height: Responsive.getSpacing(context, 24)),

            // Mood Patterns
            _buildMoodPatternsCard(context),
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
            Colors.purple.withValues(alpha: 0.1),
            Colors.purple.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 16),
        ),
        border: Border.all(
          color: Colors.purple.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(Responsive.getSpacing(context, 8)),
                decoration: BoxDecoration(
                  color: Colors.purple.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(
                    Responsive.getBorderRadius(context, 8),
                  ),
                ),
                child: Icon(
                  Icons.mood,
                  color: Colors.purple,
                  size: Responsive.getFontSize(context, 20),
                ),
              ),
              SizedBox(width: Responsive.getSpacing(context, 12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mood Tracking',
                      style: TextStyle(
                        fontSize: Responsive.getFontSize(context, 18),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Emotional Well-being Monitor',
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
            'Mood tracking helps identify patterns in your emotional well-being. Regular monitoring can reveal triggers, seasonal patterns, and the effectiveness of treatment approaches.',
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

  Widget _buildCurrentMoodCard(BuildContext context) {
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
            'Current Mood',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 16),
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          _buildMoodEmoji(context, moodMetric.value),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          Text(
            _getMoodDescription(moodMetric.value),
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 8)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.getSpacing(context, 12),
              vertical: Responsive.getSpacing(context, 6),
            ),
            decoration: BoxDecoration(
              color: _getMoodColor(moodMetric.value).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 20),
              ),
            ),
            child: Text(
              '${moodMetric.value}/10',
              style: TextStyle(
                fontSize: Responsive.getFontSize(context, 12),
                fontWeight: FontWeight.w600,
                color: _getMoodColor(moodMetric.value),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodEmoji(BuildContext context, double moodValue) {
    String emoji;
    if (moodValue >= 8)
      emoji = '😊';
    else if (moodValue >= 6)
      emoji = '🙂';
    else if (moodValue >= 4)
      emoji = '😐';
    else if (moodValue >= 2)
      emoji = '😔';
    else
      emoji = '😢';

    return Text(
      emoji,
      style: TextStyle(fontSize: Responsive.getFontSize(context, 48)),
    );
  }

  Widget _buildWeeklyMoodCard(BuildContext context) {
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
            '7-Day Mood Trend',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          Container(
            height: Responsive.getFontSize(context, 200),
            child: _buildMoodChart(context),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMoodDay(context, 'Mon', 7.0, '😊'),
              _buildMoodDay(context, 'Tue', 6.0, '🙂'),
              _buildMoodDay(context, 'Wed', 4.0, '😐'),
              _buildMoodDay(context, 'Thu', 8.0, '😊'),
              _buildMoodDay(context, 'Fri', 5.0, '😐'),
              _buildMoodDay(context, 'Sat', 9.0, '😊'),
              _buildMoodDay(context, 'Sun', 7.0, '😊'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoodChart(BuildContext context) {
    return CustomPaint(size: Size.infinite, painter: MoodChartPainter());
  }

  Widget _buildMoodDay(
    BuildContext context,
    String day,
    double value,
    String emoji,
  ) {
    return Column(
      children: [
        Text(
          emoji,
          style: TextStyle(fontSize: Responsive.getFontSize(context, 20)),
        ),
        SizedBox(height: Responsive.getSpacing(context, 4)),
        Text(
          day,
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 10),
            color: Colors.grey[500],
          ),
        ),
        SizedBox(height: Responsive.getSpacing(context, 2)),
        Text(
          '${value.toInt()}',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 10),
            color: _getMoodColor(value),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMoodPatternsCard(BuildContext context) {
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
            'Mood Patterns',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          _buildPatternItem(
            context,
            'Best Day',
            'Saturday',
            '9/10',
            Icons.trending_up,
          ),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildPatternItem(
            context,
            'Average Mood',
            '7.1/10',
            'This Week',
            Icons.analytics,
          ),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildPatternItem(
            context,
            'Consistency',
            '85%',
            'Stable',
            Icons.trending_flat,
          ),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildPatternItem(
            context,
            'Improvement',
            '+1.2',
            'vs Last Week',
            Icons.trending_up,
          ),
        ],
      ),
    );
  }

  Widget _buildPatternItem(
    BuildContext context,
    String label,
    String value,
    String subtitle,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(Responsive.getSpacing(context, 8)),
          decoration: BoxDecoration(
            color: Colors.purple.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(
              Responsive.getBorderRadius(context, 8),
            ),
          ),
          child: Icon(
            icon,
            color: Colors.purple,
            size: Responsive.getFontSize(context, 16),
          ),
        ),
        SizedBox(width: Responsive.getSpacing(context, 12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: Responsive.getFontSize(context, 14),
                  color: Colors.grey[400],
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: Responsive.getFontSize(context, 16),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 12),
            color: Colors.grey[500],
          ),
        ),
      ],
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
            'Positive Trend',
            'Your mood has been consistently positive this week. Great job!',
            Icons.trending_up,
            const Color(AppConstants.mintGreen),
          ),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildInsightItem(
            context,
            'Weekend Boost',
            'Weekends show higher mood scores. Consider incorporating weekend activities into weekdays.',
            Icons.weekend,
            Colors.blue,
          ),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildInsightItem(
            context,
            'Consistency',
            'Maintaining stable mood patterns. Continue your current wellness routine.',
            Icons.trending_flat,
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

  String _getMoodDescription(double moodValue) {
    if (moodValue >= 8) return 'Excellent';
    if (moodValue >= 6) return 'Good';
    if (moodValue >= 4) return 'Neutral';
    if (moodValue >= 2) return 'Low';
    return 'Very Low';
  }

  Color _getMoodColor(double moodValue) {
    if (moodValue >= 8) return const Color(AppConstants.mintGreen);
    if (moodValue >= 6) return Colors.blue;
    if (moodValue >= 4) return Colors.orange;
    if (moodValue >= 2) return Colors.red;
    return Colors.red[800]!;
  }
}

class MoodChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = Colors.purple.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();
    final points = [0.7, 0.6, 0.4, 0.8, 0.6, 0.7, 0.9, 0.5, 0.7, 0.9, 0.7, 0.7];

    for (int i = 0; i < points.length; i++) {
      final x = (i / (points.length - 1)) * size.width;
      final y = (1 - points[i]) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
