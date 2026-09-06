import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/models/advertising.dart';
import 'package:tongkrongan_umkm_owner_app/services/advertising_service.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/advertising/ads_bottom_navigation.dart';

class MyCampaignsScreen extends StatefulWidget {
  const MyCampaignsScreen({super.key});

  @override
  State<MyCampaignsScreen> createState() => _MyCampaignsScreenState();
}

class _MyCampaignsScreenState extends State<MyCampaignsScreen> {
  String _selectedFilter = 'SEMUA';

  @override
  Widget build(BuildContext context) {
    final adsService = AdvertisingService();
    final allCampaigns = adsService.campaigns;

    var campaigns = allCampaigns;
    if (_selectedFilter == 'ACTIVE') {
      campaigns = allCampaigns.where((c) => c.status == CampaignStatus.active).toList();
    } else if (_selectedFilter == 'PAUSED') {
      campaigns = allCampaigns.where((c) => c.status == CampaignStatus.paused).toList();
    } else if (_selectedFilter == 'COMPLETED') {
      campaigns = allCampaigns.where((c) => c.status == CampaignStatus.completed).toList();
    }

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Kampanye Iklan Saya', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: AppTheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle, color: AppTheme.primary),
            tooltip: 'Buat Iklan Baru',
            onPressed: () => context.go('/create-campaign'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
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
          ),
          const SizedBox(height: 8),

          // Campaigns List
          Expanded(
            child: campaigns.isEmpty
                ? const Center(child: Text('Tidak ada kampanye pada kategori ini.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: campaigns.length,
                    itemBuilder: (context, index) {
                      final camp = campaigns[index];
                      return _buildDetailedCampaignCard(camp);
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const AdsBottomNavigation(currentIndex: 1),
    );
  }

  Widget _buildDetailedCampaignCard(AdCampaign camp) {
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

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.surfaceVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Image & Status
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.network(
                  camp.mediaUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(height: 140, color: AppTheme.surfaceContainer),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    camp.status.displayName,
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    camp.schedule,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),

          // Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  camp.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.onSurface),
                ),
                const SizedBox(height: 4),
                Text(
                  'Produk: ${camp.productName}',
                  style: const TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant),
                ),
                const SizedBox(height: 8),

                // Platform tags
                Row(
                  children: [
                    const Text('Channel: ', style: TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant)),
                    ...camp.platforms.map((p) => Container(
                      margin: const EdgeInsets.only(right: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryFixed,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        p,
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.onPrimaryFixed),
                      ),
                    )),
                  ],
                ),
                const SizedBox(height: 12),

                // Metrics Grid
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMetricItem('Budget', camp.formattedBudget),
                      _buildMetricItem('Reach', '${(camp.reach / 1000).toStringAsFixed(1)}K'),
                      _buildMetricItem('Engagement', '${camp.engagementRate}%'),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Actions
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => context.go('/campaign-detail/${camp.id}'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Detail & Statistik', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (camp.status != CampaignStatus.completed)
                      IconButton.filledTonal(
                        onPressed: () {
                          setState(() {
                            AdvertisingService().toggleCampaignStatus(camp.id);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Status kampanye ${camp.name} diperbarui.')),
                          );
                        },
                        icon: Icon(
                          camp.status == CampaignStatus.active ? Icons.pause : Icons.play_arrow,
                          color: camp.status == CampaignStatus.active ? Colors.orange[800] : const Color(0xFF1B6D24),
                        ),
                        tooltip: camp.status == CampaignStatus.active ? 'Jeda Kampanye' : 'Lanjutkan Kampanye',
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String val) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant)),
        const SizedBox(height: 2),
        Text(val, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.onSurface)),
      ],
    );
  }
}
