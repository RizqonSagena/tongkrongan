import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tongkrongan_umkm_owner_app/models/customer.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/customer/customer_bottom_navigation.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Filter states
  String _selectedCategory = 'Semua';
  double? _selectedRadius;
  bool _isOpenOnly = false;
  double? _minRating;
  bool _showPromoOnly = false;
  bool _showEventOnly = false;

  // Mock data - List kedai
  late List<Kedai> _allKedai;
  late List<Kedai> _filteredKedai;

  // Mock data - Promo & Event
  late List<Promo> _activePromos;
  late List<KedaiEvent> _upcomingEvents;

  final List<String> _categories = [
    'Semua',
    'Nasi Kuning',
    'Kopi',
    'Bakso',
    'Soto',
    'Roti Bakar',
    'Seafood',
  ];

  @override
  void initState() {
    super.initState();
    _initializeMockData();
    _applyFilters();
  }

  void _initializeMockData() {
    _allKedai = [
      Kedai(
        id: 'kedai-1',
        name: 'Nasi Kuning Pak Hendra',
        description: 'Nasi kuning tradisional dengan lauk pauk pilihan',
        category: 'Nasi Kuning',
        imageUrl: 'https://via.placeholder.com/300x200?text=Nasi+Kuning',
        address: 'Jl. Raya Bogor No. 123',
        latitude: -6.2088,
        longitude: 106.8456,
        phoneNumber: '08123456789',
        rating: 4.8,
        totalRatings: 156,
        isOpen: true,
        openingHours: '08:00 - 22:00',
        distanceFromCustomer: 1.2,
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
      ),
      Kedai(
        id: 'kedai-2',
        name: 'Kopi Legendaris',
        description: 'Kopi premium dengan berbagai pilihan',
        category: 'Kopi',
        imageUrl: 'https://via.placeholder.com/300x200?text=Kopi',
        address: 'Jl. Sudirman No. 45',
        latitude: -6.2089,
        longitude: 106.8157,
        phoneNumber: '08234567890',
        rating: 4.5,
        totalRatings: 89,
        isOpen: true,
        openingHours: '07:00 - 20:00',
        distanceFromCustomer: 2.5,
        createdAt: DateTime.now().subtract(const Duration(days: 300)),
      ),
      Kedai(
        id: 'kedai-3',
        name: 'Bakso Malang Spesial',
        description: 'Bakso sapi berkualitas dengan kuah gurih',
        category: 'Bakso',
        imageUrl: 'https://via.placeholder.com/300x200?text=Bakso',
        address: 'Jl. Gatot Subroto No. 78',
        latitude: -6.2190,
        longitude: 106.8357,
        phoneNumber: '08345678901',
        rating: 4.7,
        totalRatings: 234,
        isOpen: false,
        openingHours: '06:00 - 21:00',
        distanceFromCustomer: 0.8,
        createdAt: DateTime.now().subtract(const Duration(days: 200)),
      ),
      Kedai(
        id: 'kedai-4',
        name: 'Soto Ayam Ibu Rina',
        description: 'Soto ayam tradisional dengan resep warisan',
        category: 'Soto',
        imageUrl: 'https://via.placeholder.com/300x200?text=Soto',
        address: 'Jl. Ahmad Yani No. 56',
        latitude: -6.2150,
        longitude: 106.8250,
        phoneNumber: '08456789012',
        rating: 4.6,
        totalRatings: 178,
        isOpen: true,
        openingHours: '08:00 - 20:00',
        distanceFromCustomer: 3.2,
        createdAt: DateTime.now().subtract(const Duration(days: 250)),
      ),
      Kedai(
        id: 'kedai-5',
        name: 'Roti Bakar Mantap',
        description: 'Roti bakar dengan berbagai topping pilihan',
        category: 'Roti Bakar',
        imageUrl: 'https://via.placeholder.com/300x200?text=Roti+Bakar',
        address: 'Jl. Merdeka No. 12',
        latitude: -6.2100,
        longitude: 106.8300,
        phoneNumber: '08567890123',
        rating: 4.4,
        totalRatings: 95,
        isOpen: true,
        openingHours: '10:00 - 23:00',
        distanceFromCustomer: 1.8,
        createdAt: DateTime.now().subtract(const Duration(days: 180)),
      ),
      Kedai(
        id: 'kedai-6',
        name: 'Seafood Palace',
        description: 'Restoran seafood dengan masakan khas laut',
        category: 'Seafood',
        imageUrl: 'https://via.placeholder.com/300x200?text=Seafood',
        address: 'Jl. Hayam Wuruk No. 34',
        latitude: -6.2120,
        longitude: 106.8280,
        phoneNumber: '08678901234',
        rating: 4.9,
        totalRatings: 312,
        isOpen: true,
        openingHours: '11:00 - 23:00',
        distanceFromCustomer: 2.1,
        createdAt: DateTime.now().subtract(const Duration(days: 150)),
      ),
    ];

    // Mock Promo
    _activePromos = [
      Promo(
        id: 'promo-1',
        kedaiId: 'kedai-1',
        title: 'Nasi Kuning Hemat',
        description: 'Nasi kuning lengkap dengan ayam goreng',
        itemName: 'Nasi Kuning Spesial',
        originalPrice: 25000,
        discountedPrice: 18000,
        discountPercentage: 28,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 7)),
        isActive: true,
      ),
      Promo(
        id: 'promo-2',
        kedaiId: 'kedai-2',
        title: 'Beli 2 Gratis 1',
        description: 'Beli 2 kopi, gratis 1 kopi sedang',
        discountedPrice: 50000,
        discountPercentage: 33,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 5)),
        isActive: true,
      ),
      Promo(
        id: 'promo-3',
        kedaiId: 'kedai-3',
        title: 'Diskon Hari Ini',
        description: 'Semua menu bakso diskon 20%',
        discountPercentage: 20,
        discountedPrice: 16000,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 1)),
        isActive: true,
      ),
    ];

    // Mock Events
    _upcomingEvents = [
      KedaiEvent(
        id: 'event-1',
        kedaiId: 'kedai-2',
        title: 'Live Music Night',
        description: 'Nikmati musik live sambil menikmati kopi premium',
        eventDate: DateTime.now().add(const Duration(days: 5)),
        startTime: '19:00',
        endTime: '22:00',
        location: 'Area lounge kedai',
        isActive: true,
      ),
      KedaiEvent(
        id: 'event-2',
        kedaiId: 'kedai-6',
        title: 'Seafood Buffet',
        description: 'All you can eat seafood premium',
        eventDate: DateTime.now().add(const Duration(days: 10)),
        startTime: '18:00',
        endTime: '23:00',
        isActive: true,
      ),
      KedaiEvent(
        id: 'event-3',
        kedaiId: 'kedai-1',
        title: 'Perayaan Ulang Tahun Kedai',
        description: 'Diskon spesial dan hiburan menarik',
        eventDate: DateTime.now().add(const Duration(days: 3)),
        startTime: '17:00',
        endTime: '21:00',
        isActive: true,
      ),
    ];

    _filteredKedai = List.from(_allKedai);
  }

  void _applyFilters() {
    _filteredKedai = _allKedai.where((kedai) {
      // Search query
      if (_searchController.text.isNotEmpty) {
        final query = _searchController.text.toLowerCase();
        if (!kedai.name.toLowerCase().contains(query) &&
            !kedai.category.toLowerCase().contains(query)) {
          return false;
        }
      }

      // Category filter
      if (_selectedCategory != 'Semua' && kedai.category != _selectedCategory) {
        return false;
      }

      // Radius filter
      if (_selectedRadius != null && kedai.distanceFromCustomer != null) {
        if (kedai.distanceFromCustomer! > _selectedRadius!) {
          return false;
        }
      }

      // Open only filter
      if (_isOpenOnly && !kedai.isOpen) {
        return false;
      }

      // Rating filter
      if (_minRating != null && kedai.rating < _minRating!) {
        return false;
      }

      // Promo filter
      if (_showPromoOnly) {
        bool hasPromo = _activePromos.any((promo) => promo.kedaiId == kedai.id);
        if (!hasPromo) return false;
      }

      // Event filter
      if (_showEventOnly) {
        bool hasEvent = _upcomingEvents.any((event) => event.kedaiId == kedai.id);
        if (!hasEvent) return false;
      }

      return true;
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        title: Text(
          'TONGkrongan',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: AppTheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              // Open notification
            },
            icon: const Icon(Icons.notifications_outlined, color: AppTheme.onSurface),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Search Bar
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: _buildSearchBar(),
            ),
          ),

          // Quick Filters
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: _buildQuickFilters(),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.only(top: 12),
            sliver: SliverToBoxAdapter(
              child: _buildActivePromoSection(),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.only(top: 12),
            sliver: SliverToBoxAdapter(
              child: _buildUpcomingEventsSection(),
            ),
          ),

          // Kedai List
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (_filteredKedai.isEmpty) {
                    return _buildEmptyState();
                  }
                  final kedai = _filteredKedai[index];
                  return _buildKedaiCard(kedai);
                },
                childCount: _filteredKedai.isEmpty ? 1 : _filteredKedai.length,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomerBottomNavigation(currentRoute: '/customer-home'),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Cari kedai, makanan...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  _searchController.clear();
                  _applyFilters();
                },
                icon: const Icon(Icons.close),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onChanged: (_) {
        _applyFilters();
      },
    );
  }

  Widget _buildQuickFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Category filter
          SizedBox(
            width: 150,
            child: DropdownButton<String>(
              value: _selectedCategory,
              isExpanded: true,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCategory = value;
                  });
                  _applyFilters();
                }
              },
              items: _categories
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
            ),
          ),
          const SizedBox(width: 8),

          // Radius filter
          SizedBox(
            width: 130,
            child: DropdownButton<double?>(
              value: _selectedRadius,
              isExpanded: true,
              hint: const Text('Radius'),
              onChanged: (value) {
                setState(() {
                  _selectedRadius = value;
                });
                _applyFilters();
              },
              items: [
                const DropdownMenuItem(value: null, child: Text('Semua Radius')),
                const DropdownMenuItem(value: 1, child: Text('1 km')),
                const DropdownMenuItem(value: 5, child: Text('5 km')),
                const DropdownMenuItem(value: 10, child: Text('10 km')),
                const DropdownMenuItem(value: 25, child: Text('25 km')),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Open only toggle
          FilterChip(
            label: const Text('Buka Sekarang'),
            selected: _isOpenOnly,
            onSelected: (selected) {
              setState(() {
                _isOpenOnly = selected;
              });
              _applyFilters();
            },
          ),
          const SizedBox(width: 8),

          // Promo filter
          FilterChip(
            label: const Text('🔥 Promo'),
            selected: _showPromoOnly,
            onSelected: (selected) {
              setState(() {
                _showPromoOnly = selected;
              });
              _applyFilters();
            },
          ),
          const SizedBox(width: 8),

          // Event filter
          FilterChip(
            label: const Text('🎉 Event'),
            selected: _showEventOnly,
            onSelected: (selected) {
              setState(() {
                _showEventOnly = selected;
              });
              _applyFilters();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActivePromoSection() {
    if (_activePromos.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🔥 Promo Hari Ini',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _activePromos.map((promo) {
                return _buildPromoCard(promo);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCard(Promo promo) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            promo.title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          if (promo.itemName != null)
            Text(
              promo.itemName!,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          const SizedBox(height: 4),
          Row(
            children: [
              if (promo.originalPrice != null) ...[
                Text(
                  'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(promo.originalPrice!)}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 4),
              ],
              Text(
                'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(promo.discountedPrice)}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '-${promo.discountPercentage}%',
              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingEventsSection() {
    if (_upcomingEvents.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🎉 Event Mendatang',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _upcomingEvents.map((event) {
                return _buildEventCard(event);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(KedaiEvent event) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        border: Border.all(color: Colors.purple),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            '📅 ${DateFormat('dd MMM yyyy', 'id_ID').format(event.eventDate)}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (event.startTime != null)
            Text(
              '🕐 ${event.startTime} - ${event.endTime ?? '...'}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          if (event.location != null) ...[
            const SizedBox(height: 4),
            Text(
              '📍 ${event.location}',
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildKedaiCard(Kedai kedai) {
    return GestureDetector(
      onTap: () {
        context.push('/business-detail/${kedai.id}');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    kedai.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Status badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: kedai.isOpen ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      kedai.isOpen ? '🟢 Buka' : '🔴 Tutup',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                // Favorite button
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${kedai.name} ditambahkan ke favorit'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.favorite_outline),
                      iconSize: 20,
                    ),
                  ),
                ),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name & Category
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              kedai.name,
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              kedai.category,
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Rating
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, size: 14, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              '${kedai.rating}',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${kedai.totalRatings})',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.grey.shade600,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Location & Distance
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          kedai.address,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (kedai.distanceFromCustomer != null)
                        Text(
                          '${kedai.distanceFromCustomer!.toStringAsFixed(1)} km',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Hours
                  if (kedai.openingHours != null)
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          kedai.openingHours!,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'Tidak ada kedai yang ditemukan',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Coba ubah filter pencarian Anda',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
