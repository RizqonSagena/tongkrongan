import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/models/admin.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class AdminSocialMediaScreen extends StatefulWidget {
  const AdminSocialMediaScreen({super.key});

  @override
  State<AdminSocialMediaScreen> createState() =>
      _AdminSocialMediaScreenState();
}

class _AdminSocialMediaScreenState extends State<AdminSocialMediaScreen> {
  late List<ContentUpload> socialMediaContent;
  late List<KedaiManagement> kedaiList;
  String selectedFilter = 'Semua'; // Semua, Terjadwal, Dipublikasi, Draft
  String? selectedKedaiId;
  String selectedView = 'calendar'; // calendar, list

  @override
  void initState() {
    super.initState();
    socialMediaContent = _generateMockSocialMediaContent();
    kedaiList = AdminMockData.generateMockKedaiManagement();
    if (kedaiList.isNotEmpty) {
      selectedKedaiId = kedaiList[0].id;
    }
  }

  List<ContentUpload> _generateMockSocialMediaContent() {
    return [
      ContentUpload(
        id: 'SOCIAL001',
        kedaiId: 'KEDAI001',
        contentType: 'photo',
        title: 'Promo Hari Ini',
        description: 'Foto promo spesial hari ini dengan diskon fantastis',
        fileUrl: 'https://example.com/social1.jpg',
        uploadedByAdminId: 'ADMIN001',
        uploadedAt: DateTime.now(),
        isPublished: true,
        orderIndex: 1,
      ),
      ContentUpload(
        id: 'SOCIAL002',
        kedaiId: 'KEDAI001',
        contentType: 'video',
        title: 'Tutorial Membuat Minuman',
        description: 'Video cara membuat minuman signature kami',
        fileUrl: 'https://example.com/social2.mp4',
        uploadedByAdminId: 'ADMIN001',
        uploadedAt: DateTime.now().subtract(Duration(days: 1)),
        isPublished: true,
        orderIndex: 2,
      ),
      ContentUpload(
        id: 'SOCIAL003',
        kedaiId: 'KEDAI002',
        contentType: 'photo',
        title: 'Menu Baru Minggu Depan',
        description: 'Sneak peek menu baru yang akan diluncurkan',
        fileUrl: 'https://example.com/social3.jpg',
        uploadedByAdminId: 'ADMIN001',
        uploadedAt: DateTime.now().subtract(Duration(days: 2)),
        isPublished: false,
        orderIndex: 3,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Kelola Social Media'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: PopupMenuButton<String>(
              onSelected: (value) {
                setState(() {
                  selectedView = value;
                });
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'calendar',
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 18),
                      const SizedBox(width: 12),
                      const Text('Kalender'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'list',
                  child: Row(
                    children: [
                      const Icon(Icons.list, size: 18),
                      const SizedBox(width: 12),
                      const Text('Daftar'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showSchedulePostDialog,
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

            // View Toggle
            if (selectedView == 'calendar')
              _buildCalendarView()
            else
              _buildListView(),

            const SizedBox(height: 24),

            // Info Banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.cyan.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info, color: Colors.cyan, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '📱 Upload konten untuk auto-posting di social media',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.cyan,
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
        children: ['Semua', 'Dipublikasi', 'Terjadwal', 'Draft']
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
    int totalContent = socialMediaContent.length;
    int publishedCount =
        socialMediaContent.where((c) => c.isPublished).length;
    int draftCount = socialMediaContent.where((c) => !c.isPublished).length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Total Konten',
            value: totalContent.toString(),
            icon: Icons.image,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Dipublikasi',
            value: publishedCount.toString(),
            icon: Icons.check_circle,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Draft',
            value: draftCount.toString(),
            icon: Icons.drafts,
            color: Colors.orange,
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

  Widget _buildCalendarView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kalender Posting',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            children: [
              // Calendar Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.chevron_left),
                  ),
                  Text(
                    'September 2026',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Calendar Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1.2,
                ),
                itemCount: 30,
                itemBuilder: (context, index) {
                  int day = index + 1;
                  bool hasContent = day % 3 == 0; // Mock: every 3rd day

                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            hasContent
                                ? '$day September: 2 posting terjadwal'
                                : 'Tidak ada posting',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: hasContent
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: hasContent
                              ? Colors.blue
                              : Colors.grey[300]!,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            day.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          if (hasContent)
                            Positioned(
                              bottom: 2,
                              child: Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListView() {
    List<ContentUpload> filteredContent = socialMediaContent.where((content) {
      if (selectedFilter == 'Dipublikasi') {
        return content.isPublished;
      } else if (selectedFilter == 'Draft') {
        return !content.isPublished;
      }
      return true;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jadwal Posting',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        if (filteredContent.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  Icon(Icons.image_not_supported,
                      size: 48, color: Colors.grey[300]),
                  const SizedBox(height: 12),
                  Text(
                    'Belum ada konten',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey[500],
                        ),
                  ),
                ],
              ),
            ),
          )
        else
          Column(
            children: filteredContent
                .map((content) => _buildSocialMediaCard(content))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildSocialMediaCard(ContentUpload content) {
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
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content.title,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      content.contentTypeDisplay,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey[600],
                          ),
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
                  color: content.isPublished
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  content.isPublished ? '✓ Live' : '📅 Terjadwal',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: content.isPublished
                            ? Colors.green
                            : Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Description
          Text(
            content.description,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey[700],
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),

          // Schedule Info
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.schedule, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  'Posting: ${content.uploadedAt.day}/${content.uploadedAt.month} ${content.uploadedAt.hour}:${content.uploadedAt.minute.toString().padLeft(2, '0')}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Social Media Platforms
          Row(
            children: [
              Chip(
                avatar: Icon(Icons.circle, size: 8, color: Colors.blue),
                label: const Text('Instagram'),
                onDeleted: () {},
              ),
              const SizedBox(width: 8),
              Chip(
                avatar: Icon(Icons.circle, size: 8, color: Colors.blue),
                label: const Text('Facebook'),
                onDeleted: () {},
              ),
              const SizedBox(width: 8),
              Chip(
                avatar: Icon(Icons.circle, size: 8, color: Colors.green),
                label: const Text('TikTok'),
                onDeleted: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showEditScheduleDialog(content),
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Edit'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      socialMediaContent.remove(content);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Posting dihapus')),
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

  void _showSchedulePostDialog() {
    String title = '';
    String description = '';
    String contentType = 'photo';
    DateTime postDate = DateTime.now().add(Duration(days: 1));

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Jadwalkan Posting Baru'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: contentType,
                  items: const [
                    DropdownMenuItem(value: 'photo', child: Text('📷 Foto')),
                    DropdownMenuItem(value: 'video', child: Text('🎥 Video')),
                  ],
                  onChanged: (value) {
                    setDialogState(() {
                      contentType = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Tipe Konten',
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
                    labelText: 'Keterangan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Platform Posting:',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    FilterChip(label: const Text('📱 Instagram'), onSelected: (_) {}),
                    FilterChip(label: const Text('👍 Facebook'), onSelected: (_) {}),
                    FilterChip(label: const Text('🎵 TikTok'), onSelected: (_) {}),
                  ],
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
                if (title.isNotEmpty && description.isNotEmpty) {
                  setState(() {
                    socialMediaContent.add(
                      ContentUpload(
                        id: 'SOCIAL${socialMediaContent.length + 1}',
                        kedaiId: selectedKedaiId!,
                        contentType: contentType,
                        title: title,
                        description: description,
                        fileUrl:
                            'https://example.com/social${socialMediaContent.length}.jpg',
                        uploadedByAdminId: 'ADMIN001',
                        uploadedAt: postDate,
                        isPublished: false,
                      ),
                    );
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Posting berhasil dijadwalkan')),
                  );
                }
              },
              child: const Text('Jadwalkan'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditScheduleDialog(ContentUpload content) {
    String title = content.title;
    String description = content.description;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Jadwal Posting'),
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
                  labelText: 'Keterangan',
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
                content.title = title;
                content.description = description;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Posting berhasil diperbarui')),
              );
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
