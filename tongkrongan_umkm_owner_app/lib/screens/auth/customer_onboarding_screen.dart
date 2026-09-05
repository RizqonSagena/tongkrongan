import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class CustomerOnboardingScreen extends StatefulWidget {
  const CustomerOnboardingScreen({super.key});

  @override
  State<CustomerOnboardingScreen> createState() => _CustomerOnboardingScreenState();
}

class _CustomerOnboardingScreenState extends State<CustomerOnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      title: 'Kelola Warung dengan Mudah',
      description: 'Pantau stok, catat transaksi, dan kelola menu dari satu aplikasi yang mudah digunakan.',
      icon: Icons.store,
      color: AppTheme.primary,
    ),
    OnboardingItem(
      title: 'Laporan Real-time',
      description: 'Dapatkan insight penjualan, margin keuntungan, dan analisis bisnis secara real-time.',
      icon: Icons.analytics,
      color: AppTheme.secondary,
    ),
    OnboardingItem(
      title: 'Tingkatkan Omzet',
      description: 'Jangkau lebih banyak pelanggan dengan fitur promosi dan manajemen pelanggan terintegrasi.',
      icon: Icons.trending_up,
      color: AppTheme.tertiary,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _onboardingItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/login');
    }
  }

  void _skipOnboarding() {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.all(AppTheme.marginMobile),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _skipOnboarding,
                  child: Text(
                    'Lewati',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
            
            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingItems.length,
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(_onboardingItems[index]);
                },
              ),
            ),
            
            // Page indicators
            _buildPageIndicators(),
            
            const SizedBox(height: AppTheme.spaceLg),
            
            // Next/Get Started button
            Padding(
              padding: const EdgeInsets.all(AppTheme.marginMobile),
              child: SizedBox(
                width: double.infinity,
                height: AppTheme.touchTargetMin,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  child: Text(
                    _currentPage == _onboardingItems.length - 1
                        ? 'Mulai Sekarang'
                        : 'Selanjutnya',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppTheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: AppTheme.spaceMd),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingItem item) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.marginMobile),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon container
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.icon,
              size: 60,
              color: item.color,
            ),
          ),
          
          const SizedBox(height: AppTheme.space2xl),
          
          // Title
          Text(
            item.title,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: AppTheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: AppTheme.spaceMd),
          
          // Description
          Text(
            item.description,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _onboardingItems.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index ? AppTheme.primary : AppTheme.outline,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}