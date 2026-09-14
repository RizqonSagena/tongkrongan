import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tongkrongan_umkm_owner_app/models/customer.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class KedaiDetailScreen extends StatefulWidget {
  final String kedaiId;

  const KedaiDetailScreen({
    super.key,
    required this.kedaiId,
  });

  @override
  State<KedaiDetailScreen> createState() => _KedaiDetailScreenState();
}

class _KedaiDetailScreenState extends State<KedaiDetailScreen> {
  late Kedai _kedai;
  late List<MenuItem> _menuItems;
  late List<KedaiRating> _ratings;
  late List<Promo> _promos;
  
  bool _isFavorite = false;
  String _selectedMenuCategory = 'Semua';
  double _userRating = 0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeMockData();
  }

  void _initializeMockData() {
    // Mock Kedai data
    _kedai = Kedai(
      id: widget.kedaiId,
      name: 'Nasi Kuning Pak Hendra',
      description: 'Nasi kuning tradisional dengan lauk pauk pilihan terbaik. Bahan-bahan berkualitas dan resep turun temurun.',
      category: 'Nasi Kuning',
      imageUrl: 'https://via.placeholder.com/400x300?text=Nasi+Kuning',
      additionalImageUrls: [
        'https://via.placeholder.com/400x300?text=Interior+1',
        'https://via.placeholder.com/400x300?text=Menu+1',
        'https://via.placeholder.com/400x300?text=Menu+2',
      ],
      address: 'Jl. Raya Bogor No. 123, Jakarta',
      latitude: -6.2088,
      longitude: 106.8456,
      phoneNumber: '08123456789',
      whatsappNumber: '6208123456789',
      rating: 4.8,
      totalRatings: 156,
      isOpen: true,
      openingHours: '08:00 - 22:00',
      distanceFromCustomer: 1.2,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
    );

    // Mock Menu Items
    _menuItems = [
      MenuItem(
        id: 'menu-1',
        kedaiId: widget.kedaiId,
        name: 'Nasi Kuning Spesial',
        description: 'Nasi kuning dengan ayam goreng, telur, dan lauk pauk pilihan',
        price: 25000,
        category: MenuCategory.makanan,
        imageUrl: 'https://via.placeholder.com/300x200?text=Nasi+Kuning+Spesial',
        isAvailable: true,
        estimatedPreparationTime: 15,
        rating: 4.9,
      ),
      MenuItem(
        id: 'menu-2',
        kedaiId: widget.kedaiId,
        name: 'Nasi Kuning Ekonomis',
        description: 'Nasi kuning dengan lauk pauk standar',
        price: 15000,
        category: MenuCategory.makanan,
        imageUrl: 'https://via.placeholder.com/300x200?text=Nasi+Kuning+Ekonomis',
        isAvailable: true,
        estimatedPreparationTime: 10,
        rating: 4.6,
      ),
      MenuItem(
        id: 'menu-3',
        kedaiId: widget.kedaiId,
        name: 'Kopi Susu',
        description: 'Kopi premium dengan susu segar',
        price: 8000,
        category: MenuCategory.minuman,
        imageUrl: 'https://via.placeholder.com/300x200?text=Kopi+Susu',
        isAvailable: true,
        estimatedPreparationTime: 5,
        rating: 4.7,
      ),
      MenuItem(
        id: 'menu-4',
        kedaiId: widget.kedaiId,
        name: 'Es Teh Manis',
        description: 'Es teh segar dengan teh pilihan',
        price: 5000,
        category: MenuCategory.minuman,
        imageUrl: 'https://via.placeholder.com/300x200?text=Es+Teh+Manis',
        isAvailable: true,
        estimatedPreparationTime: 3,
        rating: 4.5,
      ),
      MenuItem(
        id: 'menu-5',
        kedaiId: widget.kedaiId,
        name: 'Perkedel',
        description: 'Perkedel goreng renyah dengan sambal',
        price: 3000,
        category: MenuCategory.snack,
        imageUrl: 'https://via.placeholder.com/300x200?text=Perkedel',
        isAvailable: true,
        rating: 4.4,
      ),
    ];

    // Mock Ratings
    _ratings = [
      KedaiRating(
        id: 'rating-1',
        kedaiId: widget.kedaiId,
        customerId: 'cust-1',
        customerName: 'Budi Santoso',
        rating: 5,
        review: 'Nasi kuningnya sangat lezat dan penyajian cepat!',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        helpfulCount: 12,
      ),
      KedaiRating(
        id: 'rating-2',
        kedaiId: widget.kedaiId,
        customerId: 'cust-2',
        customerName: 'Siti Nurhaliza',
        rating: 5,
        review: 'Tempat yang nyaman dan makanan berkualitas tinggi',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        helpfulCount: 8,
      ),
      KedaiRating(
        id: 'rating-3',
        kedaiId: widget.kedaiId,
        customerId: 'cust-3',
        customerName: 'Ahmad Wijaya',
        rating: 4,
        review: 'Bagus, tapi agak mahal',
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        helpfulCount: 5,
      ),
    ];

    // Mock Promos
    _promos = [
      Promo(
        id: 'promo-1',
        kedaiId: widget.kedaiId,
        title: 'Nasi Kuning Hemat',
        description: 'Promo spesial hari kerja',
        itemName: 'Nasi Kuning Spesial',
        originalPrice: 25000,
        discountedPrice: 18000,
        discountPercentage: 28,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 7)),
        isActive: true,
      ),
    ];
  }

  List<MenuItem> get _filteredMenuItems {
    if (_selectedMenuCategory == 'Semua') {
      return _menuItems;
    }
    return _menuItems
        .where((item) => item.category.toString().split('.').last == _selectedMenuCategory.toLowerCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header dengan foto
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    _kedai.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
            actions: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () {
                    setState(() => _isFavorite = !_isFavorite);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          _isFavorite
                              ? '${_kedai.name} ditambahkan ke favorit'
                              : '${_kedai.name} dihapus dari favorit',
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: _isFavorite ? Colors.red : Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),

          // Info Utama
          SliverToBoxAdapter(
            child: _buildMainInfo(),
          ),

          // Additional Gallery
          if (_kedai.additionalImageUrls != null && _kedai.additionalImageUrls!.isNotEmpty)
            SliverToBoxAdapter(
              child: _buildGallery(),
            ),

          // Menu Section
          SliverToBoxAdapter(
            child: _buildMenuHeader(),
          ),

          SliverToBoxAdapter(
            child: _buildMenuCategoryFilter(),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildMenuItemCard(_filteredMenuItems[index]),
              childCount: _filteredMenuItems.length,
            ),
          ),

          // Promos Section
          if (_promos.isNotEmpty)
            SliverToBoxAdapter(
              child: _buildPromosSection(),
            ),

          // Ratings Section
          SliverToBoxAdapter(
            child: _buildRatingsHeader(),
          ),

          SliverToBoxAdapter(
            child: _buildRatingInput(),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildRatingCard(_ratings[index]),
              childCount: _ratings.length,
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to reservation screen
                  context.push('/customer-reservation/${_kedai.id}');
                },
                icon: const Icon(Icons.calendar_today),
                label: const Text('Buat Reservasi'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: ElevatedButton.icon(
                onPressed: () {
                  context.push('/management-chat/${_kedai.id}');
                },
                icon: const Icon(Icons.chat),
                label: const Text('Hubungi Pengelola'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          const SliverPadding(
            padding: EdgeInsets.only(bottom: 16),
            sliver: SliverToBoxAdapter(child: SizedBox.shrink()),
          ),
        ],
      ),
    );
  }

  Widget _buildMainInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nama & Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _kedai.name,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _kedai.category,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _kedai.isOpen ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _kedai.isOpen ? 'Buka' : 'Tutup',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Rating
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, size: 18, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '${_kedai.rating}',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${_kedai.totalRatings} rating',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Deskripsi
          Text(
            _kedai.description,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.grey.shade700,
            ),
          ),

          const SizedBox(height: 16),

          // Info Details
          _buildInfoRow(
            icon: Icons.location_on,
            label: 'Lokasi',
            value: _kedai.address,
          ),
          const SizedBox(height: 8),
          _buildInfoRow(
            icon: Icons.access_time,
            label: 'Jam Operasional',
            value: _kedai.openingHours ?? '-',
          ),
          const SizedBox(height: 8),
          _buildInfoRow(
            icon: Icons.phone,
            label: 'Telepon',
            value: _kedai.phoneNumber,
          ),
          if (_kedai.distanceFromCustomer != null) ...[
            const SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.navigation,
              label: 'Jarak',
              value: '${_kedai.distanceFromCustomer!.toStringAsFixed(1)} km dari lokasi Anda',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppTheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGallery() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Galeri Foto',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _kedai.additionalImageUrls!.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(_kedai.additionalImageUrls![index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Text(
        '📋 Menu',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMenuCategoryFilter() {
    final categories = [
      'Semua',
      'Makanan',
      'Minuman',
      'Snack',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            final isSelected = _selectedMenuCategory == category;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedMenuCategory = category;
                  });
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMenuItemCard(MenuItem item) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.network(
              item.imageUrl ?? '',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(item.price)}',
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (item.estimatedPreparationTime != null)
                            Text(
                              '⏱️ ${item.estimatedPreparationTime} menit',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 10,
                              ),
                            ),
                        ],
                      ),
                      if (item.rating != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star, size: 12, color: Colors.amber),
                              const SizedBox(width: 2),
                              Text(
                                '${item.rating}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromosSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🔥 Promo',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ..._promos.map((promo) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        promo.title,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '-${promo.discountPercentage}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(promo.description),
                  if (promo.originalPrice != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(promo.originalPrice!)}',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(promo.discountedPrice)}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    'Berlaku s/d ${DateFormat('dd MMM yyyy', 'id_ID').format(promo.endDate)}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRatingsHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Text(
        '⭐ Rating & Ulasan',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRatingInput() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Berikan Rating',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(
                5,
                (index) => IconButton(
                  onPressed: () {
                    setState(() {
                      _userRating = (index + 1).toDouble();
                    });
                  },
                  icon: Icon(
                    index < _userRating ? Icons.star : Icons.star_outline,
                    color: Colors.amber,
                    size: 28,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _reviewController,
              decoration: InputDecoration(
                hintText: 'Tulis ulasan Anda (opsional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _userRating > 0
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Rating berhasil dikirim!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        _reviewController.clear();
                        setState(() => _userRating = 0);
                      }
                    : null,
                child: const Text('Kirim Rating'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingCard(KedaiRating rating) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                rating.customerName,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < rating.rating ? Icons.star : Icons.star_outline,
                    size: 14,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (rating.review != null)
            Text(
              rating.review!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('dd MMM yyyy', 'id_ID').format(rating.createdAt),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.thumb_up, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    '${rating.helpfulCount}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }
}
