import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class RevenueChart extends StatelessWidget {
  const RevenueChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppTheme.marginMobile),
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.onSurface.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trend Omzet',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppTheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.trending_up,
                      size: 16,
                      color: AppTheme.secondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+12%',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: AppTheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),
          
          // Mock Chart
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomPaint(
              painter: _RevenueBars(),
              child: Container(),
            ),
          ),
          
          const SizedBox(height: AppTheme.spaceSm),
          
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLegendItem('Sen', '1.8M', false),
              _buildLegendItem('Sel', '2.1M', false),
              _buildLegendItem('Rab', '1.9M', false),
              _buildLegendItem('Kam', '2.4M', true),
              _buildLegendItem('Jum', '2.7M', false),
              _buildLegendItem('Sab', '3.1M', false),
              _buildLegendItem('Min', '2.8M', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String day, String value, bool isToday) {
    return Column(
      children: [
        Text(
          day,
          style: TextStyle(
            fontSize: 11,
            color: isToday ? AppTheme.primary : AppTheme.onSurfaceVariant,
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 10,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _RevenueBars extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    final barWidth = size.width / 9;
    final maxHeight = size.height - 20;
    
    // Sample data (heights as percentages)
    final heights = [0.6, 0.7, 0.65, 0.8, 0.9, 1.0, 0.85];
    final colors = [
      AppTheme.primary.withValues(alpha: 0.6),
      AppTheme.primary.withValues(alpha: 0.6),
      AppTheme.primary.withValues(alpha: 0.6),
      AppTheme.primary, // Today
      AppTheme.primary.withValues(alpha: 0.6),
      AppTheme.primary.withValues(alpha: 0.6),
      AppTheme.primary.withValues(alpha: 0.6),
    ];
    
    for (int i = 0; i < heights.length; i++) {
      paint.color = colors[i];
      final barHeight = maxHeight * heights[i];
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          (i + 1) * barWidth - barWidth * 0.4,
          size.height - barHeight,
          barWidth * 0.8,
          barHeight,
        ),
        const Radius.circular(4),
      );
      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}