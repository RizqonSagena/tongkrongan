import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/owner/bottom_navigation.dart';
import 'package:intl/intl.dart';

class InvestmentExpensesScreen extends StatefulWidget {
  const InvestmentExpensesScreen({super.key});

  @override
  State<InvestmentExpensesScreen> createState() => _InvestmentExpensesScreenState();
}

class _InvestmentExpensesScreenState extends State<InvestmentExpensesScreen> {
  String _selectedCategory = 'Semua';
  final List<String> _categories = [
    'Semua',
    'Sewa tempat',
    'Pembelian alat',
    'Renovasi',
    'Peralatan dapur',
    'Bahan operasional',
    'Listrik',
    'Air',
    'Transportasi',
    'Lainnya'
  ];

  // Mock expense data
  final List<ExpenseItem> _expenses = [
    ExpenseItem(
      category: 'Sewa tempat',
      description: 'Sewa kios bulan Mei 2024',
      amount: 2500000,
      date: DateTime.now().subtract(const Duration(days: 1)),
      type: ExpenseType.operasional,
    ),
    ExpenseItem(
      category: 'Bahan operasional',
      description: 'Beli kopi, gula, susu',
      amount: 450000,
      date: DateTime.now().subtract(const Duration(days: 2)),
      type: ExpenseType.operasional,
    ),
    ExpenseItem(
      category: 'Pembelian alat',
      description: 'Mesin kopi espresso',
      amount: 15000000,
      date: DateTime.now().subtract(const Duration(days: 10)),
      type: ExpenseType.investasi,
    ),
    ExpenseItem(
      category: 'Listrik',
      description: 'Tagihan listrik bulan April',
      amount: 380000,
      date: DateTime.now().subtract(const Duration(days: 15)),
      type: ExpenseType.operasional,
    ),
    ExpenseItem(
      category: 'Peralatan dapur',
      description: 'Panci, wajan, spatula',
      amount: 750000,
      date: DateTime.now().subtract(const Duration(days: 20)),
      type: ExpenseType.investasi,
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
          'Investasi & Pengeluaran',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: AppTheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: _showAddExpenseDialog,
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
          
          // Category Filter
          _buildCategoryFilter(),
          
          // Expense List
          Expanded(
            child: _buildExpenseList(),
          ),
        ],
      ),
      bottomNavigationBar: const OwnerBottomNavigation(currentIndex: 3),
    );
  }

  Widget _buildSummaryCards() {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    final totalInvestasi = _expenses
        .where((e) => e.type == ExpenseType.investasi)
        .fold(0, (sum, e) => sum + e.amount);
    
    final totalOperasional = _expenses
        .where((e) => e.type == ExpenseType.operasional)
        .fold(0, (sum, e) => sum + e.amount);
    
    final totalPengeluaran = totalInvestasi + totalOperasional;

    return Container(
      padding: const EdgeInsets.all(AppTheme.marginMobile),
      child: Column(
        children: [
          _buildSummaryCard(
            'Total Pengeluaran',
            currencyFormat.format(totalPengeluaran),
            Icons.trending_down,
            AppTheme.primary,
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Total Investasi',
                  currencyFormat.format(totalInvestasi),
                  Icons.account_balance,
                  AppTheme.secondary,
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: _buildSummaryCard(
                  'Biaya Operasional',
                  currencyFormat.format(totalOperasional),
                  Icons.receipt_long,
                  AppTheme.tertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.onSurface.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: AppTheme.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: AppTheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.marginMobile),
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
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
        },
      ),
    );
  }

  Widget _buildExpenseList() {
    final filteredExpenses = _selectedCategory == 'Semua'
        ? _expenses
        : _expenses.where((e) => e.category == _selectedCategory).toList();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.marginMobile),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppTheme.spaceMd),
          Text(
            'Riwayat Pengeluaran',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppTheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Expanded(
            child: ListView.builder(
              itemCount: filteredExpenses.length,
              itemBuilder: (context, index) {
                return _buildExpenseItem(filteredExpenses[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseItem(ExpenseItem expense) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    
    final dateFormat = DateFormat('dd MMM yyyy');
    final isInvestment = expense.type == ExpenseType.investasi;

    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spaceMd),
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isInvestment 
            ? AppTheme.secondary.withValues(alpha: 0.3)
            : AppTheme.tertiary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          // Category Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isInvestment
                ? AppTheme.secondaryContainer.withValues(alpha: 0.3)
                : AppTheme.tertiaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getCategoryIcon(expense.category),
              color: isInvestment ? AppTheme.secondary : AppTheme.tertiary,
              size: 24,
            ),
          ),
          
          const SizedBox(width: AppTheme.spaceMd),
          
          // Expense Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      expense.category,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppTheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spaceXs),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isInvestment 
                          ? AppTheme.secondaryContainer.withValues(alpha: 0.5)
                          : AppTheme.tertiaryContainer.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        isInvestment ? 'INVESTASI' : 'OPERASIONAL',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: isInvestment ? AppTheme.secondary : AppTheme.tertiary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  expense.description,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  dateFormat.format(expense.date),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          
          // Amount
          Text(
            currencyFormat.format(expense.amount),
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: AppTheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Sewa tempat':
        return Icons.home;
      case 'Pembelian alat':
        return Icons.build;
      case 'Renovasi':
        return Icons.construction;
      case 'Peralatan dapur':
        return Icons.kitchen;
      case 'Bahan operasional':
        return Icons.inventory;
      case 'Listrik':
        return Icons.electrical_services;
      case 'Air':
        return Icons.water_drop;
      case 'Transportasi':
        return Icons.local_shipping;
      default:
        return Icons.receipt_long;
    }
  }

  void _showAddExpenseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Pengeluaran'),
        content: const Text('Form tambah pengeluaran akan ditampilkan di sini.'),
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
}

class ExpenseItem {
  final String category;
  final String description;
  final int amount;
  final DateTime date;
  final ExpenseType type;

  ExpenseItem({
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
  });
}

enum ExpenseType {
  investasi,
  operasional,
}