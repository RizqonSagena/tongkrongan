import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/models/owner.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class OwnerSalesScreen extends StatefulWidget {
  const OwnerSalesScreen({super.key});

  @override
  State<OwnerSalesScreen> createState() => _OwnerSalesScreenState();
}

class _OwnerSalesScreenState extends State<OwnerSalesScreen> {
  late List<Transaction> transactions;
  late List<Transaction> filteredTransactions;
  String selectedFilter = 'Semua'; // Semua, Hari Ini, Minggu Ini, Bulan Ini
  String searchText = '';

  @override
  void initState() {
    super.initState();
    transactions = OwnerMockData.generateMockTransactions();
    filteredTransactions = transactions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Penjualan & Transaksi'),
        centerTitle: true,
        elevation: 0,
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

            // Summary Cards
            _buildSummaryCards(),

            const SizedBox(height: 24),

            // Transactions List
            Text(
              'Riwayat Transaksi',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildTransactionsList(),

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
          _filterTransactions();
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
                    _filterTransactions();
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
    final filters = ['Semua', 'Hari Ini', 'Minggu Ini', 'Bulan Ini'];
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
                        _filterTransactions();
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

  Widget _buildSummaryCards() {
    double totalRevenue = filteredTransactions.fold(0, (sum, tx) => sum + tx.totalPrice);
    int totalItems = filteredTransactions.fold(0, (sum, tx) => sum + tx.quantity);
    int transactionCount = filteredTransactions.length;

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            label: 'Total Penjualan',
            value: 'Rp${totalRevenue.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
            icon: Icons.trending_up,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildSummaryCard(
            label: 'Item Terjual',
            value: '$totalItems',
            icon: Icons.shopping_bag,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildSummaryCard(
            label: 'Transaksi',
            value: '$transactionCount',
            icon: Icons.receipt,
            color: Colors.orange,
          ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList() {
    if (filteredTransactions.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(Icons.receipt_long, size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                'Tidak ada transaksi',
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
      itemCount: filteredTransactions.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final tx = filteredTransactions[index];
        return _buildTransactionCard(tx, index);
      },
    );
  }

  Widget _buildTransactionCard(Transaction tx, int index) {
    return GestureDetector(
      onTap: () => _showTransactionDetail(tx),
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
                      Text(
                        tx.productName,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tx.formattedDate,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(tx.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    tx.status,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: _getStatusColor(tx.status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Details Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jumlah',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${tx.quantity} unit @ Rp${tx.unitPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tx.formattedPrice,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Payment Method & Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.payment, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      tx.paymentMethod,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      '${tx.transactionDate.hour}:${tx.transactionDate.minute.toString().padLeft(2, '0')}',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey.shade600,
                      ),
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showTransactionDetail(Transaction tx) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detail Transaksi'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _detailRow('Produk', tx.productName),
              _detailRow('Tanggal', tx.formattedDate),
              _detailRow('Waktu', '${tx.transactionDate.hour}:${tx.transactionDate.minute.toString().padLeft(2, '0')}'),
              _detailRow('Jumlah', '${tx.quantity} unit'),
              _detailRow('Harga Satuan', 'Rp${tx.unitPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}'),
              _detailRow('Total', tx.formattedPrice),
              _detailRow('Metode Pembayaran', tx.paymentMethod),
              _detailRow('Status', tx.status),
              if (tx.notes != null && tx.notes!.isNotEmpty)
                _detailRow('Catatan', tx.notes!),
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

  void _filterTransactions() {
    setState(() {
      filteredTransactions = transactions.where((tx) {
        // Filter by search text
        if (searchText.isNotEmpty && !tx.productName.toLowerCase().contains(searchText)) {
          return false;
        }

        // Filter by date
        final now = DateTime.now();
        switch (selectedFilter) {
          case 'Hari Ini':
            return tx.transactionDate.day == now.day &&
                tx.transactionDate.month == now.month &&
                tx.transactionDate.year == now.year;
          case 'Minggu Ini':
            final weekAgo = now.subtract(Duration(days: 7));
            return tx.transactionDate.isAfter(weekAgo);
          case 'Bulan Ini':
            return tx.transactionDate.month == now.month &&
                tx.transactionDate.year == now.year;
          default:
            return true;
        }
      }).toList();
    });
  }
}
