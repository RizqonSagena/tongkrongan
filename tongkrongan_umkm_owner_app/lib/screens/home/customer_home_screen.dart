import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/category_card.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/warung_card.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/promo_banner.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedRadius = '1 KM';
  String _currentLocation = 'Tanjungpinang, Kepri';

  final List<String> _radiusOptions = ['1 KM', '3 KM', '5 KM', '10 KM'];
  
  final List<CategoryItem> _categories = [
    CategoryItem(icon: '☕', name: 'Kopi', route: '/category-results?category=kopi'),
    CategoryItem(icon: '🛋️', name: 'Cafe', route: '/category-results?category=cafe'),
    CategoryItem(icon: '🍽️', name: 'Restoran', route: '/category-results?category=restoran'),
    CategoryItem(icon: '🍲', name: 'Tradisional', route: '/category-results?category=tradisional'),
    CategoryItem(icon: '🦐', name: 'Seafood', route: '/category-results?category=seafood'),
    CategoryItem(icon: '🥐', name: 'Bakery', route: '/category-results?category=bakery'),
    CategoryItem(icon: '🥣', name: 'Bakso', route: '/category-results?category=bakso'),
    CategoryItem(icon: '🍢', name: 'Kaki Lima', route: '/category-results?category=kaki-lima'),
    CategoryItem(icon: '🎁', name: 'Oleh-Oleh', route: '/category-results?category=oleh-oleh'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: CustomScrollView(
        slivers: [
          // App Bar
          _buildSliverAppBar(),
          
          // Body content
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: AppTheme.spaceXs),
                
                // Greeting & Location Banner
                _buildGreetingSection(),
                
                const SizedBox(height: AppTheme.spaceLg),
                
                // Categories
                _buildCategoriesSection(),
                
                const SizedBox(height: AppTheme.spaceLg),
                
                // Promo Banner
                _buildPromoSection(),
                
                const SizedBox(height: AppTheme.spaceLg),
                
                // Nearest Section
                _buildNearestSection(),
                
                const SizedBox(height: AppTheme.spaceLg),
                
                // Popular Section
                _buildPopularSection(),
                
                const SizedBox(height: AppTheme.spaceLg),
                
                // Recommendations
                _buildRecommendationsSection(),
                
                const SizedBox(height: AppTheme.space2xl),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: AppTheme.surface.withOpacity(0.85),
      elevation: 0,
      scrolledUnderElevation: 1,
      floating: true,
      snap: true,
      title: Row(
        children: [
          Image.network(
            'https://lh3.googleusercontent.com/aida/AEtjO1WghRcOvTTmgBnGk2EHhRlN160v_4Pnh6QUtHF5_OrHTztD9SGy6MvkhsiNNyloE0HmxA9iwnUR7TeN0I3dJZeUy7KwzzRvoj5vUtf_lggrUqXo7XdjN9jcfcpGBAZDYtgfYr5USukLwZbZISjXOVFCLW_owI5bc_BrKtxJeEE4NczcdVlT68fu2e-_yYC2oAQPwx4Fc267KoiyW9Vvuf8czDWFCwS8BIifWdEJt13PCBzTXZDNqLIK5qw',
            height: 32,
            width: 32,
            errorBuilder: (context, error, stackTrace) => 
              const Icon(Icons.storefront, size: 32, color: AppTheme.primary),
          ),
          const SizedBox(width: AppTheme.spaceXs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TONGkrongan',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppTheme.primary,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Home',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppTheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        // Location chip
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: InkWell(
            onTap: () {
              // TODO: Show location picker
            },
            borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spaceXs,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 18,
                    color: AppTheme.primary,
                  ),
                  const SizedBox(width: 4),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: Text(
                      _currentLocation,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: AppTheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.expand_more,
                    size: 16,
                    color: AppTheme.outline,
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Bookmark button
        IconButton(
          onPressed: () {
            context.go('/favorit');
          },
          icon: const Icon(
            Icons.bookmark_outline,
            color: AppTheme.onSurface,
          ),
        ),
        
        // Profile avatar
        Container(
          margin: const EdgeInsets.only(right: AppTheme.marginMobile),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: AppTheme.primary,
            child: const Icon(
              Icons.person,
              size: 18,
              color: AppTheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGreetingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.marginMobile),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location info
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spaceXs,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on,
                  size: 16,
                  color: AppTheme.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Tepi Laut, Tanjungpinang',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppTheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 2),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Ubah',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: AppTheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 4),
          
          // Welcome text
          RichText(
            text: TextSpan(
              text: 'Selamat datang di ',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: AppTheme.onSurface,
                letterSpacing: -0.3,
              ),
              children: [
                TextSpan(
                  text: 'TONGkrongan',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                const TextSpan(text: ' 👋'),
              ],
            ),
          ),
          
          const SizedBox(height: 2),
          
          Text(
            'Jelajahi aroma sedap warung & kuliner legendaris di sekitarmu!',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
          ),
          
          const SizedBox(height: AppTheme.spaceMd),
          
          // Search bar
          _buildSearchBar(),
          
          const SizedBox(height: AppTheme.spaceMd),
          
          // Radius selector
          _buildRadiusSelector(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: AppTheme.touchTargetMin,
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(AppTheme.radiusXl),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.onSurface.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(AppTheme.spaceSm),
                  child: Icon(
                    Icons.search,
                    size: 20,
                    color: AppTheme.outline,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Cari makanan, cafe, restoran, bakso...',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppTheme.outline.withOpacity(0.7),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.mic,
                    size: 18,
                    color: AppTheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppTheme.spaceXs),
        Container(
          width: AppTheme.touchTargetMin,
          height: AppTheme.touchTargetMin,
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(AppTheme.radiusXl),
            boxShadow: [
              BoxShadow(
                color: AppTheme.onSurface.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.tune,
              size: 20,
              color: AppTheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRadiusSelector() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _radiusOptions.length,
        itemBuilder: (context, index) {
          final radius = _radiusOptions[index];
          final isSelected = radius == _selectedRadius;
          
          return Container(
            margin: EdgeInsets.only(
              right: index < _radiusOptions.length - 1 ? AppTheme.spaceXs : 0,
            ),
            child: FilterChip(
              label: Text(radius),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedRadius = radius;
                });
              },
              backgroundColor: AppTheme.surfaceContainerHigh,
              selectedColor: AppTheme.primary,
              labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: isSelected ? AppTheme.onPrimary : AppTheme.onSurfaceVariant,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
              side: BorderSide.none,
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.marginMobile),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kategori Kuliner',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppTheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Semua',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spaceXs),
        SizedBox(
          height: 100,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.marginMobile),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return Container(
                margin: EdgeInsets.only(
                  right: index < _categories.length - 1 ? AppTheme.spaceSm : 0,
                ),
                child: CategoryCard(category: category),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPromoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.marginMobile),
      child: PromoBanner(
        title: 'Diskon 20% Kopi & Snack',
        subtitle: 'Tunjukkan aplikasi di kasir saat pesan langsung di 8 warung mitra terdekat!',
        timeLeft: 'Sisa 2 jam lagi',
        onTap: () {},
      ),
    );
  }

  Widget _buildNearestSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.marginMobile),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Terdekat dari Anda',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppTheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.go('/explore-map');
                },
                child: Text(
                  'Lihat Peta',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spaceXs),
        SizedBox(
          height: 280,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.marginMobile),
            scrollDirection: Axis.horizontal,
            itemCount: 3, // Mock data
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                  right: index < 2 ? AppTheme.spaceMd : 0,
                ),
                child: WarungCard(
                  id: 'warung_$index',
                  name: index == 0 
                    ? 'Kedai Kopi Aman & Otak-Otak'
                    : index == 1 
                      ? 'Mie Tarempa & Luti Gendang Melayu'
                      : 'Warung Seafood Bahari',
                  category: index == 0
                    ? 'Kopi O & Otak-Otak Ikan Tenggiri'
                    : index == 1
                      ? 'Kuliner Khas Melayu Kepri'
                      : 'Seafood Segar & Gulai',
                  rating: index == 0 ? 4.8 : index == 1 ? 4.9 : 4.7,
                  reviewCount: index == 0 ? 128 : index == 1 ? 410 : 89,
                  distance: index == 0 ? '250m' : index == 1 ? '450m' : '680m',
                  priceStart: index == 0 ? 12000 : index == 1 ? 15000 : 25000,
                  imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCGTa81AVhhQS0m03LWITN5LFxPrmK5je9fPN3EJpgH_KoT4TfwpUpu4QWiSt7a0vOjQJob1I3d_r6YT_3F4CVJDdCq0q4Trb4ehvCLK0_XdQZit94lxKXZjrxVjZS4YhsPTzhf23zxt0rCUBHGg7hzsJ9GQGtUFnfuGwLeKENEoTr4URk_VjMcbvZgJdsqpVhlrGiPel5_MWrmAGc4ORDPZakh0U0O9ysBdUFFbPxnvNAvqWw7ZPPQ',
                  isOpen: true,
                  onTap: () {
                    context.go('/warung/warung_$index');
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopularSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.marginMobile),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Sedang Populer & Ramai',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppTheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.errorContainer,
                      borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                    ),
                    child: Text(
                      '🔥 Tren',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: AppTheme.onErrorContainer,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Lihat Semua',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spaceXs),
        // Popular items list would go here
        // For brevity, I'll skip the detailed implementation
      ],
    );
  }

  Widget _buildRecommendationsSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.marginMobile),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rekomendasi Untuk Anda',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppTheme.onSurface,
                    ),
                  ),
                  Text(
                    'Pilihan tepat sesuai seleramu hari ini',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Filter',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spaceXs),
        // Recommendations list would go here
      ],
    );
  }
}

class CategoryItem {
  final String icon;
  final String name;
  final String route;

  CategoryItem({
    required this.icon,
    required this.name,
    required this.route,
  });
}