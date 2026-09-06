import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/services/customer_service.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/customer/customer_bottom_navigation.dart';

class NotifikasiPelangganScreen extends StatelessWidget {
  const NotifikasiPelangganScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifs = CustomerService().notifications;

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Notifikasi & Promo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: AppTheme.surface,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Semua notifikasi ditandai telah dibaca.')),
              );
            },
            child: const Text('Tandai Dibaca', style: TextStyle(color: AppTheme.primary, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifs.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final n = notifs[index];
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: n.isUnread ? AppTheme.surfaceContainerLowest : AppTheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: n.isUnread ? AppTheme.primaryFixed : AppTheme.surfaceVariant,
                width: n.isUnread ? 1.5 : 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: n.type == 'promo'
                        ? AppTheme.primaryFixed
                        : (n.type == 'favorite' ? AppTheme.secondaryContainer : AppTheme.surfaceContainerHighest),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    n.type == 'promo'
                        ? Icons.local_offer
                        : (n.type == 'favorite' ? Icons.favorite : Icons.location_on),
                    size: 20,
                    color: n.type == 'promo'
                        ? AppTheme.primary
                        : (n.type == 'favorite' ? AppTheme.secondary : AppTheme.onSurfaceVariant),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              n.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: n.isUnread ? FontWeight.bold : FontWeight.w600,
                                color: AppTheme.onSurface,
                              ),
                            ),
                          ),
                          Text(
                            n.time,
                            style: const TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        n.message,
                        style: const TextStyle(fontSize: 13, height: 1.4, color: AppTheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomerBottomNavigation(currentIndex: 3),
    );
  }
}
