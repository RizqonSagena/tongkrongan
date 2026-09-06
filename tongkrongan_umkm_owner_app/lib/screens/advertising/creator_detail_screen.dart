import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/models/advertising.dart';
import 'package:tongkrongan_umkm_owner_app/services/advertising_service.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class CreatorDetailScreen extends StatefulWidget {
  final String creatorId;

  const CreatorDetailScreen({
    required this.creatorId, super.key,
  });

  @override
  State<CreatorDetailScreen> createState() => _CreatorDetailScreenState();
}

class _CreatorDetailScreenState extends State<CreatorDetailScreen> {
  late ContentCreator creator;
  String? _selectedPackage;

  @override
  void initState() {
    super.initState();
    final found = AdvertisingService().getCreatorById(widget.creatorId);
    creator = found ?? AdvertisingService().creators.first;
    if (creator.pricePackages.isNotEmpty) {
      _selectedPackage = creator.pricePackages.keys.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Profil Kreator Kuliner', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        backgroundColor: AppTheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppTheme.surfaceVariant),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(creator.avatarUrl),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    creator.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${creator.category} • ${creator.location}',
                    style: const TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    creator.bio,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13, height: 1.4, color: AppTheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 16),

                  // Metrics
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMetricCol('Followers', creator.followers),
                      _buildMetricCol('Engagement', creator.engagementRate),
                      _buildMetricCol('Rating', '⭐ ${creator.rating}'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Audience Demographics
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
                  const Text('Demografi Audiens Pengikut', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 10),
                  _buildAudienceRow('Usia 18 - 24 Tahun (Gen Z)', 0.52),
                  _buildAudienceRow('Usia 25 - 34 Tahun (Millennials)', 0.38),
                  _buildAudienceRow('Domisili: Jabodetabek', 0.85),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Previous Campaigns
            if (creator.previousCampaigns.isNotEmpty) ...[
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
                    const Text('Riwayat Kolaborasi Viral', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 10),
                    ...creator.previousCampaigns.map((camp) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          const Icon(Icons.verified, size: 16, color: Color(0xFF1B6D24)),
                          const SizedBox(width: 8),
                          Expanded(child: Text(camp, style: const TextStyle(fontSize: 13))),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Price Packages Selection
            const Text('Pilih Paket Promosi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 10),
            ...creator.pricePackages.entries.map((entry) {
              final isSelected = _selectedPackage == entry.key;
              final priceFormatted = 'Rp${entry.value.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
              return InkWell(
                onTap: () => setState(() => _selectedPackage = entry.key),
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFFFDCC6).withValues(alpha: 0.5) : AppTheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF924700) : AppTheme.surfaceVariant,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          entry.key,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        priceFormatted,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? const Color(0xFF924700) : AppTheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),

            // Order Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      title: const Text('Konfirmasi Pengajuan Promosi'),
                      content: Text(
                        'Ajukan promosi "${_selectedPackage ?? "Paket Promosi"}" kepada ${creator.name}? Tim admin TONGkrongan akan mengoordinasikan jadwal peliputan menu warung Anda.',
                        style: const TextStyle(fontSize: 13, height: 1.4),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Batal'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Permintaan promosi ke ${creator.name} berhasil diajukan!')),
                            );
                            context.go('/creator-marketplace');
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF924700), foregroundColor: Colors.white),
                          child: const Text('Ajukan Sekarang'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF924700),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: const Text('Pesan Promosi Sekarang', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCol(String label, String val) {
    return Column(
      children: [
        Text(val, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildAudienceRow(String label, double pct) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 12)),
              Text('${(pct * 100).toInt()}%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              backgroundColor: AppTheme.surfaceContainerHigh,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF924700)),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
