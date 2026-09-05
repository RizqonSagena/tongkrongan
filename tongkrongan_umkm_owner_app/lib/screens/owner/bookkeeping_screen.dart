import 'package:flutter/material.dart';
import '../../widgets/owner/bottom_navigation.dart';
import '../../widgets/owner/period_selector.dart';

class BookkeepingScreen extends StatefulWidget {
  const BookkeepingScreen({super.key});

  @override
  State<BookkeepingScreen> createState() => _BookkeepingScreenState();
}

class _BookkeepingScreenState extends State<BookkeepingScreen> {
  String selectedPeriod = 'Bulan Ini';

  // Mock data for financial overview
  final Map<String, FinancialData> financialData = {
    'Hari Ini': FinancialData(
      revenue: 2450000,
      operatingExpenses: 850000,
      investment: 0,
      employeeSalary: 0,
    ),
    'Minggu Ini': FinancialData(
      revenue: 14500000,
      operatingExpenses: 4200000,
      investment: 500000,
      employeeSalary: 0,
    ),
    'Bulan Ini': FinancialData(
      revenue: 78500000,
      operatingExpenses: 24500000,
      investment: 2500000,
      employeeSalary: 8600000,
    ),
  };

  // Monthly trend data
  final List<MonthlyData> monthlyTrend = [
    MonthlyData(month: 'Jan', revenue: 65000000, expenses: 32000000),
    MonthlyData(month: 'Feb', revenue: 72000000, expenses: 35000000),
    MonthlyData(month: 'Mar', revenue: 78500000, expenses: 37000000),
    MonthlyData(month: 'Apr', revenue: 68000000, expenses: 33000000),
    MonthlyData(month: 'Mei', revenue: 82000000, expenses: 38000000),
    MonthlyData(month: 'Jun', revenue: 78500000, expenses: 35100000),
  ];

  FinancialData get currentData => financialData[selectedPeriod]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Pembukuan',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download, color: Colors.black87),
            onPressed: () => _showExportDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            PeriodSelector(
              selectedPeriod: selectedPeriod,
              onPeriodChanged: (period) {
                setState(() {
                  selectedPeriod = period;
                });
              },
            ),
            const SizedBox(height: 24),

            // Financial Overview Cards
            Row(
              children: [
                Expanded(
                  child: _buildFinancialCard(
                    'Pendapatan',
                    currentData.revenue,
                    Icons.trending_up,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildFinancialCard(
                    'Total Pengeluaran',
                    currentData.totalExpenses,
                    Icons.trending_down,
                    Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            Row(
              children: [
                Expanded(
                  child: _buildFinancialCard(
                    'Laba Kotor',
                    currentData.grossProfit,
                    Icons.account_balance,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildFinancialCard(
                    'Laba Bersih',
                    currentData.netProfit,
                    Icons.savings,
                    currentData.netProfit >= 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Expense Breakdown
            _buildExpenseBreakdown(),
            const SizedBox(height: 24),

            // Revenue vs Expenses Chart
            _buildRevenueExpensesChart(),
            const SizedBox(height: 24),

            // Monthly Trend
            if (selectedPeriod == 'Bulan Ini') _buildMonthlyTrend(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 3),
    );
  }

  Widget _buildFinancialCard(String title, double amount, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            amount >= 0 
                ? 'Rp ${_formatNumber(amount.toInt())}'
                : '-Rp ${_formatNumber(amount.abs().toInt())}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: amount >= 0 ? Colors.black87 : Colors.red,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseBreakdown() {
    final expenses = [
      ExpenseItem('Biaya Operasional', currentData.operatingExpenses, Colors.orange),
      ExpenseItem('Gaji Pegawai', currentData.employeeSalary, Colors.blue),
      ExpenseItem('Investasi', currentData.investment, Colors.purple),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rincian Pengeluaran',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...expenses.map((expense) => _buildExpenseItem(expense)),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Pengeluaran',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Rp ${_formatNumber(currentData.totalExpenses.toInt())}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseItem(ExpenseItem expense) {
    if (expense.amount == 0) return const SizedBox.shrink();
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: expense.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              expense.category,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
              ),
            ),
          ),
          Text(
            'Rp ${_formatNumber(expense.amount.toInt())}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueExpensesChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pendapatan vs Pengeluaran',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                selectedPeriod,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Simple bar chart
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: (currentData.revenue / (currentData.revenue + currentData.totalExpenses)) * 120,
                            decoration: BoxDecoration(
                              color: Colors.green[600],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Pendapatan',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Rp ${_formatNumber(currentData.revenue.toInt())}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: (currentData.totalExpenses / (currentData.revenue + currentData.totalExpenses)) * 120,
                            decoration: BoxDecoration(
                              color: Colors.red[600],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Pengeluaran',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Rp ${_formatNumber(currentData.totalExpenses.toInt())}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyTrend() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tren Bulanan (6 Bulan Terakhir)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          
          Container(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: monthlyTrend.map((data) {
                double maxAmount = monthlyTrend.map((e) => e.revenue).reduce((a, b) => a > b ? a : b);
                double revenueHeight = (data.revenue / maxAmount) * 150;
                double expensesHeight = (data.expenses / maxAmount) * 150;
                
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Revenue bar
                    Container(
                      width: 20,
                      height: revenueHeight,
                      decoration: BoxDecoration(
                        color: Colors.green[600],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Expenses bar
                    Container(
                      width: 20,
                      height: expensesHeight,
                      decoration: BoxDecoration(
                        color: Colors.red[600],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data.month,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Pendapatan', Colors.green[600]!),
              const SizedBox(width: 20),
              _buildLegendItem('Pengeluaran', Colors.red[600]!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Pembukuan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pilih format export:'),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
              title: const Text('PDF'),
              subtitle: const Text('Format dokumen'),
              onTap: () {
                Navigator.pop(context);
                _exportToPDF();
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.table_chart, color: Colors.green),
              title: const Text('Excel'),
              subtitle: const Text('Format spreadsheet'),
              onTap: () {
                Navigator.pop(context);
                _exportToExcel();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }

  void _exportToPDF() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Export PDF berhasil! File disimpan di Downloads'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _exportToExcel() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Export Excel berhasil! File disimpan di Downloads'),
        backgroundColor: Colors.green,
      ),
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]}.',
    );
  }
}

class FinancialData {
  final double revenue;
  final double operatingExpenses;
  final double investment;
  final double employeeSalary;

  FinancialData({
    required this.revenue,
    required this.operatingExpenses,
    required this.investment,
    required this.employeeSalary,
  });

  double get totalExpenses => operatingExpenses + investment + employeeSalary;
  double get grossProfit => revenue - operatingExpenses;
  double get netProfit => revenue - totalExpenses;
}

class ExpenseItem {
  final String category;
  final double amount;
  final Color color;

  ExpenseItem(this.category, this.amount, this.color);
}

class MonthlyData {
  final String month;
  final double revenue;
  final double expenses;

  MonthlyData({
    required this.month,
    required this.revenue,
    required this.expenses,
  });
}