import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/owner/bottom_navigation.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String _selectedFilter = 'Hari Ini';
  final List<String> _filters = ['Hari Ini', 'Mingguan', 'Bulanan', 'Custom'];
  final TextEditingController _searchController = TextEditingController();

  // Mock transaction data
  final List<TransactionItem> _transactions = [
    TransactionItem(
      date: DateTime.now(),
      product: 'Es Kopi Susu',
      quantity: 2,
      price: 15000,
      total: 30000,
      category: 'Minuman',
    ),
    TransactionItem(
      date: DateTime.now().subtract(const Duration(hours: 1)),
      product: 'Nasi Goreng Kampung',
      quantity: 1,
      price: 18000,
      total: 18000,
      category: 'Makanan',
    ),
    TransactionItem(
      date: DateTime.now().subtract(const Duration(hours: 2)),
      product: 'Roti Bakar',
      quantity: 3,
      price: 12000,
      total: 36000,
      category: 'Makanan',
    ),
    TransactionItem(
      date: DateTime.now().subtract(const Duration(hours: 3)),
      product: 'Teh Manis',
      quantity: 4,
      price: 8000,
      total: 32000,
      category: 'Minuman',
    ),
    TransactionItem(
      date: DateTime.now().subtract(const Duration(hours: 4)),
      product: 'Gado-Gado',
      quantity: 2,
      price: 15000,
      total: 30000,
      category: 'Makanan',
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
          'Transaksi',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: AppTheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Summary Cards
          _buildSummaryCards(),
          
          // Filter Section
          _buildFilterSection(),
          
          // Search Bar
          _buildSearchBar(),
          
          // Transaction List
          Expanded(
            child: _buildTransactionList(),
          ),
        ],
      ),
      bottomNavigationBar: const OwnerBottomNavigation(currentIndex: 1),
    );
  }

  Widget _buildSummaryCards() {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Container(
      padding: const EdgeInsets.all(AppTheme.marginMobile),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Total Transaksi',
                  '87',
                  Icons.receipt_long,
                  AppTheme.primary,
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: _buildSummaryCard(
                  'Total Customer',
                  '76',
                  Icons.people,
                  AppTheme.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Total Gelas',
                  '143',
                  Icons.local_cafe,
                  AppTheme.tertiary,
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: _buildSummaryCard(
                  'Total Porsi',
                  '89',
                  Icons.restaurant,
                  AppTheme.primary,
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
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.onSurface.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: AppTheme.spaceXs),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppTheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.marginMobile),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _filters.map((filter) {
            final isSelected = filter == _selectedFilter;
            return Container(
              margin: const EdgeInsets.only(right: AppTheme.spaceXs),
              child: FilterChip(
                label: Text(filter),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedFilter = filter;
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

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(AppTheme.marginMobile),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.outline.withOpacity(0.3)),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Cari transaksi...',
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

  Widget _buildTransactionList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.marginMobile),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Riwayat Transaksi',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppTheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Expanded(
            child: ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                return _buildTransactionItem(_transactions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(TransactionItem transaction) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    
    final timeFormat = DateFormat('HH:mm');

    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spaceMd),
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.outline.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          // Product Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.primaryFixed.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              transaction.category == 'Minuman' ? Icons.local_cafe : Icons.restaurant,
              color: AppTheme.primary,
              size: 24,
            ),
          ),
          
          const SizedBox(width: AppTheme.spaceMd),
          
          // Transaction Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.product,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppTheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${transaction.quantity}x ${currencyFormat.format(transaction.price)}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  timeFormat.format(transaction.date),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          
          // Total
          Text(
            currencyFormat.format(transaction.total),
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: AppTheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionItem {
  final DateTime date;
  final String product;
  final int quantity;
  final int price;
  final int total;
  final String category;

  TransactionItem({
    required this.date,
    required this.product,
    required this.quantity,
    required this.price,
    required this.total,
    required this.category,
  });
}