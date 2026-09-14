import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tongkrongan_umkm_owner_app/models/customer.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/customer/customer_bottom_navigation.dart';

class CustomerFavoritesScreen extends StatefulWidget {
  const CustomerFavoritesScreen({super.key});

  @override
  State<CustomerFavoritesScreen> createState() => _CustomerFavoritesScreenState();
}

class _CustomerFavoritesScreenState extends State<CustomerFavoritesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _sortBy = 'name'; // name, rating, distance
  String _filterCategory = 'Semua';

  late List<FavoriteKedai> _favorites;
  late List<FavoriteKedai> _filteredFavorites;

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
    final mockKedaiList = [
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

    _favorites = [
      FavoriteKedai(
        id: 'fav-1',
        customerId: 'cust-123',
        kedaiId: mockKedaiList[0].id,
        kedai: mockKedaiList[0],
        addedAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
      FavoriteKedai(
        id: 'fav-2',
        customerId: 'cust-123',
        kedaiId: mockKedaiList[1].id,
        kedai: mockKedaiList[1],
        addedAt: DateTime.now().subtract(const Duration(days: 15)),
      ),
      FavoriteKedai(
        id: 'fav-3',
        customerId: 'cust-123',
        kedaiId: mockKedaiList[2].id,
        kedai: mockKedaiList[2],
        addedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      FavoriteKedai(
        id: 'fav-4',
        customerId: 'cust-123',
        kedaiId: mockKedaiList[3].id,
        kedai: mockKedaiList[3],
        addedAt: DateTime.now().subtract(const Duration(days: 20)),
      ),
    ];

    _filteredFavorites = List.from(_favorites);
  }

  void _applyFilters() {
    _filteredFavorites = _favorites.where((fav) {
      // Search query
      if (_searchController.text.isNotEmpty) {
        final query = _searchController.text.toLowerCase();
        if (!fav.kedai.name.toLowerCase().contains(query) &&
            !fav.kedai.category.toLowerCase().contains(query)) {
          return false;
        }
      }

      // Category filter
      if (_filterCategory != 'Semua' && fav.kedai.category != _filterCategory) {
        return false;
      }

      return true;
    }).toList();

    // Apply sorting
    switch (_sortBy) {
      case 'name':
        _filteredFavorites.sort((a, b) => a.kedai.name.compareTo(b.kedai.name));
        break;
      case 'rating':
        _filteredFavorites.sort((a, b) => b.kedai.rating.compareTo(a.kedai.rating));
        break;
      case 'distance':
        _filteredFavorites.sort((a, b) {
          final distA = a.kedai.distanceFromCustomer ?? 999;
          final distB = b.kedai.distanceFromCustomer ?? 999;
          return distA.compareTo(distB);
        });
        break;
    }

    setState(() {});
  }

  void _removeFavorite(FavoriteKedai favorite) {
    setState(() {
      _favorites.remove(favorite);
      _applyFilters();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${favorite.kedai.name} dihapus dari favorit'),
        action: SnackBarAction(
          label: 'Batalkan',
          onPressed: () {
            setState(() {
              _favorites.add(favorite);
              _applyFilters();
            });
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        title: Text(
          'Kedai Favorit',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: AppTheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_filteredFavorites.length}',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari di favorit...',
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
                ),
                const SizedBox(height: 12),

                // Category & Sort Filters
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: _filterCategory,
                        isExpanded: true,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _filterCategory = value;
                            });
                            _applyFilters();
                          }
                        },
                        items: _categories
                            .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                            .toList(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    PopupMenuButton<String>(
                      initialValue: _sortBy,
                      onSelected: (value) {
                        setState(() {
                          _sortBy = value;
                        });
                        _applyFilters();
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          value: 'name',
                          child: Text('Urutkan: Nama'),
                        ),
                        const PopupMenuItem(
                          value: 'rating',
                          child: Text('Urutkan: Rating'),
                        ),
                        const PopupMenuItem(
                          value: 'distance',
                          child: Text('Urutkan: Jarak'),
                        ),
                      ],
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.sort, size: 18),
                            const SizedBox(width: 4),
                            const Text('Urutkan'),
                            const SizedBox(width: 4),
                            Icon(Icons.arrow_drop_down, size: 18, color: Colors.grey.shade600),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Favorites List
          if (_filteredFavorites.isEmpty)
            Expanded(
              child: _buildEmptyState(),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _filteredFavorites.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final favorite = _filteredFavorites[index];
                  return _buildFavoriteCard(favorite);
                },
              ),
            ),
        ],
      ),
      bottomNavigationBar: const CustomerBottomNavigation(currentLocation: '/customer-favorites'),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_outline,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada kedai favorit',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Mulai tambahkan kedai favorit Anda untuk akses cepat',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.go('/customer-home');
            },
            child: const Text('Jelajahi Kedai'),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteCard(FavoriteKedai favorite) {
    final kedai = favorite.kedai;
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
                    height: 180,
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
                // Remove favorite button
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
                        _removeFavorite(favorite);
                      },
                      icon: const Icon(Icons.favorite),
                      iconSize: 20,
                      color: Colors.red,
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

                  // Added date
                  Text(
                    'Ditambahkan ${DateFormat('dd MMM yyyy', 'id_ID').format(favorite.addedAt)}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey.shade500,
                      fontSize: 11,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            context.push('/business-detail/${kedai.id}');
                          },
                          icon: const Icon(Icons.info_outline, size: 16),
                          label: const Text('Detail'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.push('/customer-reservation/${kedai.id}');
                          },
                          icon: const Icon(Icons.calendar_today, size: 16),
                          label: const Text('Reservasi'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
