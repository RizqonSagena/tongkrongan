import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/services/advertising_service.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/advertising/ads_bottom_navigation.dart';

class AdvertisingAnalyticsScreen extends StatefulWidget {
  const AdvertisingAnalyticsScreen({super.key});

  @override
  State<AdvertisingAnalyticsScreen> createState() => _AdvertisingAnalyticsScreenState();
}

class _AdvertisingAnalyticsScreenState extends State<AdvertisingAnalyticsScreen> {
  String _selectedPeriod = '30 Hari Terakhir';
  final List<String> _periods = ['7 Hari Terakhir', '30 Hari Terakhir', 'Bulan Ini', 'Sepanjang Waktu'];

  @override
  Widget build(BuildContext context) {
    final campaigns = AdvertisingService().campaigns;
    final totalReach = campaigns.fold<int>(0, (sum, c) => sum + c.reach);
    final totalImpressions = campaigns.fold<int>(0, (sum, c) => sum + c.impressions);
    final totalClicks = campaigns.fold<int>(0, (sum, c) => sum + c.clicks);
    final totalCustomers = campaigns.fold<int>(0, (sum, c) => sum + c.estimatedCustomers);
    final totalSpend = campaigns.fold<double>(0, (sum, c) => sum + c.spending);

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Analitik & ROI Promosi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: AppTheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.surfaceVariant),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedPeriod,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF924700)),
                  items: _periods.map((p) => DropdownMenuItem(value: p, child: Text(p, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))).toList(),
                  onChanged: (val) => setState(() => _selectedPeriod = val!),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Spend vs Return Spotlight
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF924700), Color(0xFFAD2C00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Total Belanja Iklan', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          const SizedBox(height: 4),
                          Text(
                            'Rp${totalSpend.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFA3F69C),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text('ROI: 3.4x 📈', style: TextStyle(color: Color(0xFF005312), fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildWhiteStat('Konversi Konsumen', '+$totalCustomers Orang'),
                      _buildWhiteStat('Rata-rata CPC', 'Rp165 / Klik'),
                      _buildWhiteStat('Rata-rata CTR', '4.2%'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Performance Over Time Chart Representation
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
                  const Text('Tren Jangkauan Harian (Reach)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 4),
                  const Text('Peningkatan jangkauan setelah aktivasi AUTO PLAY', style: TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant)),
                  const SizedBox(height: 16),

                  // Simple Bar Chart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildBarCol('Sen', 0.45, '4.2K'),
                      _buildBarCol('Sel', 0.60, '6.1K'),
                      _buildBarCol('Rab', 0.55, '5.8K'),
                      _buildBarCol('Kam', 0.70, '7.5K'),
                      _buildBarCol('Jum', 0.90, '11.2K'),
                      _buildBarCol('Sab', 1.00, '14.5K'),
                      _buildBarCol('Min', 0.85, '10.8K'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Platform Comparison
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
                  const Text('Perbandingan Efektivitas Platform', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 14),
                  _buildPlatformShareRow('TikTok (FYP Lokal)', '48% Interaksi', 0.48, Colors.black),
                  _buildPlatformShareRow('Instagram (Reels & Story)', '38% Interaksi', 0.38, const Color(0xFFE1306C)),
                  _buildPlatformShareRow('Facebook (Grup Kuliner)', '14% Interaksi', 0.14, const Color(0xFF1877F2)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Campaign Comparison
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
                  const Text('Perbandingan Performa Kampanye', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 12),
                  ...campaigns.map((c) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(c.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(height: 2),
                              Text('Klik: ${c.clicks} • Pelanggan: ${c.estimatedCustomers}', style: const TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant)),
                            ],
                          ),
                        ),
                        Text('${c.engagementRate}% Eng.', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF924700), fontSize: 13)),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AdsBottomNavigation(currentIndex: 4),
    );
  }

  Widget _buildWhiteStat(String label, String val) {
    return Column(
      children: [
        Text(val, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
      ],
    );
  }

  Widget _buildBarCol(String day, double heightPct, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(value, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppTheme.onSurfaceVariant)),
        const SizedBox(height: 4),
        Container(
          width: 24,
          height: 90 * heightPct,
          decoration: BoxDecoration(
            color: heightPct > 0.8 ? const Color(0xFF924700) : const Color(0xFFFFDCC6),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(day, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.onSurface)),
      ],
    );
  }

  Widget _buildPlatformShareRow(String name, String shareText, double pct, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              Text(shareText, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              backgroundColor: AppTheme.surfaceContainerHigh,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
