import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/models/culinary.dart';
import 'package:tongkrongan_umkm_owner_app/services/customer_service.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class MenuHargaScreen extends StatefulWidget {
  final String warungId;

  const MenuHargaScreen({
    required this.warungId, super.key,
  });

  @override
  State<MenuHargaScreen> createState() => _MenuHargaScreenState();
}

class _MenuHargaScreenState extends State<MenuHargaScreen> {
  final TextEditingController _searchController = TextEditingController();
  late CulinaryBusiness business;
  String _selectedCategory = 'Semua';

  @override
  void initState() {
    super.initState();
    final found = CustomerService().getBusinessById(widget.warungId);
    business = found ?? CustomerService().businesses.first;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var items = business.menuItems;

    if (_searchController.text.isNotEmpty) {
      items = items.where((m) => m.name.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
    }

    if (_selectedCategory != 'Semua') {
      items = items.where((m) => m.category == _selectedCategory).toList();
    }

    final categories = ['Semua', ...{...business.menuItems.map((e) => e.category)}];

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Menu & Harga', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(business.name, style: const TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant)),
          ],
        ),
        backgroundColor: AppTheme.surface,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Cari menu makanan atau minuman...',
                prefixIcon: const Icon(Icons.search, color: AppTheme.outline),
                filled: true,
                fillColor: AppTheme.surfaceContainerLow,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Categories chips
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    selectedColor: AppTheme.primaryFixed,
                    labelStyle: TextStyle(
                      color: isSelected ? AppTheme.onPrimaryFixed : AppTheme.onSurfaceVariant,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12,
                    ),
                    onSelected: (val) {
                      if (val) setState(() => _selectedCategory = cat);
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // Menu List
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('Menu tidak ditemukan.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _buildMenuCard(item);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(MenuItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.surfaceVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 80,
                    height: 80,
                    color: AppTheme.surfaceContainer,
                    child: const Icon(Icons.fastfood, color: AppTheme.outline),
                  ),
                ),
              ),
              if (item.isPopular)
                Positioned(
                  top: 4,
                  left: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'FAVORIT',
                      style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.onSurface),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: item.isAvailable ? AppTheme.secondaryContainer : Colors.grey[300],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.isAvailable ? 'Tersedia' : 'Habis',
                        style: TextStyle(
                          color: item.isAvailable ? AppTheme.secondary : Colors.grey[700],
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant, height: 1.3),
                ),
                const SizedBox(height: 8),
                Text(
                  item.formattedPrice,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
