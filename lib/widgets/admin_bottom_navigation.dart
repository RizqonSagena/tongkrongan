import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Admin Bottom Navigation Bar
/// 4 main items: Kedai, Produk, Support, Profile
/// 
/// Admin adalah operator input dengan akses terbatas (NO financial data)
class AdminBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const AdminBottomNavigation({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.storefront),
          label: 'Kedai',
          tooltip: 'Kelola Data Kedai',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.inventory_2),
          label: 'Produk',
          tooltip: 'Kelola Produk',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.support_agent),
          label: 'Support',
          tooltip: 'Chat & Appointment',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: 'Profil',
          tooltip: 'Profil Admin',
        ),
      ],
      onTap: (index) {
        _navigateToTab(context, index);
      },
    );
  }

  void _navigateToTab(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/admin-kedai');
        break;
      case 1:
        context.go('/admin-products');
        break;
      case 2:
        context.go('/admin-chat-support');
        break;
      case 3:
        // Profile/Settings
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil Admin (Coming Soon)')),
        );
        break;
    }
  }
}

/// Admin Navigation Menu Widget
/// Digunakan di Admin Dashboard untuk navigasi ke fitur-fitur admin
class AdminNavigationMenu extends StatelessWidget {
  const AdminNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildMenuCard(
          context: context,
          title: '🏪 Kelola Kedai',
          subtitle: 'Tambah/edit kedai',
          onTap: () => context.go('/admin-kedai'),
          color: Colors.blue,
        ),
        _buildMenuCard(
          context: context,
          title: '📦 Kelola Produk',
          subtitle: 'Tambah/edit produk',
          onTap: () => context.go('/admin-products'),
          color: Colors.green,
        ),
        _buildMenuCard(
          context: context,
          title: '📷 Kelola Konten',
          subtitle: 'Upload foto/video',
          onTap: () => context.go('/admin-content'),
          color: Colors.purple,
        ),
        _buildMenuCard(
          context: context,
          title: '📢 Promo & Event',
          subtitle: 'Kelola promo/event',
          onTap: () => context.go('/admin-promo'),
          color: Colors.orange,
        ),
        _buildMenuCard(
          context: context,
          title: '📅 Janji Temu',
          subtitle: 'Konfirmasi reservasi',
          onTap: () => context.go('/admin-appointments'),
          color: Colors.teal,
        ),
        _buildMenuCard(
          context: context,
          title: '💬 Chat Support',
          subtitle: 'Kelola tiket support',
          onTap: () => context.go('/admin-chat-support'),
          color: Colors.red,
        ),
        _buildMenuCard(
          context: context,
          title: '📱 Social Media',
          subtitle: 'Auto-post management',
          onTap: () => context.go('/admin-social-media'),
          color: Colors.cyan,
        ),
        _buildMenuCard(
          context: context,
          title: '⚙️ Pengaturan',
          subtitle: 'Profil & Akun',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Pengaturan (Coming Soon)')),
            );
          },
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildMenuCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Admin Quick Actions Bar
/// Untuk akses cepat ke fungsi-fungsi penting
class AdminQuickActionsBar extends StatelessWidget {
  const AdminQuickActionsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildQuickActionButton(
            context: context,
            icon: Icons.add,
            label: 'Tambah Kedai',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Buka form tambah kedai')),
              );
            },
          ),
          const SizedBox(width: 12),
          _buildQuickActionButton(
            context: context,
            icon: Icons.add_shopping_cart,
            label: 'Tambah Produk',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Buka form tambah produk')),
              );
            },
          ),
          const SizedBox(width: 12),
          _buildQuickActionButton(
            context: context,
            icon: Icons.calendar_today,
            label: 'Lihat Appointment',
            onTap: () => context.go('/admin-appointments'),
          ),
          const SizedBox(width: 12),
          _buildQuickActionButton(
            context: context,
            icon: Icons.mail,
            label: 'Tiket Support',
            onTap: () => context.go('/admin-chat-support'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16),
      label: Text(label),
    );
  }
}
