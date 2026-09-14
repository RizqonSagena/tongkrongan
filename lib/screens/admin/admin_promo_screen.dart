import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/models/admin.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class AdminPromoScreen extends StatefulWidget {
  const AdminPromoScreen({super.key});

  @override
  State<AdminPromoScreen> createState() => _AdminPromoScreenState();
}

class _AdminPromoScreenState extends State<AdminPromoScreen> {
  late List<PromoEvent> promoList;
  late List<KedaiManagement> kedaiList;
  String selectedFilter = 'Semua'; // Semua, Aktif, Draft, Expired
  String? selectedKedaiId;

  @override
  void initState() {
    super.initState();
    promoList = _generateMockPromos();
    kedaiList = AdminMockData.generateMockKedaiManagement();
    if (kedaiList.isNotEmpty) {
      selectedKedaiId = kedaiList[0].id;
    }
  }

  List<PromoEvent> _generateMockPromos() {
    return [
      PromoEvent(
        id: 'PROMO001',
        kedaiId: 'KEDAI001',
        type: 'promo',
        title: 'Diskon 30% Kopi Susu',
        description: 'Hemat hingga 30% untuk setiap pembelian Kopi Susu Premium',
        imageUrl: 'https://example.com/promo1.jpg',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 14)),
        couponCode: 'KOPI30',
        discountPercentage: 30,
        status: 'active',
        createdByAdminId: 'ADMIN001',
        createdAt: DateTime.now().subtract(Duration(days: 2)),
      ),
      PromoEvent(
        id: 'PROMO002',
        kedaiId: 'KEDAI001',
        type: 'event',
        title: 'Grand Opening - Tasting Menu',
        description: 'Acara spesial mencoba menu baru dengan special price',
        imageUrl: 'https://example.com/event1.jpg',
        startDate: DateTime.now().add(Duration(days: 10)),
        endDate: DateTime.now().add(Duration(days: 11)),
        eventType: 'special',
        status: 'upcoming',
        createdByAdminId: 'ADMIN001',
        createdAt: DateTime.now(),
      ),
      PromoEvent(
        id: 'PROMO003',
        kedaiId: 'KEDAI002',
        type: 'promo',
        title: 'Buy 1 Get 1 Free',
        description: 'Beli 1 porsi, gratis 1 porsi untuk menu pilihan',
        imageUrl: 'https://example.com/promo2.jpg',
        startDate: DateTime.now().subtract(Duration(days: 20)),
        endDate: DateTime.now().subtract(Duration(days: 5)),
        couponCode: 'B1G1',
        discountPercentage: 50,
        status: 'expired',
        createdByAdminId: 'ADMIN001',
        createdAt: DateTime.now().subtract(Duration(days: 25)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Kelola Promo & Event'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPromoDialog,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kedai Selector
            _buildKedaiSelector(),
            const SizedBox(height: 16),

            // Filter Tabs
            _buildFilterTabs(),
            const SizedBox(height: 16),

            // Statistics
            _buildStatistics(),
            const SizedBox(height: 24),

            // Promo List
            Text(
              'Daftar Promo & Event',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _buildPromoList(),

            const SizedBox(height: 24),

            // Info Banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info, color: Colors.purple, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '📢 Promo dibuat berdasarkan request Management/Owner',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKedaiSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih Kedai',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 8),
        DropdownButton<String>(
          isExpanded: true,
          value: selectedKedaiId,
          items: kedaiList.map((kedai) {
            return DropdownMenuItem(
              value: kedai.id,
              child: Text(kedai.name),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedKedaiId = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ['Semua', 'Aktif', 'Upcoming', 'Expired']
            .map((filter) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filter),
                    selected: selectedFilter == filter,
                    onSelected: (selected) {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildStatistics() {
    int totalPromo = promoList.length;
    int activeCount = promoList.where((p) => p.status == 'active').length;
    int upcomingCount = promoList.where((p) => p.status == 'upcoming').length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Total',
            value: totalPromo.toString(),
            icon: Icons.local_offer,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Aktif',
            value: activeCount.toString(),
            icon: Icons.check_circle,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Segera',
            value: upcomingCount.toString(),
            icon: Icons.schedule,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoList() {
    List<PromoEvent> filteredPromo = promoList.where((promo) {
      if (selectedFilter == 'Aktif') {
        return promo.status == 'active';
      } else if (selectedFilter == 'Upcoming') {
        return promo.status == 'upcoming';
      } else if (selectedFilter == 'Expired') {
        return promo.status == 'expired';
      }
      return true;
    }).toList();

    if (filteredPromo.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              Icon(Icons.local_offer, size: 48, color: Colors.grey[300]),
              const SizedBox(height: 12),
              Text(
                'Belum ada promo',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey[500],
                    ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: filteredPromo
          .map((promo) => _buildPromoCard(promo))
          .toList(),
    );
  }

  Widget _buildPromoCard(PromoEvent promo) {
    Color statusColor = promo.status == 'active'
        ? Colors.green
        : promo.status == 'upcoming'
            ? Colors.blue
            : Colors.grey;

    String statusLabel = promo.status == 'active'
        ? 'Aktif'
        : promo.status == 'upcoming'
            ? 'Segera Dimulai'
            : 'Berakhir';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          promo.type == 'promo'
                              ? Icons.local_offer
                              : Icons.event,
                          size: 20,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            promo.title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      promo.description,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey[600],
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  statusLabel,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Period & Details
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Periode',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey[600],
                            fontSize: 11,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${promo.startDate.day}/${promo.startDate.month} - ${promo.endDate.day}/${promo.endDate.month}',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: promo.discountPercentage != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Diskon',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.grey[600],
                                      fontSize: 11,
                                    ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${promo.discountPercentage}%',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
              ),
              Expanded(
                child: promo.couponCode != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kode',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.grey[600],
                                      fontSize: 11,
                                    ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            promo.couponCode!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showEditPromoDialog(promo),
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Edit'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      if (promo.status == 'active') {
                        promo.archive();
                      } else if (promo.status == 'upcoming') {
                        promo.publish();
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Promo status diperbarui menjadi ${promo.status}',
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    promo.status == 'active'
                        ? Icons.archive
                        : Icons.publish,
                    size: 16,
                  ),
                  label: Text(promo.status == 'active' ? 'Archive' : 'Publikasi'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      promoList.remove(promo);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Promo dihapus')),
                    );
                  },
                  icon: const Icon(Icons.delete, size: 16),
                  label: const Text('Hapus'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddPromoDialog() {
    String type = 'promo';
    String title = '';
    String description = '';
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now().add(Duration(days: 7));
    String discountPercentage = '';
    String couponCode = '';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Tambah Promo/Event Baru'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: type,
                  items: const [
                    DropdownMenuItem(value: 'promo', child: Text('🎟️ Promo')),
                    DropdownMenuItem(value: 'event', child: Text('🎉 Event')),
                  ],
                  onChanged: (value) {
                    setDialogState(() {
                      type = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Tipe',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  onChanged: (value) => title = value,
                  decoration: InputDecoration(
                    labelText: 'Judul',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  onChanged: (value) => description = value,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (type == 'promo') ...[
                  TextFormField(
                    onChanged: (value) => couponCode = value,
                    decoration: InputDecoration(
                      labelText: 'Kode Kupon (opsional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    onChanged: (value) => discountPercentage = value,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Diskon %',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (title.isNotEmpty && description.isNotEmpty) {
                  setState(() {
                    promoList.add(
                      PromoEvent(
                        id: 'PROMO${promoList.length + 1}',
                        kedaiId: selectedKedaiId!,
                        type: type,
                        title: title,
                        description: description,
                        imageUrl:
                            'https://example.com/promo${promoList.length}.jpg',
                        startDate: startDate,
                        endDate: endDate,
                        couponCode:
                            couponCode.isNotEmpty ? couponCode : null,
                        discountPercentage: discountPercentage.isNotEmpty
                            ? double.tryParse(discountPercentage)
                            : null,
                        status: 'draft',
                        createdByAdminId: 'ADMIN001',
                        createdAt: DateTime.now(),
                      ),
                    );
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${type == 'promo' ? 'Promo' : 'Event'} berhasil ditambahkan'),
                    ),
                  );
                }
              },
              child: const Text('Tambah'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditPromoDialog(PromoEvent promo) {
    String title = promo.title;
    String description = promo.description;
    String discountPercentage = promo.discountPercentage?.toString() ?? '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Promo/Event'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: title,
                onChanged: (value) => title = value,
                decoration: InputDecoration(
                  labelText: 'Judul',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: description,
                onChanged: (value) => description = value,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (promo.type == 'promo')
                TextFormField(
                  initialValue: discountPercentage,
                  onChanged: (value) => discountPercentage = value,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Diskon %',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                promo.title = title;
                promo.description = description;
                if (discountPercentage.isNotEmpty) {
                  promo.discountPercentage =
                      double.tryParse(discountPercentage);
                }
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Promo berhasil diperbarui'),
                ),
              );
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
