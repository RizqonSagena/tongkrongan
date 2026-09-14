import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/models/admin.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class AdminKedaiScreen extends StatefulWidget {
  const AdminKedaiScreen({super.key});

  @override
  State<AdminKedaiScreen> createState() => _AdminKedaiScreenState();
}

class _AdminKedaiScreenState extends State<AdminKedaiScreen> {
  late List<KedaiManagement> kedaiList;
  String selectedFilter = 'Semua';
  String searchText = '';

  @override
  void initState() {
    super.initState();
    kedaiList = AdminMockData.generateMockKedaiManagement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Kelola Kedai'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddKedaiDialog,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildFilterTabs(),
            const SizedBox(height: 16),
            _buildStatistics(),
            const SizedBox(height: 24),
            Text(
              'Daftar Kedai',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildKedaiList(),
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
        });
      },
      decoration: InputDecoration(
        hintText: 'Cari kedai...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: searchText.isNotEmpty
            ? IconButton(
                onPressed: () {
                  setState(() {
                    searchText = '';
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
    final filters = ['Semua', 'Aktif', 'Nonaktif'];
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
                      });
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildStatistics() {
    int total = kedaiList.length;
    int active = kedaiList.where((k) => k.isActive).length;
    int inactive = kedaiList.where((k) => !k.isActive).length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard('Total', '$total', Colors.blue),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard('Aktif', '$active', Colors.green),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard('Nonaktif', '$inactive', Colors.orange),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            label,
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
          ),
        ],
      ),
    );
  }

  Widget _buildKedaiList() {
    List<KedaiManagement> filtered = _getFilteredKedai();

    if (filtered.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(Icons.store_mall_directory, size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                'Tidak ada kedai',
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
      itemCount: filtered.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _buildKedaiCard(filtered[index]),
    );
  }

  Widget _buildKedaiCard(KedaiManagement kedai) {
    return GestureDetector(
      onTap: () => _showKedaiDetail(kedai),
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
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kedai.name,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              kedai.address,
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.grey.shade600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text('Edit'),
                      onTap: () => _showEditKedaiDialog(kedai),
                    ),
                    PopupMenuItem(
                      child: Text(kedai.isActive ? 'Nonaktifkan' : 'Aktifkan'),
                      onTap: () => _toggleKedaiStatus(kedai),
                    ),
                    PopupMenuItem(
                      child: const Text('Lihat Detail'),
                      onTap: () => _showKedaiDetail(kedai),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Status & Category
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: kedai.isActive ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    kedai.isActive ? '✓ Aktif' : '○ Nonaktif',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: kedai.isActive ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    kedai.categoryPrimary,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: AppTheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddKedaiDialog() {
    showDialog(
      context: context,
      builder: (context) => _KedaiFormDialog(
        onSave: (kedai) {
          setState(() {
            kedaiList.add(kedai);
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kedai berhasil ditambahkan')),
          );
        },
      ),
    );
  }

  void _showEditKedaiDialog(KedaiManagement kedai) {
    showDialog(
      context: context,
      builder: (context) => _KedaiFormDialog(
        initialKedai: kedai,
        onSave: (updated) {
          setState(() {
            final index = kedaiList.indexOf(kedai);
            if (index >= 0) {
              kedaiList[index] = updated;
            }
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kedai berhasil diperbarui')),
          );
        },
      ),
    );
  }

  void _toggleKedaiStatus(KedaiManagement kedai) {
    setState(() {
      if (kedai.isActive) {
        kedai.deactivate('ADMIN001');
      } else {
        kedai.activate('ADMIN001');
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Kedai ${kedai.isActive ? 'diaktifkan' : 'dinonaktifkan'}'),
      ),
    );
  }

  void _showKedaiDetail(KedaiManagement kedai) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(kedai.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _detailRow('Alamat', kedai.address),
              _detailRow('Telepon', kedai.phoneNumber),
              _detailRow('Kategori', kedai.categoryPrimary),
              _detailRow('Jam Operasional', kedai.operatingHours),
              _detailRow('Status', kedai.isActive ? 'Aktif' : 'Nonaktif'),
              _detailRow('Deskripsi', kedai.description),
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
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  List<KedaiManagement> _getFilteredKedai() {
    return kedaiList.where((kedai) {
      if (searchText.isNotEmpty && !kedai.name.toLowerCase().contains(searchText)) {
        return false;
      }
      switch (selectedFilter) {
        case 'Aktif':
          return kedai.isActive;
        case 'Nonaktif':
          return !kedai.isActive;
        default:
          return true;
      }
    }).toList();
  }
}

class _KedaiFormDialog extends StatefulWidget {
  final KedaiManagement? initialKedai;
  final Function(KedaiManagement) onSave;

  const _KedaiFormDialog({
    this.initialKedai,
    required this.onSave,
  });

  @override
  State<_KedaiFormDialog> createState() => _KedaiFormDialogState();
}

class _KedaiFormDialogState extends State<_KedaiFormDialog> {
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController phoneController;
  late TextEditingController descriptionController;
  late TextEditingController hoursController;
  String selectedCategory = 'Kopi';

  @override
  void initState() {
    super.initState();
    final kedai = widget.initialKedai;
    nameController = TextEditingController(text: kedai?.name ?? '');
    addressController = TextEditingController(text: kedai?.address ?? '');
    phoneController = TextEditingController(text: kedai?.phoneNumber ?? '');
    descriptionController = TextEditingController(text: kedai?.description ?? '');
    hoursController = TextEditingController(text: kedai?.operatingHours ?? '');
    selectedCategory = kedai?.categoryPrimary ?? 'Kopi';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialKedai == null ? 'Tambah Kedai' : 'Edit Kedai'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nama Kedai'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Alamat'),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Nomor Telepon'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField(
              value: selectedCategory,
              items: ['Kopi', 'Makanan', 'Minuman', 'Snack']
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Kategori'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: hoursController,
              decoration: const InputDecoration(labelText: 'Jam Operasional (misal: 08:00-22:00)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: _save,
          child: const Text('Simpan'),
        ),
      ],
    );
  }

  void _save() {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi nama kedai')),
      );
      return;
    }

    final kedai = KedaiManagement(
      id: widget.initialKedai?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameController.text,
      description: descriptionController.text,
      address: addressController.text,
      phoneNumber: phoneController.text,
      categoryPrimary: selectedCategory,
      operatingHours: hoursController.text,
      isActive: widget.initialKedai?.isActive ?? true,
      createdAt: widget.initialKedai?.createdAt ?? DateTime.now(),
      lastModified: DateTime.now(),
      createdByAdminId: widget.initialKedai?.createdByAdminId ?? 'ADMIN001',
      lastModifiedByAdminId: 'ADMIN001',
      status: widget.initialKedai?.status ?? 'active',
    );

    widget.onSave(kedai);
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    descriptionController.dispose();
    hoursController.dispose();
    super.dispose();
  }
}
