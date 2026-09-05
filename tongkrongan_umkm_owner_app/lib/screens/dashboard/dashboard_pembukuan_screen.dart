import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:intl/intl.dart';

class DashboardPembukuanScreen extends StatefulWidget {
  const DashboardPembukuanScreen({super.key});

  @override
  State<DashboardPembukuanScreen> createState() => _DashboardPembukuanScreenState();
}

class _DashboardPembukuanScreenState extends State<DashboardPembukuanScreen> {
  String _selectedPeriod = 'Bulan Ini';
  final List<String> _periods = ['Hari Ini', 'Minggu Ini', 'Bulan Ini'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: CustomScrollView(
        slivers: [
          // App Bar
          _buildSliverAppBar(),
          
          // Body content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.marginMobile),
              child: Column(
                children: [
                  // Store info card
                  _buildStoreInfoCard(),
                  
                  const SizedBox(height: AppTheme.spaceMd),
                  
                  // Period selector
                  _buildPeriodSelector(),
                  
                  const SizedBox(height: AppTheme.spaceLg),
                  
                  // Cash flow summary cards
                  _buildCashFlowCards(),
                  
                  const SizedBox(height: AppTheme.spaceLg),
                  
                  // Chart section
                  _buildChartSection(),
                  
                  const SizedBox(height: AppTheme.spaceLg),
                  
                  // Recent transactions
                  _buildRecentTransactions(),
                  
                  const SizedBox(height: AppTheme.space2xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: AppTheme.surface.withOpacity(0.85),
      elevation: 0,
      scrolledUnderElevation: 1,
      floating: true,
      snap: true,
      title: Row(
        children: [
          Image.network(
            'https://lh3.googleusercontent.com/aida/AEtjO1UDpv0utg8ZWQ9knsLt7pxxMYgnsGiys7CRC9vS2cGtn1R5W3sTiOToaH6KMBl4eC4LQwJpQH4xQokcDZvNxgVnakkLEZa-MF03v6fbF994A5JV1rKj2D0X1vxvjbux2S6c8Nq3bGTWiz4-605U0bp_i9lBL6fOR6m3x0VEwhw-yH_n2QseC_Kpah5s80ew5He_QpRgGScZm_1QeuW0fQEeFOFMWjkt6GvAg5SlokiGZl21us-9mtjO30o',
            height: 32,
            width: 32,
            errorBuilder: (context, error, stackTrace) => 
              const Icon(Icons.storefront, size: 32, color: AppTheme.primary),
          ),
          const SizedBox(width: AppTheme.spaceXs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TONGkrongan',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppTheme.primary,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Pembukuan',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppTheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Stack(
            children: [
              const Icon(
                Icons.notifications_outlined,
                size: 24,
                color: AppTheme.onSurfaceVariant,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.surface, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: AppTheme.marginMobile),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainer,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida/AEtjO1UPraMNP2dLO59AysK7IhOhvEr1XEoYkWNFIM9OA4eVVDplJDCwzcFg-TQ9SzBPy0qcdwa0fqNVHK_-0N2HBDtUpTvpXs8lyve9GHGvp2TkbC-Qi8tK_stNIlT_VzaBKqKW4N_su5eDpICREny4Kjot0KAZbjOAscIzQn_NbdBjztuOb_3I0t2jpFotcelx6gW9Jhh4qRue_zTLk3iq4peg3_prpNDe2kniWLGy-v3gbs2ShLWrB0m1Kio',
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => 
                    const Icon(Icons.person, color: AppTheme.primary),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStoreInfoCard() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceSm),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        boxShadow: [
          BoxShadow(
            color: AppTheme.onSurface.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.tertiaryFixed,
              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            ),
            child: const Icon(
              Icons.local_cafe,
              size: 20,
              color: AppTheme.onTertiaryFixed,
            ),
          ),
          const SizedBox(width: AppTheme.spaceXs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kedai Kopi Aman',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppTheme.onSurface,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: AppTheme.primary,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'Tanjungpinang, Kep. Riau',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.secondaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppTheme.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'POS Sinkron',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppTheme.secondary,
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

  Widget _buildPeriodSelector() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  size: 18,
                  color: AppTheme.onSurfaceVariant,
                ),
                const SizedBox(width: 6),
                Text(
                  'Mei 2024',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppTheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '(Bulan Berjalan)',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            TextButton.icon(
              onPressed: () {
                // TODO: Show date picker
              },
              icon: const Icon(Icons.expand_more, size: 16),
              label: const Text('Ganti Bulan'),
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.primary,
                textStyle: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spaceXs),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          ),
          child: Row(
            children: _periods.map((period) {
              final isSelected = period == _selectedPeriod;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedPeriod = period;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                      boxShadow: isSelected ? [
                        BoxShadow(
                          color: AppTheme.onSurface.withOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ] : null,
                    ),
                    child: Text(
                      period,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: isSelected ? AppTheme.onPrimary : AppTheme.onSurfaceVariant,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCashFlowCards() {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Column(
      children: [
        // Summary card
        Container(
          padding: const EdgeInsets.all(AppTheme.spaceMd),
          decoration: BoxDecoration(
            color: AppTheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Laba Bersih Bulan Ini',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppTheme.onPrimaryContainer,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.trending_up,
                          size: 12,
                          color: AppTheme.onSecondaryContainer,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '+12.5%',
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: AppTheme.onSecondaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  currencyFormat.format(8750000),
                  style: AppTextStyles.displayCurrencyMobile.copyWith(
                    color: AppTheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: AppTheme.spaceMd),
        
        // Income and expense cards
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                title: 'Total Pemasukan',
                amount: 15250000,
                icon: Icons.trending_up,
                iconColor: AppTheme.secondary,
                backgroundColor: AppTheme.secondaryContainer.withOpacity(0.2),
              ),
            ),
            const SizedBox(width: AppTheme.spaceMd),
            Expanded(
              child: _buildMetricCard(
                title: 'Total Pengeluaran',
                amount: 6500000,
                icon: Icons.trending_down,
                iconColor: AppTheme.error,
                backgroundColor: AppTheme.errorContainer.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required int amount,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
  }) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: backgroundColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppTheme.onSurface.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                ),
                child: Icon(
                  icon,
                  size: 16,
                  color: iconColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceXs),
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            currencyFormat.format(amount),
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: AppTheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.onSurface.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trend Arus Kas',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppTheme.onSurface,
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),
          
          // Mock chart placeholder
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainer,
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            ),
            child: const Center(
              child: Text(
                'Grafik Arus Kas\n(Chart akan ditambahkan)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.onSurface.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaksi Terbaru',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppTheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Lihat Semua',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceSm),
          
          // Mock transaction list
          ...List.generate(5, (index) {
            final isIncome = index % 2 == 0;
            return _buildTransactionItem(
              title: isIncome ? 'Penjualan Menu' : 'Pembelian Bahan',
              subtitle: '${index + 1} item • ${DateTime.now().day - index}/05',
              amount: isIncome ? 125000 + (index * 25000) : -(50000 + (index * 15000)),
              isIncome: isIncome,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String subtitle,
    required int amount,
    required bool isIncome,
  }) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spaceXs),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isIncome 
                ? AppTheme.secondaryContainer.withOpacity(0.2)
                : AppTheme.errorContainer.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            ),
            child: Icon(
              isIncome ? Icons.add : Icons.remove,
              size: 20,
              color: isIncome ? AppTheme.secondary : AppTheme.error,
            ),
          ),
          const SizedBox(width: AppTheme.spaceSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppTheme.onSurface,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isIncome ? '+' : ''}${currencyFormat.format(amount.abs())}',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: isIncome ? AppTheme.secondary : AppTheme.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}