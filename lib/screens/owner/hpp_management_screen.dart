import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tongkrongan_umkm_owner_app/models/hpp.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/owner/bottom_navigation.dart';

class HPPManagementScreen extends StatefulWidget {
  const HPPManagementScreen({super.key});

  @override
  State<HPPManagementScreen> createState() => _HPPManagementScreenState();
}

class _HPPManagementScreenState extends State<HPPManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _sortBy = 'productName'; // productName, hpp, profitMargin
  bool _isDescending = false;

  // Mock HPP data
  final List<HPP> _hppList = [
    HPP(
      id: '1',
      productId: 'prod-1',
      productName: 'Es Kopi Susu',
      hpp: 5000,
      sellingPrice: 15000,
      lastUpdated: DateTime.now(),
      notes: 'Bahan berkualitas premium',
    ),
    HPP(
      id: '2',
      productId: 'prod-2',
      productName: 'Nasi Goreng Kampung',
      hpp: 8000,
      sellingPrice: 18000,
      lastUpdated: DateTime.now().subtract(const Duration(days: 3)),
      notes: 'Menggunakan beras pilihan',
    ),
    HPP(
      id: '3',
      productId: 'prod-3',
      productName: 'Roti Bakar',
      hpp: 4000,
      sellingPrice: 12000,
      lastUpdated: DateTime.now().subtract(const Duration(days: 7)),
    ),
    HPP(
      id: '4',
      productId: 'prod-4',
      productName: 'Teh Manis',
      hpp: 2000,
      sellingPrice: 8000,
      lastUpdated: DateTime.now().subtract(const Duration(days: 1)),
    ),
    HPP(
      id: '5',
      productId: 'prod-5',
      productName: 'Pisang Goreng',
      hpp: 3000,
      sellingPrice: 10000,
      lastUpdated: DateTime.now().subtract(const Duration(days: 5)),
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
          'Kelola HPP',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: AppTheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: _showAddHPPDialog,
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
          // Summary Cards
          _buildSummaryCards(),
          
          // Search & Filter
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari produk...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 12),
                // Sort & Filter Options
                Row(
                  children: [
                    Expanded(
                      child: _buildFilterChip('Nama Produk', 'productName'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildFilterChip('HPP', 'hpp'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildFilterChip('Margin', 'profitMargin'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // HPP List
          Expanded(
            child: _hppList.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    itemCount: _hppList.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final hpp = _hppList[index];
                      return _buildHPPCard(hpp, index);
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const OwnerBottomNavigation(currentRoute: '/hpp'),
    );
  }

  Widget _buildSummaryCards() {
    double totalHPP = 0;
    double totalRevenue = 0;
    int lowMarginProducts = 0;

    for (var hpp in _hppList) {
      totalHPP += hpp.hpp;
      totalRevenue += hpp.sellingPrice;
      if (hpp.profitMargin < 30) lowMarginProducts++;
    }

    double avgMargin = _hppList.isNotEmpty
        ? _hppList.fold<double>(0, (sum, hpp) => sum + hpp.profitMargin) / _hppList.length
        : 0;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Summary Row 1
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  title: 'Total HPP',
                  value: NumberFormat.currency(
                    locale: 'id_ID',
                    symbol: 'Rp',
                    decimalDigits: 0,
                  ).format(totalHPP),
                  icon: Icons.shopping_bag,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  title: 'Total Harga',
                  value: NumberFormat.currency(
                    locale: 'id_ID',
                    symbol: 'Rp',
                    decimalDigits: 0,
                  ).format(totalRevenue),
                  icon: Icons.price_change,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Summary Row 2
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  title: 'Rata-rata Margin',
                  value: '${avgMargin.toStringAsFixed(1)}%',
                  icon: Icons.trending_up,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  title: 'Margin Rendah',
                  value: '$lowMarginProducts Produk',
                  icon: Icons.warning,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String sortValue) {
    final isSelected = _sortBy == sortValue;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (_sortBy == sortValue) {
            _isDescending = !_isDescending;
          } else {
            _sortBy = sortValue;
            _isDescending = false;
          }
        });
      },
      backgroundColor: Colors.white,
      selectedColor: AppTheme.primary.withOpacity(0.2),
      side: BorderSide(
        color: isSelected ? AppTheme.primary : Colors.grey.shade300,
      ),
    );
  }

  Widget _buildHPPCard(HPP hpp, int index) {
    final isLowMargin = hpp.profitMargin < 30;
    final isCriticalMargin = hpp.profitMargin < 20;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isCriticalMargin
              ? Colors.red.shade300
              : isLowMargin
                  ? Colors.orange.shade300
                  : Colors.grey.shade200,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.shopping_bag,
            color: AppTheme.primary,
          ),
        ),
        title: Text(
          hpp.productName,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'HPP: ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0).format(hpp.hpp)} → Harga: ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0).format(hpp.sellingPrice)}',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Margin: ${hpp.profitMargin.toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: isCriticalMargin
                        ? Colors.red
                        : isLowMargin
                            ? Colors.orange
                            : Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Keuntungan: ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0).format(hpp.profitPerUnit)}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'edit') {
              _showEditHPPDialog(hpp);
            } else if (value == 'delete') {
              _showDeleteConfirmation(hpp);
            } else if (value == 'history') {
              _showHPPHistory(hpp);
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 18),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'history',
              child: Row(
                children: [
                  Icon(Icons.history, size: 18),
                  SizedBox(width: 8),
                  Text('Riwayat'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, size: 18, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Hapus', style: TextStyle(color: Colors.red)),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada data HPP',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tambahkan HPP produk Anda untuk mulai mengelola harga',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _showAddHPPDialog,
            icon: const Icon(Icons.add),
            label: const Text('Tambah HPP'),
          ),
        ],
      ),
    );
  }

  void _showAddHPPDialog() {
    final productNameController = TextEditingController();
    final hppController = TextEditingController();
    final priceController = TextEditingController();
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambah HPP Baru'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: productNameController,
                  decoration: InputDecoration(
                    labelText: 'Nama Produk',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.shopping_bag),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: hppController,
                  decoration: InputDecoration(
                    labelText: 'HPP (Rp)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.money),
                    hintText: '0',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Harga Jual (Rp)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.price_change),
                    hintText: '0',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: notesController,
                  decoration: InputDecoration(
                    labelText: 'Catatan (Opsional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.note),
                    hintText: 'Contoh: Bahan berkualitas premium',
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (productNameController.text.isEmpty ||
                    hppController.text.isEmpty ||
                    priceController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Harap isi semua field yang wajib'),
                    ),
                  );
                  return;
                }

                // Add HPP logic here
                setState(() {
                  _hppList.add(
                    HPP(
                      id: DateTime.now().toString(),
                      productId: 'prod-${_hppList.length + 1}',
                      productName: productNameController.text,
                      hpp: double.parse(hppController.text),
                      sellingPrice: double.parse(priceController.text),
                      lastUpdated: DateTime.now(),
                      notes: notesController.text.isEmpty ? null : notesController.text,
                    ),
                  );
                });

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('HPP berhasil ditambahkan'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _showEditHPPDialog(HPP hpp) {
    final productNameController = TextEditingController(text: hpp.productName);
    final hppController = TextEditingController(text: hpp.hpp.toString());
    final priceController = TextEditingController(text: hpp.sellingPrice.toString());
    final notesController = TextEditingController(text: hpp.notes ?? '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit HPP'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: productNameController,
                  decoration: InputDecoration(
                    labelText: 'Nama Produk',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.shopping_bag),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: hppController,
                  decoration: InputDecoration(
                    labelText: 'HPP (Rp)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.money),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Harga Jual (Rp)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.price_change),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: notesController,
                  decoration: InputDecoration(
                    labelText: 'Catatan (Opsional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.note),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (productNameController.text.isEmpty ||
                    hppController.text.isEmpty ||
                    priceController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Harap isi semua field yang wajib'),
                    ),
                  );
                  return;
                }

                // Update HPP logic here
                final index = _hppList.indexOf(hpp);
                setState(() {
                  _hppList[index] = hpp.copyWith(
                    productName: productNameController.text,
                    hpp: double.parse(hppController.text),
                    sellingPrice: double.parse(priceController.text),
                    notes: notesController.text.isEmpty ? null : notesController.text,
                    lastUpdated: DateTime.now(),
                  );
                });

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('HPP berhasil diperbarui'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Perbarui'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(HPP hpp) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus HPP'),
          content: Text('Apakah Anda yakin ingin menghapus HPP ${hpp.productName}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _hppList.remove(hpp);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('HPP berhasil dihapus'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _showHPPHistory(HPP hpp) {
    final mockHistory = [
      HPPHistory(
        id: '1',
        hppId: hpp.id,
        previousHPP: hpp.hpp * 0.9,
        newHPP: hpp.hpp,
        previousPrice: hpp.sellingPrice * 0.95,
        newPrice: hpp.sellingPrice,
        changedAt: DateTime.now().subtract(const Duration(days: 3)),
        reason: 'Kenaikan harga bahan baku',
      ),
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Riwayat HPP - ${hpp.productName}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: mockHistory
                  .map(
                    (history) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('dd MMM yyyy HH:mm', 'id_ID').format(history.changedAt),
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'HPP: ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0).format(history.previousHPP)} → ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0).format(history.newHPP)}',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Harga: ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0).format(history.previousPrice)} → ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0).format(history.newPrice)}',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Alasan: ${history.reason}',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.grey.shade600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}
