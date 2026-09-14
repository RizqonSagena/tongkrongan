import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/models/admin.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class AdminProductsScreen extends StatefulWidget {
  const AdminProductsScreen({super.key});

  @override
  State<AdminProductsScreen> createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends State<AdminProductsScreen> {
  late List<ProductManagement> productList;
  String selectedFilter = 'Semua';

  @override
  void initState() {
    super.initState();
    productList = AdminMockData.generateMockProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Kelola Produk'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProductDialog,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterTabs(),
            const SizedBox(height: 16),
            _buildStatistics(),
            const SizedBox(height: 24),
            Text(
              'Daftar Produk',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildProductList(),
            const SizedBox(height: 24),
            // Important Notice
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.blue, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '⚠️ Admin TIDAK dapat edit harga - Itu hak Owner saja',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
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

  Widget _buildFilterTabs() {
    return Row(
      children: ['Semua', 'Tersedia', 'Tidak Tersedia']
          .map((filter) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(filter),
                  selected: selectedFilter == filter,
                  onSelected: (selected) {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                ),
              ))
          .toList(),
    );
  }

  Widget _buildStatistics() {
    int total = productList.length;
    int available = productList.where((p) => p.isAvailable).length;
    int unavailable = productList.where((p) => !p.isAvailable).length;

    return Row(
      children: [
        Expanded(child: _buildStatCard('Total', '$total', Colors.blue)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('Tersedia', '$available', Colors.green)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('Tidak', '$unavailable', Colors.orange)),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey.shade600)),
          const SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    List<ProductManagement> filtered = productList.where((p) {
      switch (selectedFilter) {
        case 'Tersedia':
          return p.isAvailable;
        case 'Tidak Tersedia':
          return !p.isAvailable;
        default:
          return true;
      }
    }).toList();

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filtered.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final product = filtered[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(child: const Text('Edit'), onTap: () => _showEditDialog(product)),
                      PopupMenuItem(
                        child: Text(product.isAvailable ? 'Nonaktifkan' : 'Aktifkan'),
                        onTap: () => _toggleAvailability(product),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                product.description,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey.shade600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      product.category,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppTheme.primary),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: product.isAvailable ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      product.isAvailable ? '✓ Tersedia' : '○ Tidak',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: product.isAvailable ? Colors.green : Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Produk'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Nama Produk')),
            const SizedBox(height: 12),
            TextField(decoration: const InputDecoration(labelText: 'Deskripsi'), maxLines: 2),
            const SizedBox(height: 12),
            DropdownButtonFormField(
              items: ['Makanan', 'Minuman', 'Snack']
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (_) {},
              decoration: const InputDecoration(labelText: 'Kategori'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Produk berhasil ditambahkan (harga diatur owner)')),
              );
              Navigator.pop(context);
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(ProductManagement product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Produk'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: product.name,
              decoration: const InputDecoration(labelText: 'Nama Produk'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: product.description,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: product.estimatedPrepTimeMinutes.toString(),
              decoration: const InputDecoration(labelText: 'Waktu Persiapan (menit)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Simpan')),
        ],
      ),
    );
  }

  void _toggleAvailability(ProductManagement product) {
    setState(() {
      product.isAvailable ? product.deactivate('ADMIN001') : product.activate('ADMIN001');
    });
  }
}
