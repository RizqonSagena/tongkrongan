import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/customer/business_card.dart';
import '../../widgets/customer/customer_bottom_navigation.dart';
import '../../screens/customer/customer_home_screen.dart';

class ExploreMapScreen extends StatefulWidget {
  const ExploreMapScreen({super.key});

  @override
  State<ExploreMapScreen> createState() => _ExploreMapScreenState();
}

class _ExploreMapScreenState extends State<ExploreMapScreen> {
  String selectedRadius = '3 KM';
  String selectedCategory = 'Semua';
  String selectedPriceRange = 'Semua';
  bool showOpenOnly = false;

  final List<String> radiusOptions = ['1 KM', '3 KM', '5 KM', '10 KM'];
  final List<String> categoryFilters = [
    'Semua', 'Kopi', 'Cafe', 'Restoran', 'Makanan Tradisional', 
    'Seafood', 'Bakery', 'Bakso', 'PKL', 'Oleh-Oleh'
  ];
  final List<String> priceRanges = [
    'Semua', 'Di bawah 20rb', '20-50rb', '50-100rb', 'Di atas 100rb'
  ];

  final List<MapMarker> mapMarkers = [
    MapMarker(
      id: '1',
      lat: -7.7956,
      lng: 110.3695,
      business: Business(
        id: '1',
        name: 'Warung Kopi Pak Budi',
        category: 'Kopi',
        rating: 4.5,
        distance: '0.2 km',
        isOpen: true,
        startingPrice: 'Rp 8.000',
        imageUrl: 'assets/images/kopi_pak_budi.jpg',
        promoText: '',
      ),
    ),
    MapMarker(
      id: '2',
      lat: -7.7980,
      lng: 110.3715,
      business: Business(
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
    ),
    MapMarker(
      id: '3',
      lat: -7.7932,
      lng: 110.3678,
      business: Business(
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
    ),
  ];

  List<MapMarker> get filteredMarkers {
    return mapMarkers.where((marker) {
      if (selectedCategory != 'Semua' && marker.business.category != selectedCategory) {
        return false;
      }
      if (showOpenOnly && !marker.business.isOpen) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header with filters
            _buildHeader(),
            
            // Map Area
            Expanded(
              flex: 2,
              child: _buildMapArea(),
            ),
            
            // Bottom Business Cards
            Expanded(
              flex: 1,
              child: _buildBottomBusinessCards(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomerBottomNavigation(currentIndex: 1),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Title and back button
          Row(
            children: [
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 12),
              const Text(
                'Jelajahi Peta',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: _showFilterDialog,
                icon: const Icon(Icons.tune),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Quick filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildQuickFilter(
                  selectedRadius,
                  Icons.location_on,
                  () => _showRadiusSelector(),
                ),
                const SizedBox(width: 8),
                _buildQuickFilter(
                  selectedCategory,
                  Icons.category,
                  () => _showCategorySelector(),
                ),
                const SizedBox(width: 8),
                _buildQuickFilter(
                  showOpenOnly ? 'Buka Sekarang' : 'Semua Status',
                  Icons.access_time,
                  () => setState(() => showOpenOnly = !showOpenOnly),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilter(String text, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue[200]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.blue[800]),
            const SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.blue[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapArea() {
    return Container(
      color: Colors.grey[200],
      child: Stack(
        children: [
          // Map placeholder with grid pattern
          Container(
            decoration: BoxDecoration(
              color: Colors.green[50],
              image: const DecorationImage(
                image: AssetImage('assets/images/map_pattern.png'),
                repeat: ImageRepeat.repeat,
                opacity: 0.1,
              ),
            ),
          ),
          
          // User location indicator
          const Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.my_location,
                    color: Colors.blue,
                    size: 32,
                  ),
                  Text(
                    'Lokasi Anda',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Business markers
          ...filteredMarkers.map((marker) => _buildMarker(marker)),
          
          // Radius circle overlay
          Positioned.fill(
            child: CustomPaint(
              painter: RadiusCirclePainter(
                radius: _getRadiusInPixels(),
                color: Colors.blue.withOpacity(0.1),
              ),
            ),
          ),
          
          // Map controls
          Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton.small(
                  heroTag: 'zoom_in',
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.add, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                FloatingActionButton.small(
                  heroTag: 'zoom_out',
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.remove, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                FloatingActionButton.small(
                  heroTag: 'my_location',
                  onPressed: () {},
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.my_location, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarker(MapMarker marker) {
    final categoryColors = {
      'Kopi': Colors.brown,
      'Cafe': Colors.orange,
      'Restoran': Colors.red,
      'Makanan Tradisional': Colors.green,
      'Seafood': Colors.blue,
      'Bakery': Colors.amber,
      'Bakso': Colors.purple,
      'Pedagang Kaki Lima': Colors.teal,
      'Oleh-Oleh': Colors.pink,
    };

    final color = categoryColors[marker.business.category] ?? Colors.grey;

    return Positioned(
      left: MediaQuery.of(context).size.width * 0.3 + (marker.lat * 100),
      top: 150 + (marker.lng * 50),
      child: GestureDetector(
        onTap: () => _showMarkerDetail(marker.business),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.restaurant,
                color: Colors.white,
                size: 16,
              ),
            ),
            Container(
              width: 2,
              height: 8,
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBusinessCards() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Kuliner di Sekitar Anda (${filteredMarkers.length})',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredMarkers.length,
              itemBuilder: (context, index) {
                return BusinessCard(
                  business: filteredMarkers[index].business,
                  isHorizontal: true,
                  onTap: () => context.push(
                    '/business-detail',
                    extra: filteredMarkers[index].business.id,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  double _getRadiusInPixels() {
    final radiusKm = double.parse(selectedRadius.split(' ')[0]);
    return radiusKm * 50; // Simplified conversion for demo
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Filter Pencarian',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            
            // Category filter
            const Text('Kategori', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: categoryFilters.map((category) {
                final isSelected = selectedCategory == category;
                return FilterChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      selectedCategory = selected ? category : 'Semua';
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            
            // Open now toggle
            SwitchListTile(
              title: const Text('Hanya yang sedang buka'),
              value: showOpenOnly,
              onChanged: (value) {
                setState(() {
                  showOpenOnly = value;
                });
                Navigator.pop(context);
              },
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  void _showRadiusSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pilih Radius'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: radiusOptions.map((radius) {
            return RadioListTile<String>(
              title: Text(radius),
              value: radius,
              groupValue: selectedRadius,
              onChanged: (value) {
                setState(() {
                  selectedRadius = value!;
                });
                Navigator.pop(context);
              },
              contentPadding: EdgeInsets.zero,
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showCategorySelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pilih Kategori'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: categoryFilters.length,
            itemBuilder: (context, index) {
              final category = categoryFilters[index];
              return RadioListTile<String>(
                title: Text(category),
                value: category,
                groupValue: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                  Navigator.pop(context);
                },
                contentPadding: EdgeInsets.zero,
              );
            },
          ),
        ),
      ),
    );
  }

  void _showMarkerDetail(Business business) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: BusinessCard(
          business: business,
          isHorizontal: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.push('/business-detail', extra: business.id);
            },
            child: const Text('Lihat Detail'),
          ),
        ],
      ),
    );
  }
}

class MapMarker {
  final String id;
  final double lat;
  final double lng;
  final Business business;

  MapMarker({
    required this.id,
    required this.lat,
    required this.lng,
    required this.business,
  });
}

class RadiusCirclePainter extends CustomPainter {
  final double radius;
  final Color color;

  RadiusCirclePainter({required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 3);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}