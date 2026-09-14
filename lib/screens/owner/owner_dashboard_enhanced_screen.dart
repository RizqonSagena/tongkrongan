import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/models/owner.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class OwnerDashboardEnhancedScreen extends StatefulWidget {
  const OwnerDashboardEnhancedScreen({super.key});

  @override
  State<OwnerDashboardEnhancedScreen> createState() => _OwnerDashboardEnhancedScreenState();
}

class _OwnerDashboardEnhancedScreenState extends State<OwnerDashboardEnhancedScreen> {
  late BusinessStats stats;
  late List<OrderQueue> orderQueue;
  String selectedPeriod = 'Bulan Ini'; // Bulan Ini, Minggu Ini, Hari Ini

  @override
  void initState() {
    super.initState();
    // Load mock data
    stats = OwnerMockData.generateMockBusinessStats();
    orderQueue = OwnerMockData.generateMockOrderQueue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Dashboard Bisnis'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Refresh data...')),
                );
              },
              icon: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            _buildPeriodSelector(),

            const SizedBox(height: 24),

            // KPI Cards - Main Metrics
            Text(
              'Ringkasan Bisnis',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildKPIGrid(),

            const SizedBox(height: 28),

            // Financial Breakdown
            Text(
              'Rincian Keuangan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildFinancialCards(),

            const SizedBox(height: 28),

            // Top Products
            Text(
              'Produk Terlaris',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildTopProducts(),

            const SizedBox(height: 28),

            // Order Queue Summary
            Text(
              'Antrian Pesanan (${orderQueue.where((o) => o.status != 'completed').length} Aktif)',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildOrderQueueSummary(),

            const SizedBox(height: 28),

            // Action Buttons
            _buildActionButtons(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    final periods = ['Hari Ini', 'Minggu Ini', 'Bulan Ini'];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButton<String>(
        value: selectedPeriod,
        isExpanded: false,
        underline: SizedBox(),
        onChanged: (value) {
          setState(() {
            selectedPeriod = value!;
          });
        },
        items: periods
            .map((period) => DropdownMenuItem(
                  value: period,
                  child: Text(period),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildKPIGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.1,
      children: [
        _buildKPICard(
          title: 'Omzet',
          value: stats.formattedRevenue,
          subtitle: '${stats.totalItemsSold} item terjual',
          icon: Icons.trending_up,
          color: Colors.blue,
          onTap: () => context.push('/owner-sales'),
        ),
        _buildKPICard(
          title: 'Keuntungan',
          value: stats.formattedProfit,
          subtitle: '${stats.profitMargin.toStringAsFixed(1)}% margin',
          icon: Icons.attach_money,
          color: stats.netProfit >= 0 ? Colors.green : Colors.red,
          onTap: () => context.push('/owner-financial'),
        ),
        _buildKPICard(
          title: 'Biaya',
          value: stats.formattedExpenses,
          subtitle: '${(stats.totalCost / stats.totalRevenue * 100).toStringAsFixed(1)}% dari omzet',
          icon: Icons.shopping_cart,
          color: Colors.orange,
          onTap: () => context.push('/owner-expenses'),
        ),
        _buildKPICard(
          title: 'Transaksi',
          value: '${stats.totalTransactionCount}',
          subtitle: 'Rata-rata Rp${(stats.averageTransactionValue).toStringAsFixed(0)}',
          icon: Icons.receipt,
          color: Colors.purple,
          onTap: () => context.push('/owner-transactions'),
        ),
      ],
    );
  }

  Widget _buildKPICard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                Icon(Icons.chevron_right, color: Colors.grey.shade400),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.grey.shade500,
                fontSize: 11,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialCards() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFinancialRow('Pendapatan Kotor (Omzet)', stats.formattedRevenue, Colors.blue),
          Divider(color: Colors.grey.shade200, height: 16),
          _buildFinancialRow('HPP (Harga Pokok)', '-Rp${stats.totalHPP.toStringAsFixed(0)}', Colors.orange),
          Divider(color: Colors.grey.shade200, height: 16),
          _buildFinancialRow('Laba Kotor (Gross Profit)', 'Rp${stats.grossProfit.toStringAsFixed(0)}', Colors.green),
          Divider(color: Colors.grey.shade200, height: 16),
          _buildFinancialRow('Biaya Operasional', '-Rp${stats.totalExpenses.toStringAsFixed(0)}', Colors.red),
          Divider(color: Colors.grey.shade200, height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (stats.netProfit >= 0 ? Colors.green : Colors.red).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Laba Bersih (Net Profit)',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  stats.formattedProfit,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: stats.netProfit >= 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildTopProducts() {
    final topProducts = stats.topProducts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: topProducts.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey.shade200,
          height: 1,
          indent: 16,
          endIndent: 16,
        ),
        itemBuilder: (context, index) {
          final product = topProducts[index];
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.key,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${product.value} terjual',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.trending_up, color: Colors.green, size: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderQueueSummary() {
    final pending = orderQueue.where((o) => o.status == 'pending').length;
    final preparing = orderQueue.where((o) => o.status == 'preparing').length;
    final ready = orderQueue.where((o) => o.status == 'ready').length;

    return Row(
      children: [
        Expanded(
          child: _buildOrderStatusCard(
            status: 'Menunggu',
            count: pending,
            color: Colors.orange,
            icon: Icons.schedule,
            onTap: () => context.push('/owner-order-queue'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildOrderStatusCard(
            status: 'Sedang Diproses',
            count: preparing,
            color: Colors.blue,
            icon: Icons.local_shipping,
            onTap: () => context.push('/owner-order-queue'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildOrderStatusCard(
            status: 'Siap Ambil',
            count: ready,
            color: Colors.green,
            icon: Icons.check_circle,
            onTap: () => context.push('/owner-order-queue'),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderStatusCard({
    required String status,
    required int count,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              '$count',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              status,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: color,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Text(
          'Navigasi Cepat',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.3,
          children: [
            _buildActionButton(
              icon: Icons.shopping_bag,
              label: 'Kelola Produk',
              color: Colors.blue,
              onTap: () => context.push('/owner-products'),
            ),
            _buildActionButton(
              icon: Icons.receipt_long,
              label: 'Riwayat Transaksi',
              color: Colors.green,
              onTap: () => context.push('/owner-transactions'),
            ),
            _buildActionButton(
              icon: Icons.analytics,
              label: 'Analisis Bisnis',
              color: Colors.purple,
              onTap: () => context.push('/owner-analytics'),
            ),
            _buildActionButton(
              icon: Icons.category,
              label: 'Kelola HPP & Biaya',
              color: Colors.orange,
              onTap: () => context.push('/owner-hpp'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
