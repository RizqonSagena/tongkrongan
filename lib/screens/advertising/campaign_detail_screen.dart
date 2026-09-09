import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/models/advertising.dart';
import 'package:tongkrongan_umkm_owner_app/services/advertising_service.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class CampaignDetailScreen extends StatefulWidget {
  final String campaignId;

  const CampaignDetailScreen({
    required this.campaignId, super.key,
  });

  @override
  State<CampaignDetailScreen> createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> {
  late AdCampaign campaign;

  @override
  void initState() {
    super.initState();
    final found = AdvertisingService().getCampaignById(widget.campaignId);
    campaign = found ?? AdvertisingService().campaigns.first;
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (campaign.status) {
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

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Detail Kampanye Iklan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        backgroundColor: AppTheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Media Image with Status Overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    campaign.mediaUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(height: 200, color: AppTheme.surfaceContainer),
                  ),
                ),
                Positioned(
                  top: 14,
                  left: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      campaign.status.displayName,
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Campaign Title & Product
            Text(
              campaign.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.onSurface),
            ),
            const SizedBox(height: 4),
            Text(
              'Produk: ${campaign.productName}',
              style: const TextStyle(fontSize: 14, color: AppTheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),

            // Caption Box
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Caption Iklan:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.onSurfaceVariant)),
                  const SizedBox(height: 4),
                  Text(campaign.caption, style: const TextStyle(fontSize: 13, height: 1.4)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Performance Metrics
            const Text('Metrik Performa Iklan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.8,
              children: [
                _buildMetricTile('Reach', '${(campaign.reach / 1000).toStringAsFixed(1)}K Orang', Icons.people, const Color(0xFF924700)),
                _buildMetricTile('Impressions', '${(campaign.impressions / 1000).toStringAsFixed(1)}K Tayangan', Icons.visibility, Colors.indigo),
                _buildMetricTile('Interaksi / Eng.', '${campaign.engagementRate}%', Icons.favorite, Colors.redAccent),
                _buildMetricTile('Total Klik Link', '${campaign.clicks} Klik', Icons.touch_app, const Color(0xFF1B6D24)),
              ],
            ),
            const SizedBox(height: 20),

            // Configuration Details
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
                  const Text('Target & Konfigurasi Distribusi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 12),
                  _buildDetailRow('Platform Terhubung', campaign.platforms.join(', ')),
                  _buildDetailRow('Jadwal Tayang', campaign.schedule),
                  _buildDetailRow('Anggaran (Budget)', campaign.formattedBudget),
                  _buildDetailRow('Target Lokasi', '${campaign.targetLocation} (Radius ${campaign.radiusKm.toInt()} KM)'),
                  _buildDetailRow('Target Audiens', campaign.targetAudience),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Mode edit kampanye dibuka.')),
                      );
                    },
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    label: const Text('Edit Iklan', style: TextStyle(fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                if (campaign.status != CampaignStatus.completed)
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          AdvertisingService().toggleCampaignStatus(campaign.id);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Status diubah menjadi: ${campaign.status.displayName}')),
                        );
                      },
                      icon: Icon(campaign.status == CampaignStatus.active ? Icons.pause : Icons.play_arrow, size: 18),
                      label: Text(
                        campaign.status == CampaignStatus.active ? 'Jeda Iklan' : 'Lanjutkan Iklan',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: campaign.status == CampaignStatus.active ? Colors.orange[800] : const Color(0xFF1B6D24),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricTile(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.surfaceVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}
