import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/models/owner.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class OwnerProductManagementScreen extends StatefulWidget {
  const OwnerProductManagementScreen({super.key});

  @override
  State<OwnerProductManagementScreen> createState() =>
      _OwnerProductManagementScreenState();
}

class _OwnerProductManagementScreenState extends State<OwnerProductManagementScreen> {
  late List<Product> products;
  String selectedFilter = 'Semua'; // Semua, Tersedia, Habis, Tidak Aktif
  String searchText = '';

  @override
  void initState() {
    super.initState();
    products = OwnerMockData.generateMockProducts();
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
            // Search Bar
            _buildSearchBar(),

            const SizedBox(height: 16),

            // Filter Tabs
            _buildFilterTabs(),

            const SizedBox(height: 16),

            // Statistics
            _buildStatistics(),

            const SizedBox(height: 24),

            // Products List
            Text(
              'Daftar Produk',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildProductsList(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchText = value.toLowerCase();
        });
      },
      decoration: InputDecoration(
        hintText: 'Cari produk...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: searchText.isNotEmpty
            ? IconButton(
                onPressed: () {
                  setState(() {
                    searchText = '';
                  });
                },
                icon: const Icon(Icons.clear),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildFilterTabs() {
    final filters = ['Semua', 'Tersedia', 'Habis', 'Tidak Aktif'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters
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
                    backgroundColor: Colors.grey.shade200,
                    selectedColor: AppTheme.primary,
                    labelStyle: TextStyle(
                      color: selectedFilter == filter ? Colors.white : Colors.black,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildStatistics() {
    int total = products.length;
    int available = products.where((p) => p.isAvailable && p.stock > 0).length;
    int outOfStock = products.where((p) => p.stock <= 0).length;
    int inactive = products.where((p) => !p.isAvailable).length;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard('Total', '$total', Colors.blue),
        _buildStatCard('Tersedia', '$available', Colors.green),
        _buildStatCard('Habis', '$outOfStock', Colors.orange),
        _buildStatCard('Tidak Aktif', '$inactive', Colors.red),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsList() {
    List<Product> filtered = _getFilteredProducts();

    if (filtered.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(Icons.shopping_bag, size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                'Tidak ada produk',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filtered.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _buildProductCard(filtered[index]),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () => _showProductDetail(product),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.name,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              product.category,
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text('Edit'),
                      onTap: () => _showEditProductDialog(product),
                    ),
                    PopupMenuItem(
                      child: Text(product.isAvailable ? 'Nonaktifkan' : 'Aktifkan'),
                      onTap: () => _toggleProductStatus(product),
                    ),
                    PopupMenuItem(
                      child: const Text('Hapus'),
                      onTap: () => _deleteProduct(product),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Price & Stock Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Harga Jual',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Rp${product.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HPP',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      product.hpp != null
                          ? 'Rp${product.hpp!.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}'
                          : '-',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Margin',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${product.profitMargin.toStringAsFixed(1)}%',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Stock & Status Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.inventory_2, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      '${product.stock} stok',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(product).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        product.isAvailable
                            ? Icons.check_circle
                            : Icons.cancel,
                        size: 14,
                        color: _getStatusColor(product),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        product.isAvailable ? 'Aktif' : 'Nonaktif',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: _getStatusColor(product),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Sales Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.trending_up, size: 16, color: Colors.green),
                    const SizedBox(width: 4),
                    Text(
                      '${product.totalSoldCount} terjual',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Profit/unit: Rp${product.profitPerUnit.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(Product product) {
    if (!product.isAvailable) return Colors.red;
    if (product.stock <= 0) return Colors.orange;
    if (product.stock <= 5) return Colors.yellow.shade700;
    return Colors.green;
  }

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (context) => _ProductFormDialog(
        onSave: (product) {
          setState(() {
            products.add(product);
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Produk berhasil ditambahkan')),
          );
        },
      ),
    );
  }

  void _showEditProductDialog(Product product) {
    showDialog(
      context: context,
      builder: (context) => _ProductFormDialog(
        initialProduct: product,
        onSave: (updatedProduct) {
          setState(() {
            final index = products.indexOf(product);
            if (index >= 0) {
              products[index] = updatedProduct;
            }
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Produk berhasil diperbarui')),
          );
        },
      ),
    );
  }

  void _showProductDetail(Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(product.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Kategori', product.category),
              _buildDetailRow('Harga Jual', 'Rp${product.price.toStringAsFixed(0)}'),
              _buildDetailRow('HPP', product.hpp != null ? 'Rp${product.hpp!.toStringAsFixed(0)}' : '-'),
              _buildDetailRow('Margin', '${product.profitMargin.toStringAsFixed(1)}%'),
              _buildDetailRow('Stok', '${product.stock}'),
              _buildDetailRow('Status', product.isAvailable ? 'Aktif' : 'Nonaktif'),
              _buildDetailRow('Terjual', '${product.totalSoldCount}'),
              _buildDetailRow('Deskripsi', product.description),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  void _toggleProductStatus(Product product) {
    setState(() {
      product.isAvailable = !product.isAvailable;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Produk ${product.isAvailable ? 'diaktifkan' : 'dinonaktifkan'}',
        ),
      ),
    );
  }

  void _deleteProduct(Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Produk?'),
        content: Text('Yakin ingin menghapus ${product.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                products.remove(product);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Produk berhasil dihapus')),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  List<Product> _getFilteredProducts() {
    return products.where((product) {
      // Search filter
      if (searchText.isNotEmpty && !product.name.toLowerCase().contains(searchText)) {
        return false;
      }

      // Status filter
      switch (selectedFilter) {
        case 'Tersedia':
          return product.isAvailable && product.stock > 0;
        case 'Habis':
          return product.stock <= 0;
        case 'Tidak Aktif':
          return !product.isAvailable;
        default:
          return true;
      }
    }).toList();
  }
}

/// Product Form Dialog untuk Add/Edit
class _ProductFormDialog extends StatefulWidget {
  final Product? initialProduct;
  final Function(Product) onSave;

  const _ProductFormDialog({
    this.initialProduct,
    required this.onSave,
  });

  @override
  State<_ProductFormDialog> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends State<_ProductFormDialog> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController hppController;
  late TextEditingController stockController;
  String selectedCategory = 'Minuman';
  bool isAvailable = true;

  @override
  void initState() {
    super.initState();
    final product = widget.initialProduct;
    nameController = TextEditingController(text: product?.name ?? '');
    descriptionController = TextEditingController(text: product?.description ?? '');
    priceController = TextEditingController(text: product?.price.toString() ?? '');
    hppController = TextEditingController(text: product?.hpp?.toString() ?? '');
    stockController = TextEditingController(text: product?.stock.toString() ?? '');
    selectedCategory = product?.category ?? 'Minuman';
    isAvailable = product?.isAvailable ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialProduct == null ? 'Tambah Produk' : 'Edit Produk'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nama Produk'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField(
              value: selectedCategory,
              items: ['Minuman', 'Makanan', 'Snack', 'Dessert']
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Kategori'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Harga Jual (Rp)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: hppController,
              decoration: const InputDecoration(labelText: 'HPP (Rp) - Opsional'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: stockController,
              decoration: const InputDecoration(labelText: 'Stok'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              value: isAvailable,
              onChanged: (value) {
                setState(() {
                  isAvailable = value!;
                });
              },
              title: const Text('Aktif'),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: _save,
          child: const Text('Simpan'),
        ),
      ],
    );
  }

  void _save() {
    if (nameController.text.isEmpty || priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi nama dan harga')),
      );
      return;
    }

    final product = Product(
      id: widget.initialProduct?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameController.text,
      description: descriptionController.text,
      category: selectedCategory,
      price: double.parse(priceController.text),
      hpp: hppController.text.isNotEmpty ? double.parse(hppController.text) : null,
      stock: int.parse(stockController.text.isEmpty ? '0' : stockController.text),
      isAvailable: isAvailable,
      createdAt: widget.initialProduct?.createdAt ?? DateTime.now(),
      totalSoldCount: widget.initialProduct?.totalSoldCount ?? 0,
    );

    widget.onSave(product);
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    hppController.dispose();
    stockController.dispose();
    super.dispose();
  }
}
