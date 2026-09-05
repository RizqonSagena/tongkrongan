import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/owner/kpi_card.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/owner/period_selector.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/owner/revenue_chart.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/owner/insight_card.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/owner/bottom_navigation.dart';
import 'package:intl/intl.dart';

class OwnerDashboardScreen extends StatefulWidget {
  const OwnerDashboardScreen({super.key});

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> {
  String _selectedPeriod = 'Hari Ini';
  final List<String> _periods = ['Hari Ini', 'Minggu Ini', 'Bulan Ini'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              
              // Business Status
              _buildBusinessStatus(),
              
              // Main KPI Cards
              _buildKPICards(),
              
              // Period Selector
              PeriodSelector(
                periods: _periods,
                selectedPeriod: _selectedPeriod,
                onPeriodChanged: (period) {
                  setState(() {
                    _selectedPeriod = period;
                  });
                },
              ),
              
              // Revenue Chart
              const RevenueChart(),
              
              // Business Insights
              _buildBusinessInsights(),
              
              const SizedBox(height: AppTheme.space2xl),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const OwnerBottomNavigation(currentIndex: 0),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.marginMobile),
      child: Row(
        children: [
          // Business Logo
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.primaryFixed,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.onSurface.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.storefront,
              color: AppTheme.primary,
              size: 28,
            ),
          ),
          
          const SizedBox(width: AppTheme.spaceMd),
          
          // Greeting
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat datang,',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  'Pak/Bu Warung Kopi Aman',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppTheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Notification Bell
          IconButton(
            onPressed: () {},
            icon: Stack(
              children: [
                const Icon(
                  Icons.notifications_outlined,
                  size: 28,
                  color: AppTheme.onSurface,
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppTheme.error,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.surface, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessStatus() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.marginMobile),
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceMd, vertical: AppTheme.spaceSm),
      decoration: BoxDecoration(
        color: AppTheme.secondaryContainer.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.secondary.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppTheme.secondary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppTheme.spaceXs),
          Text(
            'Usaha Aktif',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: AppTheme.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKPICards() {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Container(
      margin: const EdgeInsets.all(AppTheme.marginMobile),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: KPICard(
                  title: 'Omzet Hari Ini',
                  value: currencyFormat.format(2450000),
                  icon: Icons.trending_up,
                  iconColor: AppTheme.secondary,
                  backgroundColor: AppTheme.secondaryContainer.withOpacity(0.2),
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: KPICard(
                  title: 'Transaksi Hari Ini',
                  value: '87',
                  icon: Icons.receipt_long,
                  iconColor: AppTheme.primary,
                  backgroundColor: AppTheme.primaryFixed.withOpacity(0.3),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Row(
            children: [
              Expanded(
                child: KPICard(
                  title: 'Customer Hari Ini',
                  value: '76',
                  icon: Icons.people,
                  iconColor: AppTheme.tertiary,
                  backgroundColor: AppTheme.tertiaryFixed.withOpacity(0.3),
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: KPICard(
                  title: 'Produk Terjual',
                  value: '143',
                  icon: Icons.inventory,
                  iconColor: AppTheme.secondary,
                  backgroundColor: AppTheme.secondaryContainer.withOpacity(0.2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessInsights() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.marginMobile),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Insight Bisnis',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppTheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          
          // Insights Cards
          Column(
            children: [
              InsightCard(
                icon: Icons.local_fire_department,
                iconColor: AppTheme.error,
                title: 'Produk Terlaris',
                description: 'Es Kopi Susu adalah produk terlaris hari ini.',
                value: '32 porsi',
                backgroundColor: AppTheme.errorContainer.withOpacity(0.2),
              ),
              const SizedBox(height: AppTheme.spaceMd),
              InsightCard(
                icon: Icons.trending_down,
                iconColor: AppTheme.tertiary,
                title: 'Perlu Perhatian',
                description: 'Penjualan Roti Bakar turun 18% dibanding minggu lalu.',
                value: '12 porsi',
                backgroundColor: AppTheme.tertiaryContainer.withOpacity(0.2),
              ),
              const SizedBox(height: AppTheme.spaceMd),
              InsightCard(
                icon: Icons.attach_money,
                iconColor: AppTheme.secondary,
                title: 'Laba Bersih',
                description: 'Keuntungan bersih hari ini meningkat 12%.',
                value: 'Rp 1.250.000',
                backgroundColor: AppTheme.secondaryContainer.withOpacity(0.2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}