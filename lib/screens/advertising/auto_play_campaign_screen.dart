import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/services/advertising_service.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/advertising/ads_bottom_navigation.dart';

class AutoPlayCampaignScreen extends StatefulWidget {
  const AutoPlayCampaignScreen({super.key});

  @override
  State<AutoPlayCampaignScreen> createState() => _AutoPlayCampaignScreenState();
}

class _AutoPlayCampaignScreenState extends State<AutoPlayCampaignScreen> {
  late bool _isAutoPlayOn;
  late List<String> _times;
  late List<String> _platforms;
  late double _radiusKm;

  @override
  void initState() {
    super.initState();
    final config = AdvertisingService().autoPlayConfig;
    _isAutoPlayOn = config.isEnabled;
    _times = List.from(config.scheduleTimes);
    _platforms = List.from(config.platforms);
    _radiusKm = config.targetRadiusKm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('AUTO PLAY Campaign', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: AppTheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Switch Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _isAutoPlayOn
                      ? [const Color(0xFF924700), const Color(0xFFB75B00)]
                      : [Colors.grey[700]!, Colors.grey[800]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: (_isAutoPlayOn ? const Color(0xFF924700) : Colors.black).withValues(alpha: 0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.flash_on, color: Colors.white, size: 28),
                          ),
                          const SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AUTO PLAY',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              Text(
                                'Otomasi Promosi Multi-Channel',
                                style: TextStyle(fontSize: 12, color: Colors.white70),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Switch(
                        value: _isAutoPlayOn,
                        activeThumbColor: const Color(0xFFA3F69C),
                        activeTrackColor: Colors.white.withValues(alpha: 0.3),
                        onChanged: (val) {
                          setState(() {
                            _isAutoPlayOn = val;
                            AdvertisingService().autoPlayConfig.isEnabled = val;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(val ? 'AUTO PLAY Diaktifkan!' : 'AUTO PLAY Dinonaktifkan'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Promosikan usaha Anda secara otomatis sesuai jadwal.',
                    style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.schedule, color: Color(0xFFA3F69C), size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Next Promotion', style: TextStyle(color: Colors.white70, fontSize: 11)),
                              Text(
                                _isAutoPlayOn ? '19:00 Hari Ini (Makan Malam & Nongkrong)' : 'Otomasi sedang jeda',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Daily Schedule Visual Timeline
            const Text(
              'Jadwal Publikasi Harian (3x per Hari)',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Waktu terbaik saat calon pembeli lapar dan bersantai.',
              style: TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant),
            ),
            const SizedBox(height: 14),

            _buildScheduleTimelineItem(
              time: '08:00 WIB',
              label: 'Slot Pagi: Sarapan & Kopi Santai',
              platforms: 'Instagram + TikTok',
              status: 'Selesai Tayang (Hari Ini)',
              isDone: true,
            ),
            _buildScheduleTimelineItem(
              time: '14:00 WIB',
              label: 'Slot Siang: Makan Siang & Es Segar',
              platforms: 'Instagram + FB + TikTok',
              status: 'Selesai Tayang (Hari Ini)',
              isDone: true,
            ),
            _buildScheduleTimelineItem(
              time: '19:00 WIB',
              label: 'Slot Malam: Kuliner Makan Malam & Nongkrong',
              platforms: 'Instagram + TikTok + Facebook',
              status: 'Terjadwal (Akan Tayang)',
              isDone: false,
              isNext: true,
            ),
            const SizedBox(height: 20),

            // Platforms Distribution
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.surfaceVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Platform Media Sosial Terhubung', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildPlatformBadge('Instagram', '📸', true),
                      _buildPlatformBadge('TikTok', '🎵', true),
                      _buildPlatformBadge('Facebook', '📘', true),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Radius Target
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.surfaceVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Radius Jangkauan Siaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text('${_radiusKm.toInt()} KM', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF924700), fontSize: 14)),
                    ],
                  ),
                  Slider(
                    value: _radiusKm,
                    min: 1.0,
                    max: 10.0,
                    divisions: 9,
                    activeColor: const Color(0xFF924700),
                    onChanged: (v) => setState(() {
                      _radiusKm = v;
                      AdvertisingService().autoPlayConfig.targetRadiusKm = v;
                    }),
                  ),
                  const Text(
                    'Promosi otomatis disebar khusus ke calon pelanggan dalam radius ini.',
                    style: TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AdsBottomNavigation(currentIndex: 2),
    );
  }

  Widget _buildScheduleTimelineItem({
    required String time,
    required String label,
    required String platforms,
    required String status,
    bool isDone = false,
    bool isNext = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isNext ? const Color(0xFFFFDCC6).withValues(alpha: 0.4) : AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isNext ? const Color(0xFF924700) : AppTheme.surfaceVariant,
          width: isNext ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDone
                  ? AppTheme.secondaryContainer
                  : (isNext ? const Color(0xFFFFDCC6) : AppTheme.surfaceContainerHigh),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isDone ? Icons.check_circle : (isNext ? Icons.play_arrow : Icons.schedule),
              color: isDone
                  ? AppTheme.secondary
                  : (isNext ? const Color(0xFF924700) : AppTheme.outline),
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(time, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isDone ? AppTheme.secondary : (isNext ? const Color(0xFF924700) : AppTheme.onSurfaceVariant),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant)),
                const SizedBox(height: 4),
                Text('Channel: $platforms', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.primary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformBadge(String name, String icon, bool isConnected) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppTheme.surfaceContainerLow,
          child: Text(icon, style: const TextStyle(fontSize: 22)),
        ),
        const SizedBox(height: 6),
        Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Color(0xFF1B6D24), size: 12),
            SizedBox(width: 2),
            Text('Aktif', style: TextStyle(color: Color(0xFF1B6D24), fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
