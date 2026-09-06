import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class AdsBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const AdsBottomNavigation({
    required this.currentIndex, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        border: const Border(top: BorderSide(color: AppTheme.surfaceVariant, width: 1)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                icon: Icons.dashboard_outlined,
                activeIcon: Icons.dashboard,
                label: 'Dashboard',
                index: 0,
                route: '/advertising-dashboard',
              ),
              _buildNavItem(
                context,
                icon: Icons.campaign_outlined,
                activeIcon: Icons.campaign,
                label: 'Kampanye',
                index: 1,
                route: '/my-campaigns',
              ),
              _buildNavItem(
                context,
                icon: Icons.play_circle_outline,
                activeIcon: Icons.play_circle,
                label: 'Auto Play',
                index: 2,
                route: '/auto-play',
                isSpecial: true,
              ),
              _buildNavItem(
                context,
                icon: Icons.video_collection_outlined,
                activeIcon: Icons.video_collection,
                label: 'Creators',
                index: 3,
                route: '/creator-marketplace',
              ),
              _buildNavItem(
                context,
                icon: Icons.insights_outlined,
                activeIcon: Icons.insights,
                label: 'Analitik',
                index: 4,
                route: '/advertising-analytics',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required String route,
    bool isSpecial = false,
  }) {
    final isSelected = currentIndex == index;
    final color = isSelected ? const Color(0xFF924700) : AppTheme.onSurfaceVariant;

    return InkWell(
      onTap: () {
        if (!isSelected) {
          context.go(route);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isSpecial && isSelected
                ? Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFDCC6),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(activeIcon, color: const Color(0xFF924700), size: 24),
                  )
                : Icon(
                    isSelected ? activeIcon : icon,
                    color: color,
                    size: 24,
                  ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
