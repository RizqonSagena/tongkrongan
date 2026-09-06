import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class RoleSwitcherSheet extends StatelessWidget {
  const RoleSwitcherSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const RoleSwitcherSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryFixed,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.swap_horiz, color: AppTheme.primary, size: 24),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pilih Mode Aplikasi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.onSurface,
                    ),
                  ),
                  Text(
                    'Jelajahi seluruh fitur Fase 1, 2, dan 3',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildRoleCard(
            context: context,
            title: 'Fase 1: Pemilik UMKM (Owner)',
            subtitle: 'Dashboard, Transaksi, Produk, Pembukuan & Gaji',
            icon: Icons.storefront,
            color: AppTheme.primary,
            bgColor: AppTheme.primaryFixed,
            route: '/owner-dashboard',
          ),
          const SizedBox(height: 12),
          _buildRoleCard(
            context: context,
            title: 'Fase 2: Pelanggan Kuliner (Customer)',
            subtitle: 'Jelajah Lokasi, Map Radius, Detail Warung & Menu',
            icon: Icons.restaurant,
            color: AppTheme.secondary,
            bgColor: AppTheme.secondaryContainer,
            route: '/customer-home',
          ),
          const SizedBox(height: 12),
          _buildRoleCard(
            context: context,
            title: 'Fase 3: Smart Advertising (Admin Iklan)',
            subtitle: 'Otomasi Auto Play, Multi-Platform & Creator Vlogger',
            icon: Icons.campaign,
            color: const Color(0xFF924700),
            bgColor: const Color(0xFFFFDCC6),
            route: '/advertising-dashboard',
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildRoleCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color bgColor,
    required String route,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        context.go(route);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.surfaceVariant),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}
