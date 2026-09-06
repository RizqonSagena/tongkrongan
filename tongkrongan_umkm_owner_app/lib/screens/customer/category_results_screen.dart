import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/models/culinary.dart';
import 'package:tongkrongan_umkm_owner_app/services/customer_service.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class CategoryResultsScreen extends StatefulWidget {
  final String categoryName;

  const CategoryResultsScreen({
    required this.categoryName, super.key,
  });

  @override
  State<CategoryResultsScreen> createState() => _CategoryResultsScreenState();
}

class _CategoryResultsScreenState extends State<CategoryResultsScreen> {
  String _activeFilter = 'Jarak Terdekat';
  bool _onlyOpen = false;
  final List<String> _filters = ['Jarak Terdekat', 'Rating Tertinggi', 'Harga Terjangkau', 'Paling Populer'];

  @override
  Widget build(BuildContext context) {
    final customerService = CustomerService();
    var list = customerService.businesses;

    if (widget.categoryName.isNotEmpty && widget.categoryName != 'Semua') {
      list = customerService.getBusinessesByCategory(widget.categoryName);
      if (list.isEmpty) {
        list = customerService.businesses;
      }
    }

    if (_onlyOpen) {
      list = list.where((b) => b.isOpen).toList();
    }

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: Text(
          widget.categoryName.isEmpty ? 'Kategori Kuliner' : widget.categoryName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: AppTheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: AppTheme.primary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Filter lanjutan disesuaikan.')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips Carousel
          Container(
            height: 52,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                FilterChip(
                  label: const Text('Buka Sekarang'),
                  selected: _onlyOpen,
                  selectedColor: AppTheme.secondaryContainer,
                  checkmarkColor: AppTheme.secondary,
                  onSelected: (val) => setState(() => _onlyOpen = val),
                ),
                const SizedBox(width: 8),
                ..._filters.map((filter) {
                  final isSelected = _activeFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: isSelected,
                      selectedColor: AppTheme.primaryFixed,
                      labelStyle: TextStyle(
                        color: isSelected ? AppTheme.onPrimaryFixed : AppTheme.onSurfaceVariant,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 12,
                      ),
                      onSelected: (val) {
                        if (val) setState(() => _activeFilter = filter);
                      },
                    ),
                  );
                }),
              ],
            ),
          ),

          // Total Results Found
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ditemukan ${list.length} tempat kuliner',
                  style: const TextStyle(fontSize: 13, color: AppTheme.onSurfaceVariant, fontWeight: FontWeight.w500),
                ),
                const Text(
                  'Radius: 5 KM',
                  style: TextStyle(fontSize: 12, color: AppTheme.primary, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          // Business List
          Expanded(
            child: list.isEmpty
                ? const Center(
                    child: Text('Belum ada tempat kuliner di kategori ini.'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final business = list[index];
                      return _buildCulinaryCard(context, business);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCulinaryCard(BuildContext context, CulinaryBusiness business) {
    return InkWell(
      onTap: () => context.go('/business-detail/${business.id}'),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.surfaceVariant),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Badges
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    business.coverImage,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 150,
                      color: AppTheme.surfaceContainer,
                      child: const Icon(Icons.restaurant, size: 48, color: AppTheme.outline),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: business.isOpen ? AppTheme.secondary : Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      business.isOpen ? 'BUKA' : 'TUTUP',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          business.rating.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Details
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          business.name,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.onSurface),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        business.formattedDistance,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    business.category,
                    style: const TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        business.priceRange,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.onSurface),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 14, color: AppTheme.outline),
                          const SizedBox(width: 4),
                          Text(
                            business.openingHours,
                            style: const TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant),
                          ),
                        ],
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
}
