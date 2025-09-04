import 'package:flutter/material.dart';
import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../domain/entities/health_metric.dart';

class HRVDetailScreen extends StatelessWidget {
  final HealthMetric hrvMetric;

  const HRVDetailScreen({super.key, required this.hrvMetric});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Heart Rate Variability',
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

            // Current Value Card
            _buildCurrentValueCard(context),
            SizedBox(height: Responsive.getSpacing(context, 24)),

            // Weekly Trend Chart
            _buildWeeklyTrendCard(context),
            SizedBox(height: Responsive.getSpacing(context, 24)),

            // Monthly Statistics
            _buildMonthlyStatsCard(context),
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
            const Color(AppConstants.mintGreen).withValues(alpha: 0.1),
            const Color(AppConstants.mintGreen).withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 16),
        ),
        border: Border.all(
          color: const Color(AppConstants.mintGreen).withValues(alpha: 0.3),
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
                  color: const Color(
                    AppConstants.mintGreen,
                  ).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(
                    Responsive.getBorderRadius(context, 8),
                  ),
                ),
                child: Icon(
                  Icons.favorite,
                  color: const Color(AppConstants.mintGreen),
                  size: Responsive.getFontSize(context, 20),
                ),
              ),
              SizedBox(width: Responsive.getSpacing(context, 12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Heart Rate Variability',
                      style: TextStyle(
                        fontSize: Responsive.getFontSize(context, 18),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Autonomic Nervous System Health',
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
            'HRV measures the variation in time between heartbeats, indicating your body\'s ability to adapt to stress and recover. Higher HRV generally indicates better cardiovascular health and stress resilience.',
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

  Widget _buildCurrentValueCard(BuildContext context) {
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
            'Current HRV',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 16),
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 8)),
          Text(
            '${hrvMetric.value} ms',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 36),
              fontWeight: FontWeight.bold,
              color: const Color(AppConstants.mintGreen),
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 8)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.getSpacing(context, 12),
              vertical: Responsive.getSpacing(context, 6),
            ),
            decoration: BoxDecoration(
              color: _getHRVStatusColor().withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 20),
              ),
            ),
            child: Text(
              _getHRVStatus(),
              style: TextStyle(
                fontSize: Responsive.getFontSize(context, 12),
                fontWeight: FontWeight.w600,
                color: _getHRVStatusColor(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyTrendCard(BuildContext context) {
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
            '7-Day Trend',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          // Mock chart data
          Container(
            height: Responsive.getFontSize(context, 200),
            child: _buildMockChart(context),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTrendIndicator(context, 'Mon', 45, true),
              _buildTrendIndicator(context, 'Tue', 52, true),
              _buildTrendIndicator(context, 'Wed', 38, false),
              _buildTrendIndicator(context, 'Thu', 48, true),
              _buildTrendIndicator(context, 'Fri', 55, true),
              _buildTrendIndicator(context, 'Sat', 42, false),
              _buildTrendIndicator(context, 'Sun', 50, true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMockChart(BuildContext context) {
    return CustomPaint(size: Size.infinite, painter: HRVChartPainter());
  }

  Widget _buildTrendIndicator(
    BuildContext context,
    String day,
    int value,
    bool isGood,
  ) {
    return Column(
      children: [
        Container(
          width: Responsive.getFontSize(context, 8),
          height: Responsive.getFontSize(context, value.toDouble()),
          decoration: BoxDecoration(
            color: isGood ? const Color(AppConstants.mintGreen) : Colors.orange,
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
      ],
    );
  }

  Widget _buildMonthlyStatsCard(BuildContext context) {
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
            'Monthly Statistics',
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
                  'Average',
                  '47.2 ms',
                  Icons.trending_up,
                ),
              ),
              SizedBox(width: Responsive.getSpacing(context, 16)),
              Expanded(
                child: _buildStatItem(context, 'Best', '58.1 ms', Icons.star),
              ),
            ],
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  context,
                  'Lowest',
                  '32.4 ms',
                  Icons.trending_down,
                ),
              ),
              SizedBox(width: Responsive.getSpacing(context, 16)),
              Expanded(
                child: _buildStatItem(
                  context,
                  'Consistency',
                  '85%',
                  Icons.analytics,
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
            color: const Color(AppConstants.mintGreen),
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
            'Good Recovery',
            'Your HRV shows good recovery patterns. Continue your current routine.',
            Icons.check_circle,
            const Color(AppConstants.mintGreen),
          ),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildInsightItem(
            context,
            'Sleep Quality',
            'Consistent sleep schedule can improve HRV by 15-20%.',
            Icons.bedtime,
            Colors.blue,
          ),
          SizedBox(height: Responsive.getSpacing(context, 12)),
          _buildInsightItem(
            context,
            'Stress Management',
            'Consider meditation or breathing exercises to boost HRV.',
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

  String _getHRVStatus() {
    if (hrvMetric.value >= 50) return 'Excellent';
    if (hrvMetric.value >= 40) return 'Good';
    if (hrvMetric.value >= 30) return 'Fair';
    return 'Poor';
  }

  Color _getHRVStatusColor() {
    if (hrvMetric.value >= 50) return const Color(AppConstants.mintGreen);
    if (hrvMetric.value >= 40) return Colors.blue;
    if (hrvMetric.value >= 30) return Colors.orange;
    return Colors.red;
  }
}

class HRVChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(AppConstants.mintGreen)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    final points = [0.3, 0.6, 0.4, 0.7, 0.5, 0.8, 0.4, 0.6, 0.7, 0.5, 0.6, 0.8];

    for (int i = 0; i < points.length; i++) {
      final x = (i / (points.length - 1)) * size.width;
      final y = (1 - points[i]) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
