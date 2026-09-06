import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/models/advertising.dart';
import 'package:tongkrongan_umkm_owner_app/services/advertising_service.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/advertising/ads_bottom_navigation.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/common/role_switcher.dart';

class AdvertisingDashboardScreen extends StatefulWidget {
  const AdvertisingDashboardScreen({super.key});

  @override
  State<AdvertisingDashboardScreen> createState() => _AdvertisingDashboardScreenState();
}

class _AdvertisingDashboardScreenState extends State<AdvertisingDashboardScreen> {
  String _selectedFilter = 'SEMUA';

  @override
  Widget build(BuildContext context) {
    final adsService = AdvertisingService();
    final allCampaigns = adsService.campaigns;
    final autoPlay = adsService.autoPlayConfig;

    final activeCount = allCampaigns.where((c) => c.status == CampaignStatus.active).length;
    final totalReach = allCampaigns.fold<int>(0, (sum, c) => sum + c.reach);
    final totalImpressions = allCampaigns.fold<int>(0, (sum, c) => sum + c.impressions);
    final totalClicks = allCampaigns.fold<int>(0, (sum, c) => sum + c.clicks);
    final totalCustomers = allCampaigns.fold<int>(0, (sum, c) => sum + c.estimatedCustomers);

    var filteredCampaigns = allCampaigns;
    if (_selectedFilter == 'ACTIVE') {
      filteredCampaigns = allCampaigns.where((c) => c.status == CampaignStatus.active).toList();
    } else if (_selectedFilter == 'PAUSED') {
      filteredCampaigns = allCampaigns.where((c) => c.status == CampaignStatus.paused).toList();
    } else if (_selectedFilter == 'COMPLETED') {
      filteredCampaigns = allCampaigns.where((c) => c.status == CampaignStatus.completed).toList();
    }

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Smart Advertising', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Multi-Platform UMKM Ads Manager', style: TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant)),
          ],
        ),
        backgroundColor: AppTheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz, color: Color(0xFF924700)),
            tooltip: 'Ganti Mode',
            onPressed: () => RoleSwitcherSheet.show(context),
          ),
          IconButton(
            icon: const Icon(Icons.hub_outlined, color: AppTheme.onSurface),
            tooltip: 'Platform Media Sosial',
            onPressed: () => context.go('/platform-management'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AUTO PLAY Spotlight Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF924700), Color(0xFFB75B00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF924700).withValues(alpha: 0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'AUTO PLAY',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: autoPlay.isEnabled ? const Color(0xFFA3F69C) : Colors.grey[400],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                autoPlay.isEnabled ? 'ON' : 'OFF',
                                style: const TextStyle(color: Color(0xFF005312), fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Jadwal berikutnya: ${autoPlay.nextScheduledPromotion}',
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => context.go('/auto-play'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF924700),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    child: const Text('Kelola', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // KPI Grid
            const Text(
              'Performa Promosi Keseluruhan',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.onSurface),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.5,
              children: [
                _buildKPICard('Kampanye Aktif', '$activeCount Iklan', Icons.campaign, const Color(0xFF1B6D24)),
                _buildKPICard('Total Reach', '${(totalReach / 1000).toStringAsFixed(1)}K Orang', Icons.people_alt, const Color(0xFF924700)),
                _buildKPICard('Total Impression', '${(totalImpressions / 1000).toStringAsFixed(1)}K Kali', Icons.visibility, Colors.indigo),
                _buildKPICard('Taksiran Pelanggan', '+$totalCustomers Pembeli', Icons.storefront, AppTheme.primary),
              ],
            ),
            const SizedBox(height: 20),

            // Quick Actions (Buat Kampanye, Kalender Iklan)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => context.go('/create-campaign'),
                    icon: const Icon(Icons.add_circle_outline, size: 18),
                    label: const Text('Buat Iklan Baru', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => context.go('/advertising-calendar'),
                    icon: const Icon(Icons.calendar_month, size: 18, color: Color(0xFF924700)),
                    label: const Text('Kalender Iklan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF924700))),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFF924700)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Campaign Status Filters
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daftar Kampanye',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => context.go('/my-campaigns'),
                  child: const Text('Lihat Semua >', style: TextStyle(color: Color(0xFF924700), fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              children: ['SEMUA', 'ACTIVE', 'PAUSED', 'COMPLETED'].map((status) {
                final isSelected = _selectedFilter == status;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(status),
                    selected: isSelected,
                    selectedColor: const Color(0xFFFFDCC6),
                    labelStyle: TextStyle(
                      color: isSelected ? const Color(0xFF924700) : AppTheme.onSurfaceVariant,
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (val) {
                      if (val) setState(() => _selectedFilter = status);
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),

            // Campaign Cards List
            ...filteredCampaigns.map((camp) => _buildCampaignCard(context, camp)),
          ],
        ),
      ),
      bottomNavigationBar: const AdsBottomNavigation(currentIndex: 0),
    );
  }

  Widget _buildKPICard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.surfaceVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.onSurface),
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignCard(BuildContext context, AdCampaign camp) {
    Color statusColor;
    switch (camp.status) {
      case CampaignStatus.active:
        statusColor = const Color(0xFF1B6D24);
        break;
      case CampaignStatus.paused:
        statusColor = Colors.orange[800]!;
        break;
      case CampaignStatus.completed:
        statusColor = Colors.grey[700]!;
        break;
    }

    return InkWell(
      onTap: () => context.go('/campaign-detail/${camp.id}'),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.surfaceVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    camp.mediaUrl,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(width: 56, height: 56, color: AppTheme.surfaceContainer),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        camp.name,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: camp.platforms.map((p) => Container(
                          margin: const EdgeInsets.only(right: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(p, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                        )).toList(),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    camp.status.displayName,
                    style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Budget: ${camp.formattedBudget}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                Text('Reach: ${(camp.reach / 1000).toStringAsFixed(1)}K', style: const TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant)),
                Text('Klik: ${camp.clicks}', style: const TextStyle(fontSize: 12, color: AppTheme.primary, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
