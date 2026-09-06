import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/services/customer_service.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/common/role_switcher.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/customer/customer_bottom_navigation.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  bool _notifPromo = true;
  bool _notifNearby = true;
  bool _notifFavorite = true;

  @override
  Widget build(BuildContext context) {
    final favoritesCount = CustomerService().getFavorites().length;

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Profil Saya', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: AppTheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz, color: AppTheme.primary),
            tooltip: 'Ganti Mode',
            onPressed: () => RoleSwitcherSheet.show(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // User Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.surfaceVariant),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: AppTheme.secondaryContainer,
                    child: Icon(Icons.person, size: 36, color: AppTheme.secondary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Budi Santoso',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.onSurface),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          '0812-9876-5432',
                          style: TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            '🍜 Foodie Explorer Level 3',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.secondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, color: AppTheme.outline),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => context.go('/customer-favorites'),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.favorite, color: Colors.redAccent, size: 24),
                          const SizedBox(height: 6),
                          Text(
                            '$favoritesCount',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Tempat Favorit',
                            style: TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.rate_review_outlined, color: AppTheme.primary, size: 24),
                        SizedBox(height: 6),
                        Text(
                          '14',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Ulasan Diberikan',
                          style: TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.history, color: Color(0xFF924700), size: 24),
                        SizedBox(height: 6),
                        Text(
                          '28',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Kunjungan',
                          style: TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Riwayat Pencarian
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
                      const Text(
                        'Riwayat Pencarian Terakhir',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Riwayat dibersihkan.')),
                          );
                        },
                        child: const Text('Hapus Semua', style: TextStyle(fontSize: 11, color: AppTheme.primary)),
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildHistoryChip('Kopi Susu Aren'),
                      _buildHistoryChip('Sambal Bakar'),
                      _buildHistoryChip('Seafood Tebet'),
                      _buildHistoryChip('Bakso Urat'),
                      _buildHistoryChip('Roti Bakar'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Pengaturan Notifikasi
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
                  const Text(
                    'Pengaturan Notifikasi',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Promo Kuliner Sekitar', style: TextStyle(fontSize: 13)),
                    subtitle: const Text('Dapatkan update diskon di radius terdekat', style: TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant)),
                    value: _notifPromo,
                    activeThumbColor: AppTheme.primary,
                    onChanged: (v) => setState(() => _notifPromo = v),
                  ),
                  const Divider(),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Peringatan Warung Buka', style: TextStyle(fontSize: 13)),
                    subtitle: const Text('Notifikasi ketika warung favorit Anda mulai buka', style: TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant)),
                    value: _notifFavorite,
                    activeThumbColor: AppTheme.primary,
                    onChanged: (v) => setState(() => _notifFavorite = v),
                  ),
                  const Divider(),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Kuliner Trending', style: TextStyle(fontSize: 13)),
                    subtitle: const Text('Rekomendasi tempat makan viral harian', style: TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant)),
                    value: _notifNearby,
                    activeThumbColor: AppTheme.primary,
                    onChanged: (v) => setState(() => _notifNearby = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Ganti Mode Peran Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primaryFixed,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.storefront, size: 32, color: AppTheme.onPrimaryFixed),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Punya Usaha Kuliner?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.onPrimaryFixed)),
                        Text('Kelola warung & toko Anda di TONGkrongan Owner.', style: TextStyle(fontSize: 11, color: AppTheme.onPrimaryFixedVariant)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => context.go('/owner-dashboard'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    child: const Text('Mode Owner', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomerBottomNavigation(currentIndex: 4),
    );
  }

  Widget _buildHistoryChip(String label) {
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      backgroundColor: AppTheme.surfaceContainerLow,
      deleteIcon: const Icon(Icons.close, size: 14),
      onDeleted: () {},
    );
  }
}
