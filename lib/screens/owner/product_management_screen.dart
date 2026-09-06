import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/owner/bottom_navigation.dart';
import 'package:intl/intl.dart';

class ProductManagementScreen extends StatefulWidget {
  const ProductManagementScreen({super.key});

  @override
  State<ProductManagementScreen> createState() => _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Semua';
  final List<String> _categories = ['Semua', 'Minuman', 'Makanan', 'Snack'];

  // Mock product data
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Es Kopi Susu',
      category: 'Minuman',
      price: 15000,
      stock: 25,
      unitsSold: 156,
      status: ProductStatus.terlaris,
      imageUrl: 'https://example.com/kopi.jpg',
    ),
    Product(
      id: '2',
      name: 'Nasi Goreng Kampung',
      category: 'Makanan',
      price: 18000,
      stock: 12,
      unitsSold: 89,
      status: ProductStatus.tersedia,
      imageUrl: 'https://example.com/nasgor.jpg',
    ),
    Product(
      id: '3',
      name: 'Roti Bakar',
      category: 'Makanan',
      price: 12000,
      stock: 3,
      unitsSold: 45,
      status: ProductStatus.stokMenipis,
      imageUrl: 'https://example.com/roti.jpg',
    ),
    Product(
      id: '4',
      name: 'Teh Manis',
      category: 'Minuman',
      price: 8000,
      stock: 0,
      unitsSold: 78,
      status: ProductStatus.tidakTersedia,
      imageUrl: 'https://example.com/teh.jpg',
    ),
    Product(
      id: '5',
      name: 'Pisang Goreng',
      category: 'Snack',
      price: 10000,
      stock: 20,
      unitsSold: 67,
      status: ProductStatus.tersedia,
      imageUrl: 'https://example.com/pisgor.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        title: Text(
          'Kelola Produk',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: AppTheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: _showAddProductDialog,
            icon: const Icon(
              Icons.add_circle,
              color: AppTheme.primary,
              size: 28,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          _buildSearchBar(),
          
          // Category Filter
          _buildCategoryFilter(),
          
          // Product List
          Expanded(
            child: _buildProductList(),
          ),
        ],
      ),
      bottomNavigationBar: const OwnerBottomNavigation(currentIndex: 2),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(AppTheme.marginMobile),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.outline.withValues(alpha: 0.3)),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Cari produk...',
          prefixIcon: const Icon(Icons.search, color: AppTheme.onSurfaceVariant),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spaceMd,
            vertical: AppTheme.spaceMd,
          ),
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppTheme.onSurfaceVariant,
          ),
        ),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.marginMobile),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _categories.map((category) {
            final isSelected = category == _selectedCategory;
            return Container(
              margin: const EdgeInsets.only(right: AppTheme.spaceXs),
              child: FilterChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
                backgroundColor: AppTheme.surfaceContainerHigh,
                selectedColor: AppTheme.primary,
                labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: isSelected ? AppTheme.onPrimary : AppTheme.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildProductList() {
    final filteredProducts = _selectedCategory == 'Semua'
        ? _products
        : _products.where((p) => p.category == _selectedCategory).toList();

    return Container(
      margin: const EdgeInsets.all(AppTheme.marginMobile),
      child: ListView.builder(
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          return _buildProductCard(filteredProducts[index]);
        },
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.onSurface.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image and Status Badge
          Stack(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppTheme.surfaceContainer,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Icon(
                  _getProductIcon(product.category),
                  size: 48,
                  color: AppTheme.primary.withValues(alpha: 0.6),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: _buildStatusBadge(product.status),
              ),
            ],
          ),
          
          // Product Details
          Padding(
            padding: const EdgeInsets.all(AppTheme.spaceMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppTheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) => _handleProductAction(value, product),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 20),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 20, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Hapus', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                      child: const Icon(
                        Icons.more_vert,
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppTheme.spaceXs),
                
                Text(
                  currencyFormat.format(product.price),
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: AppTheme.spaceXs),
                
                Row(
                  children: [
                    Text(
                      'Terjual: ${product.unitsSold}',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spaceMd),
                    Text(
                      'Stok: ${product.stock}',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: product.stock < 5 ? AppTheme.error : AppTheme.onSurfaceVariant,
                        fontWeight: product.stock < 5 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(ProductStatus status) {
    String text;
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case ProductStatus.terlaris:
        text = 'TERLARIS';
        backgroundColor = AppTheme.error;
        textColor = AppTheme.onError;
        break;
      case ProductStatus.stokMenipis:
        text = 'STOK MENIPIS';
        backgroundColor = AppTheme.tertiary;
        textColor = AppTheme.onTertiary;
        break;
      case ProductStatus.tersedia:
        text = 'TERSEDIA';
        backgroundColor = AppTheme.secondary;
        textColor = AppTheme.onSecondary;
        break;
      case ProductStatus.tidakTersedia:
        text = 'TIDAK TERSEDIA';
        backgroundColor = AppTheme.surfaceContainerHigh;
        textColor = AppTheme.onSurfaceVariant;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  IconData _getProductIcon(String category) {
    switch (category) {
      case 'Minuman':
        return Icons.local_cafe;
      case 'Makanan':
        return Icons.restaurant;
      case 'Snack':
        return Icons.cake;
      default:
        return Icons.inventory;
    }
  }

  void _handleProductAction(String action, Product product) {
    if (action == 'edit') {
      _showEditProductDialog(product);
    } else if (action == 'delete') {
      _showDeleteConfirmation(product);
    }
  }

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Produk Baru'),
        content: const Text('Form tambah produk akan ditampilkan di sini.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showEditProductDialog(Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${product.name}'),
        content: const Text('Form edit produk akan ditampilkan di sini.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Produk'),
        content: Text('Apakah Anda yakin ingin menghapus ${product.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String id;
  final String name;
  final String category;
  final int price;
  final int stock;
  final int unitsSold;
  final ProductStatus status;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.unitsSold,
    required this.status,
    required this.imageUrl,
  });
}

enum ProductStatus {
  terlaris,
  stokMenipis,
  tersedia,
  tidakTersedia,
}