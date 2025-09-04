import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/health_metric.dart';
import '../screens/health_metrics/hrv_detail_screen.dart';
import '../screens/health_metrics/mood_detail_screen.dart';
import '../screens/health_metrics/sleep_detail_screen.dart';
import '../screens/health_metrics/anxiety_detail_screen.dart';

class HealthMetricsCard extends StatelessWidget {
  final List<HealthMetric> healthMetrics;

  const HealthMetricsCard({super.key, required this.healthMetrics});

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
                'Health Metrics',
                style: TextStyle(
                  fontSize: Responsive.getFontSize(context, 18),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.favorite_outline,
                color: const Color(AppConstants.mintGreen),
                size: Responsive.getFontSize(context, 24),
              ),
            ],
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          _buildMetricsGrid(context),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Responsive.getSpacing(context, 12),
        mainAxisSpacing: Responsive.getSpacing(context, 12),
        childAspectRatio: 1.5,
      ),
      itemCount: healthMetrics.length,
      itemBuilder: (context, index) {
        final metric = healthMetrics[index];
        return _buildMetricItem(context, metric);
      },
    );
  }

  Widget _buildMetricItem(BuildContext context, HealthMetric metric) {
    return GestureDetector(
      onTap: () => _navigateToDetailScreen(context, metric),
      child: Container(
        padding: Responsive.getDynamicPadding(context, basePadding: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(
            Responsive.getBorderRadius(context, 12),
          ),
          border: Border.all(
            color: _getMetricColor(metric.type).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  _getMetricIcon(metric.type),
                  color: _getMetricColor(metric.type),
                  size: Responsive.getFontSize(context, 20),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.getSpacing(context, 8),
                    vertical: Responsive.getSpacing(context, 4),
                  ),
                  decoration: BoxDecoration(
                    color: _getMetricColor(metric.type).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(
                      Responsive.getBorderRadius(context, 8),
                    ),
                  ),
                  child: Text(
                    _getMetricStatus(metric),
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(context, 10),
                      fontWeight: FontWeight.w600,
                      color: _getMetricColor(metric.type),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  metric.type,
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 12),
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: Responsive.getSpacing(context, 4)),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${metric.value}',
                        style: TextStyle(
                          fontSize: Responsive.getFontSize(context, 18),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      if (metric.unit != null)
                        TextSpan(
                          text: ' ${metric.unit}',
                          style: TextStyle(
                            fontSize: Responsive.getFontSize(context, 12),
                            color: Colors.grey[400],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetailScreen(BuildContext context, HealthMetric metric) {
    Widget screen;

    switch (metric.type.toLowerCase()) {
      case 'hrv':
        screen = HRVDetailScreen(hrvMetric: metric);
        break;
      case 'mood':
        screen = MoodDetailScreen(moodMetric: metric);
        break;
      case 'sleep':
        screen = SleepDetailScreen(sleepMetric: metric);
        break;
      case 'anxiety':
        screen = AnxietyDetailScreen(anxietyMetric: metric);
        break;
      default:
        return; // Don't navigate for unknown metrics
    }

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }

  Color _getMetricColor(String type) {
    switch (type.toLowerCase()) {
      case 'hrv':
        return const Color(AppConstants.sereneBlue);
      case 'mood':
        return const Color(AppConstants.mintGreen);
      case 'sleep':
        return const Color(AppConstants.softLavender);
      case 'anxiety':
        return Colors.orange[400]!;
      default:
        return const Color(AppConstants.mintGreen);
    }
  }

  IconData _getMetricIcon(String type) {
    switch (type.toLowerCase()) {
      case 'hrv':
        return Icons.favorite;
      case 'mood':
        return Icons.sentiment_very_satisfied;
      case 'sleep':
        return Icons.bedtime;
      case 'anxiety':
        return Icons.psychology;
      default:
        return Icons.analytics;
    }
  }

  String _getMetricStatus(HealthMetric metric) {
    switch (metric.type.toLowerCase()) {
      case 'hrv':
        return metric.value > 40 ? 'Good' : 'Low';
      case 'mood':
        return metric.value > 7
            ? 'Great'
            : metric.value > 5
            ? 'Good'
            : 'Low';
      case 'sleep':
        return metric.value > 7 ? 'Good' : 'Poor';
      case 'anxiety':
        return metric.value < 4
            ? 'Low'
            : metric.value < 7
            ? 'Moderate'
            : 'High';
      default:
        return 'Normal';
    }
  }
}
