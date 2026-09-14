import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/models/owner.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class OwnerAnalyticsScreen extends StatefulWidget {
  const OwnerAnalyticsScreen({super.key});

  @override
  State<OwnerAnalyticsScreen> createState() => _OwnerAnalyticsScreenState();
}

class _OwnerAnalyticsScreenState extends State<OwnerAnalyticsScreen> {
  late BusinessStats stats;
  late List<Transaction> transactions;
  late List<Expense> expenses;
  String selectedPeriod = 'Bulan Ini';

  @override
  void initState() {
    super.initState();
    stats = OwnerMockData.generateMockBusinessStats();
    transactions = OwnerMockData.generateMockTransactions();
    expenses = OwnerMockData.generateMockExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Analisis Bisnis'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            _buildPeriodSelector(),

            const SizedBox(height: 24),

            // Key Metrics
            Text(
              'Metrik Utama',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildKeyMetrics(),

            const SizedBox(height: 28),

            // Sales Trends
            Text(
              'Tren Penjualan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildSalesTrend(),

            const SizedBox(height: 28),

            // Product Performance
            Text(
              'Performa Produk',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildProductPerformance(),

            const SizedBox(height: 28),

            // Daily Sales Distribution
            Text(
              'Distribusi Penjualan Harian',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildDailySalesDistribution(),

            const SizedBox(height: 28),

            // Cost Analysis
            Text(
              'Analisis Biaya',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildCostAnalysis(),

            const SizedBox(height: 28),

            // Business Health Score
            Text(
              'Skor Kesehatan Bisnis',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildBusinessHealthScore(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    final periods = ['Hari Ini', 'Minggu Ini', 'Bulan Ini', 'Tahun Ini'];
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

  Widget _buildKeyMetrics() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: [
        _buildMetricCard(
          label: 'Pertumbuhan Omzet',
          value: '${stats.revenueTrend > 0 ? '+' : ''}${stats.revenueTrend.toStringAsFixed(1)}%',
          icon: Icons.trending_up,
          color: stats.revenueTrend >= 0 ? Colors.green : Colors.red,
          isGood: stats.revenueTrend >= 0,
        ),
        _buildMetricCard(
          label: 'Pertumbuhan Biaya',
          value: '${stats.expenseTrend > 0 ? '+' : ''}${stats.expenseTrend.toStringAsFixed(1)}%',
          icon: Icons.trending_down,
          color: stats.expenseTrend <= 0 ? Colors.green : Colors.red,
          isGood: stats.expenseTrend <= 0,
        ),
        _buildMetricCard(
          label: 'Avg. Transaksi',
          value: 'Rp${(stats.averageTransactionValue).toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
          icon: Icons.receipt,
          color: Colors.blue,
        ),
        _buildMetricCard(
          label: 'Profit Margin',
          value: '${stats.profitMargin.toStringAsFixed(1)}%',
          icon: Icons.attach_money,
          color: stats.profitMargin >= 0 ? Colors.green : Colors.red,
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
    bool isGood = true,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 4),
              if (!isGood) Icon(Icons.warning, color: Colors.red, size: 16),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
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

  Widget _buildSalesTrend() {
    final entries = stats.dailyRevenue.entries.toList();
    if (entries.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Tidak ada data penjualan',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ),
      );
    }

    final maxValue = entries.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: entries
            .map((entry) {
              final percentage = (entry.value / maxValue * 100);
              final date = entry.key.split('-').last;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          date,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'Rp${entry.value.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: percentage / 100,
                        minHeight: 8,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                  ],
                ),
              );
            })
            .toList(),
      ),
    );
  }

  Widget _buildProductPerformance() {
    final sorted = stats.topProducts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: sorted.length,
        separatorBuilder: (context, index) =>
            Divider(color: Colors.grey.shade200, height: 16),
        itemBuilder: (context, index) {
          final product = sorted[index];
          final percentage = (product.value / sorted.first.value * 100);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${index + 1}',
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        product.key,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${product.value} unit',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
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
                  valueColor: AlwaysStoppedAnimation<Color>(
                    index == 0 ? Colors.green : (index == 1 ? Colors.blue : Colors.orange),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${percentage.toStringAsFixed(0)}% dari penjualan',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDailySalesDistribution() {
    final entries = stats.dailyRevenue.entries.toList();
    final maxValue = entries.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final entry = entries[index];
          final percentage = (entry.value / maxValue * 100);
          final date = entry.key.split('-').last;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Tooltip(
              message: 'Rp${entry.value.toStringAsFixed(0)}',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Rp${(entry.value / 1000).toStringAsFixed(0)}K',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 30,
                    height: 120 * (percentage / 100),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCostAnalysis() {
    final totalRevenue = stats.totalRevenue;
    final hppPercentage = (stats.totalHPP / totalRevenue * 100);
    final expensePercentage = (stats.totalExpenses / totalRevenue * 100);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildCostRow(
            label: 'HPP',
            percentage: hppPercentage,
            amount: stats.totalHPP,
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade200),
          const SizedBox(height: 12),
          _buildCostRow(
            label: 'Biaya Operasional',
            percentage: expensePercentage,
            amount: stats.totalExpenses,
            color: Colors.red,
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade200),
          const SizedBox(height: 12),
          _buildCostRow(
            label: 'Total Biaya',
            percentage: ((stats.totalHPP + stats.totalExpenses) / totalRevenue * 100),
            amount: stats.totalCost,
            color: Colors.purple,
            highlight: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCostRow({
    required String label,
    required double percentage,
    required double amount,
    required Color color,
    bool highlight = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: highlight ? FontWeight.bold : FontWeight.w600,
              ),
            ),
            Text(
              '${percentage.toStringAsFixed(1)}%',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: (percentage / 100).clamp(0, 1),
            minHeight: 6,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Rp${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessHealthScore() {
    // Calculate health score (0-100)
    double healthScore = 0;

    // Revenue trend (max 30)
    if (stats.revenueTrend >= 10) {
      healthScore += 30;
    } else if (stats.revenueTrend >= 0) {
      healthScore += 15;
    }

    // Profit margin (max 40)
    if (stats.profitMargin >= 30) {
      healthScore += 40;
    } else if (stats.profitMargin >= 15) {
      healthScore += 25;
    } else if (stats.profitMargin >= 0) {
      healthScore += 15;
    }

    // Cost control (max 30)
    final costRatio = (stats.totalCost / stats.totalRevenue * 100);
    if (costRatio <= 50) {
      healthScore += 30;
    } else if (costRatio <= 70) {
      healthScore += 15;
    }

    final health = healthScore.round();
    final healthStatus = health >= 75
        ? 'Sangat Baik'
        : health >= 50
            ? 'Baik'
            : health >= 25
                ? 'Cukup'
                : 'Perlu Perbaikan';
    final healthColor = health >= 75
        ? Colors.green
        : health >= 50
            ? Colors.blue
            : health >= 25
                ? Colors.orange
                : Colors.red;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [healthColor.shade600, healthColor.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Skor Kesehatan Bisnis',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$health/100',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: health / 100,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                healthStatus,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                health >= 75
                    ? '✓ Bisnis sehat'
                    : health >= 50
                        ? '○ Mulai diperhatikan'
                        : '✗ Butuh perbaikan',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
