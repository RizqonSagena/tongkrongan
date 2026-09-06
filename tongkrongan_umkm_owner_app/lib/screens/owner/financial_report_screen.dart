import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/owner/bottom_navigation.dart';

class FinancialReportScreen extends StatefulWidget {
  const FinancialReportScreen({super.key});

  @override
  State<FinancialReportScreen> createState() => _FinancialReportScreenState();
}

class _FinancialReportScreenState extends State<FinancialReportScreen> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedPeriod = 'Bulan Ini';
  
  final List<String> periods = ['Hari Ini', 'Minggu Ini', 'Bulan Ini', 'Custom'];

  // Mock data for different periods
  final Map<String, ReportData> reportData = {
    'Hari Ini': ReportData(
      omzet: 2450000,
      pengeluaran: 850000,
      labaKotor: 1600000,
      labaBersih: 1400000,
      transaksi: 87,
      customer: 76,
      produkTerjual: 143,
    ),
    'Minggu Ini': ReportData(
      omzet: 14500000,
      pengeluaran: 4700000,
      labaKotor: 9800000,
      labaBersih: 8900000,
      transaksi: 542,
      customer: 412,
      produkTerjual: 1024,
    ),
    'Bulan Ini': ReportData(
      omzet: 78500000,
      pengeluaran: 35600000,
      labaKotor: 42900000,
      labaBersih: 38200000,
      transaksi: 2156,
      customer: 1678,
      produkTerjual: 4892,
    ),
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  ReportData get currentData => reportData[selectedPeriod]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Laporan Keuangan',
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
            onPressed: () => _showExportOptions(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue[800],
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: Colors.blue[800],
          tabs: const [
            Tab(text: 'Harian'),
            Tab(text: 'Mingguan'),
            Tab(text: 'Bulanan'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Period Selector
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  'Periode:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedPeriod,
                        isExpanded: true,
                        items: periods.map((period) {
                          return DropdownMenuItem(
                            value: period,
                            child: Text(period),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedPeriod = value;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Report Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDailyReport(),
                _buildWeeklyReport(),
                _buildMonthlyReport(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const OwnerBottomNavigation(currentIndex: 4),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _exportReport(),
        backgroundColor: Colors.blue[600],
        icon: const Icon(Icons.download, color: Colors.white),
        label: const Text(
          'Export Laporan',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildDailyReport() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReportHeader(),
          const SizedBox(height: 24),
          _buildFinancialSummary(),
          const SizedBox(height: 24),
          _buildOperationalMetrics(),
          const SizedBox(height: 24),
          _buildDailyBreakdown(),
        ],
      ),
    );
  }

  Widget _buildWeeklyReport() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReportHeader(),
          const SizedBox(height: 24),
          _buildFinancialSummary(),
          const SizedBox(height: 24),
          _buildOperationalMetrics(),
          const SizedBox(height: 24),
          _buildWeeklyTrend(),
        ],
      ),
    );
  }

  Widget _buildMonthlyReport() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReportHeader(),
          const SizedBox(height: 24),
          _buildFinancialSummary(),
          const SizedBox(height: 24),
          _buildOperationalMetrics(),
          const SizedBox(height: 24),
          _buildMonthlyComparison(),
        ],
      ),
    );
  }

  Widget _buildReportHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[600]!, Colors.blue[800]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Laporan Keuangan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            selectedPeriod,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'OMZET',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rp ${_formatNumber(currentData.omzet.toInt())}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.trending_up,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialSummary() {
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
            'Ringkasan Keuangan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildFinancialItem('OMZET', currentData.omzet, Colors.green),
          _buildFinancialItem('PENGELUARAN', currentData.pengeluaran, Colors.red),
          _buildFinancialItem('LABA KOTOR', currentData.labaKotor, Colors.blue),
          _buildFinancialItem('LABA BERSIH', currentData.labaBersih, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildFinancialItem(String label, double amount, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          Text(
            'Rp ${_formatNumber(amount.toInt())}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationalMetrics() {
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
            'Metrik Operasional',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Total Transaksi',
                  currentData.transaksi.toString(),
                  Icons.receipt,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  'Total Customer',
                  currentData.customer.toString(),
                  Icons.people,
                  Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          _buildMetricCard(
            'Produk Terjual',
            currentData.produkTerjual.toString(),
            Icons.inventory,
            Colors.green,
            isWide: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    String title, 
    String value, 
    IconData icon, 
    Color color, 
    {bool isWide = false}
  ) {
    return Container(
      width: isWide ? double.infinity : null,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyBreakdown() {
    final hours = ['06:00', '09:00', '12:00', '15:00', '18:00', '21:00'];
    final sales = [150000, 280000, 650000, 420000, 780000, 170000];
    
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
            'Penjualan Per Jam',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          ...List.generate(hours.length, (index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(
                      hours[index],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 6,
                      child: LinearProgressIndicator(
                        value: sales[index] / sales.reduce((a, b) => a > b ? a : b),
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Rp ${_formatNumber(sales[index])}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildWeeklyTrend() {
    final days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    final sales = [1200000, 1800000, 1500000, 2200000, 2800000, 3200000, 1800000];
    
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
            'Tren Mingguan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          
          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(days.length, (index) {
                final double height = (sales[index] / sales.reduce((a, b) => a > b ? a : b)) * 120;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 24,
                      height: height,
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      days[index],
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyComparison() {
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
            'Perbandingan Bulan Sebelumnya',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildComparisonItem('Omzet', 78500000, 72000000),
          _buildComparisonItem('Pengeluaran', 35600000, 32800000),
          _buildComparisonItem('Laba Bersih', 38200000, 35400000),
          _buildComparisonItem('Transaksi', 2156, 1987),
        ],
      ),
    );
  }

  Widget _buildComparisonItem(String label, num current, num previous) {
    final double percentage = ((current - previous) / previous * 100);
    final bool isPositive = percentage > 0;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  current is double 
                      ? 'Rp ${_formatNumber(current.toInt())}'
                      : current.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isPositive 
                  ? Colors.green[100] 
                  : Colors.red[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 12,
                  color: isPositive ? Colors.green[800] : Colors.red[800],
                ),
                const SizedBox(width: 2),
                Text(
                  '${percentage.abs().toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isPositive ? Colors.green[800] : Colors.red[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showExportOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Laporan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
              title: const Text('PDF Report'),
              subtitle: Text('Laporan $selectedPeriod'),
              onTap: () {
                Navigator.pop(context);
                _exportToPDF();
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.table_chart, color: Colors.green),
              title: const Text('Excel Report'),
              subtitle: Text('Data $selectedPeriod'),
              onTap: () {
                Navigator.pop(context);
                _exportToExcel();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _exportReport() {
    _showExportOptions(context);
  }

  void _exportToPDF() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Laporan $selectedPeriod berhasil diexport ke PDF'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _exportToExcel() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data $selectedPeriod berhasil diexport ke Excel'),
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

class ReportData {
  final double omzet;
  final double pengeluaran;
  final double labaKotor;
  final double labaBersih;
  final int transaksi;
  final int customer;
  final int produkTerjual;

  ReportData({
    required this.omzet,
    required this.pengeluaran,
    required this.labaKotor,
    required this.labaBersih,
    required this.transaksi,
    required this.customer,
    required this.produkTerjual,
  });
}