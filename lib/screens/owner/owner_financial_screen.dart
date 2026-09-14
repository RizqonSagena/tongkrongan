import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/models/owner.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class OwnerFinancialScreen extends StatefulWidget {
  const OwnerFinancialScreen({super.key});

  @override
  State<OwnerFinancialScreen> createState() => _OwnerFinancialScreenState();
}

class _OwnerFinancialScreenState extends State<OwnerFinancialScreen> {
  late BusinessStats stats;
  late List<Transaction> transactions;
  late List<Expense> expenses;

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
        title: const Text('Dashboard Keuangan'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Profit/Loss Display
            _buildProfitLossCard(),

            const SizedBox(height: 28),

            // Financial Breakdown
            Text(
              'Rincian Keuangan Detail',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildFinancialBreakdown(),

            const SizedBox(height: 28),

            // Profit Margin Analysis
            Text(
              'Analisis Margin Keuntungan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildMarginAnalysis(),

            const SizedBox(height: 28),

            // Expense Breakdown
            Text(
              'Rincian Biaya',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildExpenseBreakdown(),

            const SizedBox(height: 28),

            // Trend Analysis
            Text(
              'Tren Keuangan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildTrendAnalysis(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildProfitLossCard() {
    final isProfit = stats.netProfit >= 0;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isProfit
              ? [Colors.green.shade600, Colors.green.shade400]
              : [Colors.red.shade600, Colors.red.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isProfit ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Laba Bersih (Net Profit)',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            stats.formattedProfit,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Margin Keuntungan',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${stats.profitMargin.toStringAsFixed(2)}%',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Status',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      isProfit ? '✓ Menguntungkan' : '✗ Rugi',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialBreakdown() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildFinancialRow(
            label: 'Pendapatan Kotor (Omzet)',
            value: stats.formattedRevenue,
            icon: Icons.trending_up,
            color: Colors.blue,
            isTitle: true,
          ),
          Divider(color: Colors.grey.shade200, height: 20),
          _buildFinancialRow(
            label: 'HPP (Harga Pokok Penjualan)',
            value: '-Rp${stats.totalHPP.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
            icon: Icons.shopping_cart,
            color: Colors.orange,
          ),
          Divider(color: Colors.grey.shade200, height: 20),
          _buildFinancialRow(
            label: 'Laba Kotor (Gross Profit)',
            value: 'Rp${stats.grossProfit.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
            icon: Icons.trending_up,
            color: Colors.green,
            highlight: true,
          ),
          Divider(color: Colors.grey.shade200, height: 20),
          _buildFinancialRow(
            label: 'Biaya Operasional',
            value: '-Rp${stats.totalExpenses.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
            icon: Icons.money_off,
            color: Colors.red,
          ),
          Divider(color: Colors.grey.shade200, height: 20),
          _buildFinancialRow(
            label: 'Laba Bersih (Net Profit)',
            value: stats.formattedProfit,
            icon: Icons.attach_money,
            color: stats.netProfit >= 0 ? Colors.green : Colors.red,
            isTitle: true,
            highlight: true,
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialRow({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
    bool isTitle = false,
    bool highlight = false,
  }) {
    return Container(
      padding: highlight ? const EdgeInsets.all(12) : EdgeInsets.zero,
      decoration: highlight
          ? BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 12),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: isTitle || highlight ? FontWeight.bold : FontWeight.w500,
                  color: isTitle || highlight ? color : Colors.black,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: isTitle || highlight ? FontWeight.bold : FontWeight.w600,
              color: color,
              fontSize: isTitle ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarginAnalysis() {
    final grossMargin = (stats.grossProfit / stats.totalRevenue * 100);
    final expenseRatio = (stats.totalExpenses / stats.totalRevenue * 100);

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: [
        _buildMarginCard(
          label: 'Margin Kotor',
          percentage: grossMargin,
          color: Colors.blue,
        ),
        _buildMarginCard(
          label: 'Ratio Biaya',
          percentage: expenseRatio,
          color: Colors.orange,
        ),
        _buildMarginCard(
          label: 'Margin Bersih',
          percentage: stats.profitMargin,
          color: stats.profitMargin >= 0 ? Colors.green : Colors.red,
        ),
        _buildMarginCard(
          label: 'ROI',
          percentage: stats.profitMargin,
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildMarginCard({
    required String label,
    required double percentage,
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
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '${percentage.toStringAsFixed(1)}%',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (percentage.abs() / 100).clamp(0, 1),
              minHeight: 4,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseBreakdown() {
    final expensesByType = <String, double>{};
    for (var exp in expenses) {
      expensesByType[exp.expenseType] =
          (expensesByType[exp.expenseType] ?? 0) + exp.amount;
    }

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
        itemCount: expensesByType.length,
        separatorBuilder: (context, index) =>
            Divider(color: Colors.grey.shade200, height: 16),
        itemBuilder: (context, index) {
          final entry = expensesByType.entries.toList()[index];
          final percentage = (entry.value / stats.totalExpenses * 100);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
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
          );
        },
      ),
    );
  }

  Widget _buildTrendAnalysis() {
    return Row(
      children: [
        Expanded(
          child: _buildTrendCard(
            label: 'Tren Penjualan',
            value: '${stats.revenueTrend > 0 ? '+' : ''}${stats.revenueTrend.toStringAsFixed(1)}%',
            isPositive: stats.revenueTrend >= 0,
            icon: stats.revenueTrend >= 0 ? Icons.trending_up : Icons.trending_down,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildTrendCard(
            label: 'Tren Biaya',
            value: '${stats.expenseTrend > 0 ? '+' : ''}${stats.expenseTrend.toStringAsFixed(1)}%',
            isPositive: stats.expenseTrend <= 0, // Positive jika biaya turun
            icon: stats.expenseTrend <= 0 ? Icons.trending_down : Icons.trending_up,
          ),
        ),
      ],
    );
  }

  Widget _buildTrendCard({
    required String label,
    required String value,
    required bool isPositive,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isPositive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPositive ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: isPositive ? Colors.green : Colors.red,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: isPositive ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: isPositive ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
