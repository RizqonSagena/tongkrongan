import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/models/owner.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class OwnerHPPExpenseScreen extends StatefulWidget {
  const OwnerHPPExpenseScreen({super.key});

  @override
  State<OwnerHPPExpenseScreen> createState() => _OwnerHPPExpenseScreenState();
}

class _OwnerHPPExpenseScreenState extends State<OwnerHPPExpenseScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Expense> expenses;
  late List<HPP> hppList;
  late List<Product> products;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    expenses = OwnerMockData.generateMockExpenses();
    hppList = [];
    products = OwnerMockData.generateMockProducts();

    // Generate sample HPP data
    if (products.isNotEmpty) {
      hppList = [
        HPP(
          id: 'HPP001',
          productId: products[0].id,
          ingredientName: 'Biji Kopi',
          costPerUnit: 50000,
          unit: 'kg',
          quantityUsedPerProduct: 0.015,
          totalCostPerProduct: 750,
          createdAt: DateTime.now(),
        ),
        HPP(
          id: 'HPP002',
          productId: products[0].id,
          ingredientName: 'Susu Cair',
          costPerUnit: 15000,
          unit: 'liter',
          quantityUsedPerProduct: 0.1,
          totalCostPerProduct: 1500,
          createdAt: DateTime.now(),
        ),
        HPP(
          id: 'HPP003',
          productId: products[1].id,
          ingredientName: 'Biji Kopi',
          costPerUnit: 50000,
          unit: 'kg',
          quantityUsedPerProduct: 0.015,
          totalCostPerProduct: 750,
          createdAt: DateTime.now(),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('HPP & Biaya'),
        centerTitle: true,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'HPP (Bahan Baku)'),
            Tab(text: 'Biaya Operasional'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildHPPTab(),
          _buildExpenseTab(),
        ],
      ),
    );
  }

  // ============================================================================
  // HPP TAB
  // ============================================================================
  Widget _buildHPPTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HPP Summary
          _buildHPPSummary(),

          const SizedBox(height: 24),

          // HPP by Product
          Text(
            'HPP per Produk',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildHPPByProduct(),

          const SizedBox(height: 24),

          // Ingredient List
          Text(
            'Daftar Bahan Baku',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildIngredientList(),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHPPSummary() {
    double totalHPP = hppList.fold(0, (sum, hpp) => sum + hpp.totalCostPerProduct);
    int ingredientCount = hppList.length;
    int productCount = products.where((p) => p.hpp != null).length;

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.2,
      children: [
        _buildSummaryCard(
          label: 'Total HPP',
          value: 'Rp${totalHPP.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
          icon: Icons.inventory_2,
          color: Colors.orange,
        ),
        _buildSummaryCard(
          label: 'Produk',
          value: '$productCount',
          icon: Icons.shopping_bag,
          color: Colors.blue,
        ),
        _buildSummaryCard(
          label: 'Bahan',
          value: '$ingredientCount',
          icon: Icons.category,
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
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
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildHPPByProduct() {
    final hppByProduct = <String, List<HPP>>{};
    for (var hpp in hppList) {
      final productName =
          products.firstWhere((p) => p.id == hpp.productId, orElse: () => Product(id: '', name: 'Unknown', description: '', category: '', price: 0, isAvailable: false, createdAt: DateTime.now())).name;
      hppByProduct.putIfAbsent(productName, () => []).add(hpp);
    }

    if (hppByProduct.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Belum ada data HPP',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: hppByProduct.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final entry = hppByProduct.entries.toList()[index];
        final totalCost = entry.value.fold<double>(0, (sum, hpp) => sum + hpp.totalCostPerProduct);

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
                  Text(
                    entry.key,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Rp${totalCost.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Column(
                children: entry.value
                    .map((hpp) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${hpp.ingredientName} (${hpp.quantityUsedPerProduct} ${hpp.unit})',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                'Rp${hpp.totalCostPerProduct.toStringAsFixed(0)}',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIngredientList() {
    if (hppList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Belum ada bahan baku',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: hppList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final hpp = hppList[index];
        return _buildIngredientCard(hpp, index);
      },
    );
  }

  Widget _buildIngredientCard(HPP hpp, int index) {
    return GestureDetector(
      onTap: () => _showHPPDetail(hpp),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hpp.ingredientName,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Rp${hpp.costPerUnit.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')} / ${hpp.unit}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${hpp.quantityUsedPerProduct} ${hpp.unit}/produk',
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hpp.formattedCost,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 4),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text('Edit'),
                      onTap: () => _showEditHPPDialog(hpp),
                    ),
                    PopupMenuItem(
                      child: const Text('Hapus'),
                      onTap: () => _deleteHPP(hpp),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showHPPDetail(HPP hpp) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detail HPP'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _detailRow('Bahan', hpp.ingredientName),
              _detailRow('Harga per Unit', 'Rp${hpp.costPerUnit.toStringAsFixed(0)}'),
              _detailRow('Unit', hpp.unit),
              _detailRow('Jumlah per Produk', '${hpp.quantityUsedPerProduct}'),
              _detailRow('Total Cost', hpp.formattedCost),
              _detailRow('Dibuat', hpp.createdAt.toString().split(' ')[0]),
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

  // ============================================================================
  // EXPENSE TAB
  // ============================================================================
  Widget _buildExpenseTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expense Summary
          _buildExpenseSummary(),

          const SizedBox(height: 24),

          // Expense by Category
          Text(
            'Biaya per Kategori',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildExpenseByCategory(),

          const SizedBox(height: 24),

          // Expense List
          Text(
            'Riwayat Biaya',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildExpenseList(),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildExpenseSummary() {
    double totalExpense = expenses.fold(0, (sum, exp) => sum + exp.amount);
    double fixedCost = expenses.where((e) => e.category == 'Fixed').fold(0, (sum, e) => sum + e.amount);
    double variableCost =
        expenses.where((e) => e.category == 'Variable').fold(0, (sum, e) => sum + e.amount);

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.2,
      children: [
        _buildSummaryCard(
          label: 'Total Biaya',
          value: 'Rp${totalExpense.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
          icon: Icons.money_off,
          color: Colors.red,
        ),
        _buildSummaryCard(
          label: 'Biaya Tetap',
          value: 'Rp${fixedCost.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
          icon: Icons.trending_flat,
          color: Colors.blue,
        ),
        _buildSummaryCard(
          label: 'Biaya Variabel',
          value: 'Rp${variableCost.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
          icon: Icons.trending_down,
          color: Colors.orange,
        ),
      ],
    );
  }

  Widget _buildExpenseByCategory() {
    final expenseByType = <String, double>{};
    for (var exp in expenses) {
      expenseByType[exp.expenseType] = (expenseByType[exp.expenseType] ?? 0) + exp.amount;
    }

    final sorted = expenseByType.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sorted.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final entry = sorted[index];
        final total = expenses.fold<double>(0, (sum, e) => sum + e.amount);
        final percentage = (entry.value / total * 100);

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
                  Text(
                    entry.key,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rp${entry.value.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: percentage / 100,
                  minHeight: 6,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${percentage.toStringAsFixed(1)}% dari total biaya',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExpenseList() {
    if (expenses.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Belum ada biaya',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: expenses.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final exp = expenses[index];
        return _buildExpenseCard(exp, index);
      },
    );
  }

  Widget _buildExpenseCard(Expense exp, int index) {
    return GestureDetector(
      onTap: () => _showExpenseDetail(exp),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exp.expenseType,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        exp.expenseDate.toString().split(' ')[0],
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: exp.category == 'Fixed'
                              ? Colors.blue.withOpacity(0.1)
                              : Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          exp.category,
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: exp.category == 'Fixed' ? Colors.blue : Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  exp.formattedAmount,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 4),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text('Edit'),
                      onTap: () => _showEditExpenseDialog(exp),
                    ),
                    PopupMenuItem(
                      child: const Text('Hapus'),
                      onTap: () => _deleteExpense(exp),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showExpenseDetail(Expense exp) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detail Biaya'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _detailRow('Jenis Biaya', exp.expenseType),
              _detailRow('Jumlah', exp.formattedAmount),
              _detailRow('Tanggal', exp.expenseDate.toString().split(' ')[0]),
              _detailRow('Kategori', exp.category),
              _detailRow('Status', exp.status),
              if (exp.description != null) _detailRow('Deskripsi', exp.description!),
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

  Widget _detailRow(String label, String value) {
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

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Data'),
        content: const Text('Pilih jenis data yang ingin ditambahkan:'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showAddHPPDialog();
            },
            child: const Text('Tambah HPP'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showAddExpenseDialog();
            },
            child: const Text('Tambah Biaya'),
          ),
        ],
      ),
    );
  }

  void _showAddHPPDialog() {
    showDialog(
      context: context,
      builder: (context) => _HPPFormDialog(
        onSave: (hpp) {
          setState(() {
            hppList.add(hpp);
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('HPP berhasil ditambahkan')),
          );
        },
        products: products,
      ),
    );
  }

  void _showEditHPPDialog(HPP hpp) {
    showDialog(
      context: context,
      builder: (context) => _HPPFormDialog(
        initialHPP: hpp,
        onSave: (updated) {
          setState(() {
            final index = hppList.indexOf(hpp);
            if (index >= 0) {
              hppList[index] = updated;
            }
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('HPP berhasil diperbarui')),
          );
        },
        products: products,
      ),
    );
  }

  void _deleteHPP(HPP hpp) {
    setState(() {
      hppList.remove(hpp);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('HPP berhasil dihapus')),
    );
  }

  void _showAddExpenseDialog() {
    showDialog(
      context: context,
      builder: (context) => _ExpenseFormDialog(
        onSave: (expense) {
          setState(() {
            expenses.add(expense);
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Biaya berhasil ditambahkan')),
          );
        },
      ),
    );
  }

  void _showEditExpenseDialog(Expense exp) {
    showDialog(
      context: context,
      builder: (context) => _ExpenseFormDialog(
        initialExpense: exp,
        onSave: (updated) {
          setState(() {
            final index = expenses.indexOf(exp);
            if (index >= 0) {
              expenses[index] = updated;
            }
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Biaya berhasil diperbarui')),
          );
        },
      ),
    );
  }

  void _deleteExpense(Expense exp) {
    setState(() {
      expenses.remove(exp);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Biaya berhasil dihapus')),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

/// HPP Form Dialog
class _HPPFormDialog extends StatefulWidget {
  final HPP? initialHPP;
  final Function(HPP) onSave;
  final List<Product> products;

  const _HPPFormDialog({
    this.initialHPP,
    required this.onSave,
    required this.products,
  });

  @override
  State<_HPPFormDialog> createState() => _HPPFormDialogState();
}

class _HPPFormDialogState extends State<_HPPFormDialog> {
  late TextEditingController ingredientController;
  late TextEditingController costPerUnitController;
  late TextEditingController quantityController;
  String selectedUnit = 'kg';
  String selectedProduct = '';

  @override
  void initState() {
    super.initState();
    ingredientController =
        TextEditingController(text: widget.initialHPP?.ingredientName ?? '');
    costPerUnitController =
        TextEditingController(text: widget.initialHPP?.costPerUnit.toString() ?? '');
    quantityController = TextEditingController(
        text: widget.initialHPP?.quantityUsedPerProduct.toString() ?? '');
    selectedUnit = widget.initialHPP?.unit ?? 'kg';
    selectedProduct =
        widget.initialHPP?.productId ?? (widget.products.isNotEmpty ? widget.products[0].id : '');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialHPP == null ? 'Tambah HPP' : 'Edit HPP'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField(
              value: selectedProduct.isNotEmpty ? selectedProduct : null,
              items: widget.products
                  .map((p) => DropdownMenuItem(value: p.id, child: Text(p.name)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedProduct = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Produk'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: ingredientController,
              decoration: const InputDecoration(labelText: 'Nama Bahan'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: costPerUnitController,
              decoration: const InputDecoration(labelText: 'Harga per Unit (Rp)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: quantityController,
                    decoration:
                        const InputDecoration(labelText: 'Jumlah per Produk'),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton(
                  value: selectedUnit,
                  items: ['kg', 'g', 'liter', 'ml', 'pieces']
                      .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedUnit = value!;
                    });
                  },
                ),
              ],
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
    if (ingredientController.text.isEmpty ||
        costPerUnitController.text.isEmpty ||
        quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi semua field')),
      );
      return;
    }

    final costPerUnit = double.parse(costPerUnitController.text);
    final quantity = double.parse(quantityController.text);
    final totalCost = costPerUnit * quantity;

    final hpp = HPP(
      id: widget.initialHPP?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      productId: selectedProduct,
      ingredientName: ingredientController.text,
      costPerUnit: costPerUnit,
      unit: selectedUnit,
      quantityUsedPerProduct: quantity,
      totalCostPerProduct: totalCost,
      createdAt: widget.initialHPP?.createdAt ?? DateTime.now(),
    );

    widget.onSave(hpp);
  }

  @override
  void dispose() {
    ingredientController.dispose();
    costPerUnitController.dispose();
    quantityController.dispose();
    super.dispose();
  }
}

/// Expense Form Dialog
class _ExpenseFormDialog extends StatefulWidget {
  final Expense? initialExpense;
  final Function(Expense) onSave;

  const _ExpenseFormDialog({
    this.initialExpense,
    required this.onSave,
  });

  @override
  State<_ExpenseFormDialog> createState() => _ExpenseFormDialogState();
}

class _ExpenseFormDialogState extends State<_ExpenseFormDialog> {
  late TextEditingController amountController;
  late TextEditingController descriptionController;
  String selectedType = 'Lainnya';
  String selectedCategory = 'Variable';

  @override
  void initState() {
    super.initState();
    amountController =
        TextEditingController(text: widget.initialExpense?.amount.toString() ?? '');
    descriptionController =
        TextEditingController(text: widget.initialExpense?.description ?? '');
    selectedType = widget.initialExpense?.expenseType ?? 'Lainnya';
    selectedCategory = widget.initialExpense?.category ?? 'Variable';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialExpense == null ? 'Tambah Biaya' : 'Edit Biaya'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField(
              value: selectedType,
              items: ['Gaji', 'Listrik', 'Sewa Tempat', 'Marketing', 'Transportasi', 'Lainnya']
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedType = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Jenis Biaya'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Jumlah (Rp)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField(
              value: selectedCategory,
              items: ['Fixed', 'Variable', 'Semi-variable']
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
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
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Deskripsi (Opsional)'),
              maxLines: 2,
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
    if (amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi jumlah')),
      );
      return;
    }

    final expense = Expense(
      id: widget.initialExpense?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      expenseType: selectedType,
      amount: double.parse(amountController.text),
      expenseDate: DateTime.now(),
      description: descriptionController.text.isNotEmpty ? descriptionController.text : null,
      category: selectedCategory,
      createdAt: widget.initialExpense?.createdAt ?? DateTime.now(),
      status: 'completed',
    );

    widget.onSave(expense);
  }

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
