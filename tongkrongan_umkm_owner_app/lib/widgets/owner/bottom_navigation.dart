import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class OwnerBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const OwnerBottomNavigation({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        boxShadow: [
          BoxShadow(
            color: AppTheme.onSurface.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceXs, vertical: AppTheme.spaceXs),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                0,
                Icons.dashboard,
                'Dashboard',
                '/owner-dashboard',
              ),
              _buildNavItem(
                context,
                1,
                Icons.receipt_long,
                'Transaksi',
                '/transactions',
              ),
              _buildNavItem(
                context,
                2,
                Icons.inventory,
                'Produk',
                '/products',
              ),
              _buildNavItem(
                context,
                3,
                Icons.book,
                'Pembukuan',
                '/bookkeeping',
              ),
              _buildNavItem(
                context,
                4,
                Icons.person,
                'Profile',
                '/profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData icon,
    String label,
    String route,
  ) {
    final isSelected = currentIndex == index;
    
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (!isSelected) {
            context.go(route);
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primary.withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: isSelected ? AppTheme.primary : AppTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: isSelected ? AppTheme.primary : AppTheme.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}