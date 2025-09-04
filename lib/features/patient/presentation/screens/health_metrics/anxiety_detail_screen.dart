import 'package:flutter/material.dart';
import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../domain/entities/health_metric.dart';

class AnxietyDetailScreen extends StatelessWidget {
  final HealthMetric anxietyMetric;

  const AnxietyDetailScreen({super.key, required this.anxietyMetric});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Anxiety Level',
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

            // Current Anxiety Level
            _buildCurrentAnxietyCard(context),
            SizedBox(height: Responsive.getSpacing(context, 24)),

            // Weekly Anxiety Trend
            _buildWeeklyAnxietyCard(context),
            SizedBox(height: Responsive.getSpacing(context, 24)),

            // Anxiety Triggers
            _buildTriggersCard(context),
            SizedBox(height: Responsive.getSpacing(context, 24)),

            // Coping Strategies
            _buildCopingStrategiesCard(context),
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
            Colors.orange.withValues(alpha: 0.1),
            Colors.orange.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 16),
        ),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.3),
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
                  color: Colors.orange.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(
                    Responsive.getBorderRadius(context, 8),
                  ),
                ),
                child: Icon(
                  Icons.psychology,
                  color: Colors.orange,
                  size: Responsive.getFontSize(context, 20),
                ),
              ),
              SizedBox(width: Responsive.getSpacing(context, 12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Anxiety Level',
                      style: TextStyle(
                        fontSize: Responsive.getFontSize(context, 18),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Stress & Worry Monitor',
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
            'Anxiety tracking helps identify patterns in your stress levels and worry. Understanding these patterns can help develop effective coping strategies and treatment approaches.',
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

  Widget _buildCurrentAnxietyCard(BuildContext context) {
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
            'Current Anxiety Level',
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
                  value: anxietyMetric.value / 10,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey[800],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getAnxietyColor(anxietyMetric.value),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    '${anxietyMetric.value}/10',
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(context, 32),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _getAnxietyLevel(anxietyMetric.value),
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(context, 12),
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          Text(
            _getAnxietyDescription(anxietyMetric.value),
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 14),
              color: Colors.grey[300],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyAnxietyCard(BuildContext context) {
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
            '7-Day Anxiety Trend',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          Container(
            height: Responsive.getFontSize(context, 200),
            child: _buildAnxietyChart(context),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAnxietyDay(context, 'Mon', 3.0, 'Low'),
              _buildAnxietyDay(context, 'Tue', 5.0, 'Moderate'),
              _buildAnxietyDay(context, 'Wed', 7.0, 'High'),
              _buildAnxietyDay(context, 'Thu', 4.0, 'Low'),
              _buildAnxietyDay(context, 'Fri', 6.0, 'Moderate'),
              _buildAnxietyDay(context, 'Sat', 2.0, 'Low'),
              _buildAnxietyDay(context, 'Sun', 3.0, 'Low'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnxietyChart(BuildContext context) {
    return CustomPaint(size: Size.infinite, painter: AnxietyChartPainter());
  }

  Widget _buildAnxietyDay(
    BuildContext context,
    String day,
    double value,
    String level,
  ) {
    return Column(
      children: [
        Container(
          width: Responsive.getFontSize(context, 8),
          height: Responsive.getFontSize(context, value * 6.0),
          decoration: BoxDecoration(
            color: _getAnxietyColor(value),
            borderRadius: BorderRadius.circular(
              Responsive.getBorderRadius(context, 4),
            ),
          ),
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
          level,
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 8),
            color: _getAnxietyColor(value),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTriggersCard(BuildContext context) {
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
            'Common Triggers',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          _buildTriggerItem(context, 'Work Stress', 75.0, Icons.work),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildTriggerItem(context, 'Social Situations', 60.0, Icons.people),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildTriggerItem(
            context,
            'Health Concerns',
            45.0,
            Icons.health_and_safety,
          ),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildTriggerItem(
            context,
            'Financial Worries',
            55.0,
            Icons.account_balance_wallet,
          ),
        ],
      ),
    );
  }

  Widget _buildTriggerItem(
    BuildContext context,
    String trigger,
    double frequency,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(Responsive.getSpacing(context, 8)),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(
              Responsive.getBorderRadius(context, 8),
            ),
          ),
          child: Icon(
            icon,
            color: Colors.orange,
            size: Responsive.getFontSize(context, 16),
          ),
        ),
        SizedBox(width: Responsive.getSpacing(context, 12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                trigger,
                style: TextStyle(
                  fontSize: Responsive.getFontSize(context, 14),
                  color: Colors.white,
                ),
              ),
              Text(
                'Trigger frequency',
                style: TextStyle(
                  fontSize: Responsive.getFontSize(context, 12),
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
        Text(
          '${frequency.toInt()}%',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 14),
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildCopingStrategiesCard(BuildContext context) {
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
            'Effective Coping Strategies',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          _buildStrategyItem(
            context,
            'Deep Breathing',
            '85% effective',
            Icons.air,
          ),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildStrategyItem(
            context,
            'Meditation',
            '78% effective',
            Icons.self_improvement,
          ),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildStrategyItem(
            context,
            'Physical Exercise',
            '72% effective',
            Icons.fitness_center,
          ),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildStrategyItem(
            context,
            'Journaling',
            '68% effective',
            Icons.edit,
          ),
        ],
      ),
    );
  }

  Widget _buildStrategyItem(
    BuildContext context,
    String strategy,
    String effectiveness,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(Responsive.getSpacing(context, 8)),
          decoration: BoxDecoration(
            color: const Color(AppConstants.mintGreen).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(
              Responsive.getBorderRadius(context, 8),
            ),
          ),
          child: Icon(
            icon,
            color: const Color(AppConstants.mintGreen),
            size: Responsive.getFontSize(context, 16),
          ),
        ),
        SizedBox(width: Responsive.getSpacing(context, 12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                strategy,
                style: TextStyle(
                  fontSize: Responsive.getFontSize(context, 14),
                  color: Colors.white,
                ),
              ),
              Text(
                effectiveness,
                style: TextStyle(
                  fontSize: Responsive.getFontSize(context, 12),
                  color: Colors.grey[400],
                ),
              ),
            ],
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
            'Low Anxiety Week',
            'Your anxiety levels have been consistently low this week. Great progress!',
            Icons.trending_down,
            const Color(AppConstants.mintGreen),
          ),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildInsightItem(
            context,
            'Weekend Relief',
            'Weekends show significantly lower anxiety. Consider incorporating weekend relaxation techniques into weekdays.',
            Icons.weekend,
            Colors.blue,
          ),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildInsightItem(
            context,
            'Coping Success',
            'Your coping strategies are working well. Continue practicing deep breathing and meditation.',
            Icons.check_circle,
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

  String _getAnxietyLevel(double level) {
    if (level <= 2) return 'Very Low';
    if (level <= 4) return 'Low';
    if (level <= 6) return 'Moderate';
    if (level <= 8) return 'High';
    return 'Very High';
  }

  String _getAnxietyDescription(double level) {
    if (level <= 2) return 'Feeling calm and relaxed';
    if (level <= 4) return 'Mild worry, manageable stress';
    if (level <= 6) return 'Moderate anxiety, some discomfort';
    if (level <= 8) return 'High anxiety, significant distress';
    return 'Severe anxiety, immediate attention needed';
  }

  Color _getAnxietyColor(double level) {
    if (level <= 2) return const Color(AppConstants.mintGreen);
    if (level <= 4) return Colors.blue;
    if (level <= 6) return Colors.orange;
    if (level <= 8) return Colors.red;
    return Colors.red[800]!;
  }
}

class AnxietyChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = Colors.orange.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();
    final points = [0.3, 0.5, 0.7, 0.8, 0.4, 0.6, 0.3, 0.2, 0.6, 0.3, 0.3, 0.3];

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
