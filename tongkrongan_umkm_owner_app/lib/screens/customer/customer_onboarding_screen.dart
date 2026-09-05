import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomerOnboardingScreen extends StatefulWidget {
  const CustomerOnboardingScreen({super.key});

  @override
  State<CustomerOnboardingScreen> createState() => _CustomerOnboardingScreenState();
}

class _CustomerOnboardingScreenState extends State<CustomerOnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: "Temukan Kuliner\ndi Sekitarmu",
      description: "Jelajahi ribuan kuliner lokal, warung tradisional, dan hidden gems di sekitar lokasi Anda",
      imagePath: "assets/images/onboarding_1.jpg",
      backgroundColor: Colors.orange,
    ),
    OnboardingPage(
      title: "Jelajahi Menu\n& Harga",
      description: "Lihat menu lengkap, harga terkini, dan promo menarik sebelum Anda berkunjung",
      imagePath: "assets/images/onboarding_2.jpg", 
      backgroundColor: Colors.green,
    ),
    OnboardingPage(
      title: "Temukan Kuliner\nLokal Terbaik",
      description: "Dari pedagang kaki lima hingga restoran, temukan cita rasa otentik Indonesia di sekitar Anda",
      imagePath: "assets/images/onboarding_3.jpg",
      backgroundColor: Colors.blue,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            if (_currentPage < _pages.length - 1)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextButton(
                    onPressed: () => _goToHome(),
                    child: Text(
                      'Lewati',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            
            // Page View
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(_pages[index]);
                },
              ),
            ),
            
            // Bottom Section
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Page Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => _buildPageIndicator(index),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Navigation Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _currentPage == _pages.length - 1
                          ? _goToHome
                          : _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _pages[_currentPage].backgroundColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1
                            ? 'Mulai Jelajahi'
                            : 'Lanjut',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 40),
          
          // Illustration Container
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    page.backgroundColor.withOpacity(0.1),
                    page.backgroundColor.withOpacity(0.2),
                  ],
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Food Illustration Icons
                  _buildFoodIllustration(page.backgroundColor),
                  
                  // Central Icon
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: page.backgroundColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: page.backgroundColor.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      _getPageIcon(_currentPage),
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 48),
          
          // Content
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  page.title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                
                Text(
                  page.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodIllustration(Color color) {
    final icons = [
      Icons.local_pizza,
      Icons.local_cafe,
      Icons.restaurant,
      Icons.cake,
      Icons.fastfood,
      Icons.local_dining,
    ];

    return Stack(
      children: List.generate(6, (index) {
        final angle = (index * 60.0) * (3.14159 / 180); // Convert to radians
        final radius = 80.0;
        final x = radius * math.cos(angle);
        final y = radius * math.sin(angle);

        return Transform.translate(
          offset: Offset(x, y),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.2), width: 2),
            ),
            child: Icon(
              icons[index],
              size: 24,
              color: color,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPageIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index 
            ? _pages[_currentPage].backgroundColor
            : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  IconData _getPageIcon(int page) {
    switch (page) {
      case 0:
        return Icons.location_on;
      case 1:
        return Icons.restaurant_menu;
      case 2:
        return Icons.favorite;
      default:
        return Icons.location_on;
    }
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToHome() {
    context.go('/customer-home');
  }
}

// Import math untuk angle calculation
import 'dart:math' as math;

class OnboardingPage {
  final String title;
  final String description;
  final String imagePath;
  final Color backgroundColor;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.backgroundColor,
  });
}