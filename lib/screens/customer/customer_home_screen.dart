import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/common/role_switcher.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/customer/business_card.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/customer/category_chip.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/customer/customer_bottom_navigation.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedRadius = '3 KM';
  String selectedCategory = '';

  final List<String> radiusOptions = ['1 KM', '3 KM', '5 KM', '10 KM'];
  
  final List<CategoryItem> categories = [
    CategoryItem('Kopi', '☕', Colors.brown),
    CategoryItem('Cafe', '🏪', Colors.orange),
    CategoryItem('Restoran', '🍽️', Colors.red),
    CategoryItem('Makanan Tradisional', '🍜', Colors.green),
    CategoryItem('Seafood', '🦐', Colors.blue),
    CategoryItem('Bakery', '🍞', Colors.amber),
    CategoryItem('Bakso', '🍲', Colors.purple),
    CategoryItem('Pedagang Kaki Lima', '🛒', Colors.teal),
    CategoryItem('Oleh-Oleh', '🎁', Colors.pink),
  ];

  // Mock data untuk bisnis culinary
  final List<Business> nearbyBusinesses = [
    Business(
      id: '1',
      name: 'Warung Kopi Pak Budi',
      category: 'Kopi',
      rating: 4.5,
      distance: '0.2 km',
      isOpen: true,
      startingPrice: 'Rp 8.000',
      imageUrl: 'assets/images/kopi_pak_budi.jpg',
      promoText: 'Promo 2+1',
    ),
    Business(
      id: '2', 
      name: 'Sate Kambing Bu Ani',
      category: 'Makanan Tradisional',
      rating: 4.8,
      distance: '0.5 km',
      isOpen: true,
      startingPrice: 'Rp 25.000',
      imageUrl: 'assets/images/sate_kambing.jpg',
      promoText: '',
    ),
    Business(
      id: '3',
      name: 'Seafood Bahari',
      category: 'Seafood', 
      rating: 4.3,
      distance: '1.2 km',
      isOpen: false,
      startingPrice: 'Rp 35.000',
      imageUrl: 'assets/images/seafood_bahari.jpg',
      promoText: '',
    ),
  ];

  final List<Business> popularBusinesses = [
    Business(
      id: '4',
      name: 'Bakso Solo Endes',
      category: 'Bakso',
      rating: 4.7,
      distance: '0.8 km',
      isOpen: true,
      startingPrice: 'Rp 15.000',
      imageUrl: 'assets/images/bakso_solo.jpg',
      promoText: 'Viral!',
    ),
    Business(
      id: '5',
      name: 'Gudeg Yu Djum',
      category: 'Makanan Tradisional',
      rating: 4.9,
      distance: '2.1 km',
      isOpen: true,
      startingPrice: 'Rp 18.000',
      imageUrl: 'assets/images/gudeg.jpg',
      promoText: '',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(),
              
              // Search Bar
              _buildSearchBar(),
              
              // Radius Selector
              _buildRadiusSelector(),
              
              // Categories
              _buildCategories(),
              
              // Terdekat dari Anda
              _buildSection('Terdekat dari Anda', nearbyBusinesses),
              
              // Sedang Populer
              _buildSection('Sedang Populer', popularBusinesses),
              
              // Promo Hari Ini
              _buildPromoSection(),
              
              // Rekomendasi Untuk Anda
              _buildRecommendationSection(),
              
              const SizedBox(height: 100), // Space for bottom nav
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomerBottomNavigation(currentIndex: 0),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.restaurant,
                  color: AppTheme.secondary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Selamat datang di TONGkrongan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.onSurface,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => RoleSwitcherSheet.show(context),
                tooltip: 'Ganti Mode Peran',
                icon: const Icon(Icons.swap_horiz_rounded, color: AppTheme.secondary),
              ),
              IconButton(
                onPressed: () => context.go('/customer-notifications'),
                icon: const Icon(Icons.notifications_outlined),
                style: IconButton.styleFrom(
                  backgroundColor: AppTheme.surfaceContainerLow,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Location
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.red[600],
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                'Lokasi Anda',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Jl. Malioboro, Yogyakarta',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Ubah'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Cari makanan, cafe, restoran...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onTap: () => context.push('/search'),
      ),
    );
  }

  Widget _buildRadiusSelector() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Radius Pencarian',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: radiusOptions.map((radius) {
              final isSelected = selectedRadius == radius;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRadius = radius;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue[600] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      radius,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Kategori',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryChip(
                  category: category,
                  isSelected: selectedCategory == category.name,
                  onTap: () {
                    setState(() {
                      selectedCategory = selectedCategory == category.name
                          ? ''
                          : category.name;
                    });
                    context.go('/category-results/${category.name}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Business> businesses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Lihat Semua'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: businesses.length,
            itemBuilder: (context, index) {
              return BusinessCard(
                business: businesses[index],
                onTap: () => context.go('/business-detail/${businesses[index].id}'),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPromoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Text(
            'Promo Hari Ini',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          height: 160,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [Colors.orange[600]!, Colors.orange[400]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -50,
                top: -50,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🔥 PROMO SPESIAL',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Diskon hingga 50%\ndi 25+ restoran pilihan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.orange[600],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Lihat Promo',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildRecommendationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Text(
            'Rekomendasi Untuk Anda',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: 3,
          itemBuilder: (context, index) {
            final business = nearbyBusinesses[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: BusinessCard(
                business: business,
                isHorizontal: true,
                onTap: () => context.go('/business-detail/${business.id}'),
              ),
            );
          },
        ),
      ],
    );
  }
}

class CategoryItem {
  final String name;
  final String emoji;
  final Color color;

  CategoryItem(this.name, this.emoji, this.color);
}

class Business {
  final String id;
  final String name;
  final String category;
  final double rating;
  final String distance;
  final bool isOpen;
  final String startingPrice;
  final String imageUrl;
  final String promoText;

  Business({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.distance,
    required this.isOpen,
    required this.startingPrice,
    required this.imageUrl,
    required this.promoText,
  });
}