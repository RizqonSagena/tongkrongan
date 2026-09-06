import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/models/advertising.dart';
import 'package:tongkrongan_umkm_owner_app/services/advertising_service.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class AdvertisingCalendarScreen extends StatefulWidget {
  const AdvertisingCalendarScreen({super.key});

  @override
  State<AdvertisingCalendarScreen> createState() => _AdvertisingCalendarScreenState();
}

class _AdvertisingCalendarScreenState extends State<AdvertisingCalendarScreen> {
  int _selectedDayIndex = 0;
  final List<String> _days = ['Hari Ini (Sabtu, 5)', 'Besok (Minggu, 6)', 'Senin, 7', 'Selasa, 8', 'Rabu, 9'];

  @override
  Widget build(BuildContext context) {
    final events = AdvertisingService().calendarEvents;

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Kalender Iklan & Promosi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: AppTheme.surface,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Days Horizontal Carousel
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: AppTheme.surfaceContainerLow,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _days.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedDayIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(_days[index]),
                    selected: isSelected,
                    selectedColor: const Color(0xFFFFDCC6),
                    labelStyle: TextStyle(
                      color: isSelected ? const Color(0xFF924700) : AppTheme.onSurfaceVariant,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12,
                    ),
                    onSelected: (val) {
                      if (val) setState(() => _selectedDayIndex = index);
                    },
                  ),
                );
              },
            ),
          ),

          // Status Legend
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLegendItem('Published', const Color(0xFF1B6D24)),
                _buildLegendItem('Scheduled', const Color(0xFF924700)),
                _buildLegendItem('Paused', Colors.orange[800]!),
                _buildLegendItem('Failed', Colors.red),
              ],
            ),
          ),
          const Divider(height: 1),

          // Event Timeline
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final evt = events[index];
                return _buildEventCard(evt);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildEventCard(PromotionEvent evt) {
    Color badgeColor;
    Color textColor;
    IconData icon;

    switch (evt.status) {
      case PromotionEventStatus.published:
        badgeColor = const Color(0xFFA3F69C);
        textColor = const Color(0xFF005312);
        icon = Icons.check_circle_outline;
        break;
      case PromotionEventStatus.scheduled:
        badgeColor = const Color(0xFFFFDCC6);
        textColor = const Color(0xFF924700);
        icon = Icons.schedule;
        break;
      case PromotionEventStatus.paused:
        badgeColor = Colors.orange[100]!;
        textColor = Colors.orange[900]!;
        icon = Icons.pause_circle_outline;
        break;
      case PromotionEventStatus.failed:
        badgeColor = Colors.red[100]!;
        textColor = Colors.red[900]!;
        icon = Icons.error_outline;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.surfaceVariant),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: badgeColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: textColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      evt.campaignName,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        evt.status.displayName,
                        style: TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${evt.date} • ${evt.scheduledTime}',
                  style: const TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant),
                ),
                const SizedBox(height: 2),
                Text(
                  'Channel: ${evt.platform}',
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
