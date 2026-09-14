import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/models/admin.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class AdminContentScreen extends StatefulWidget {
  const AdminContentScreen({super.key});

  @override
  State<AdminContentScreen> createState() => _AdminContentScreenState();
}

class _AdminContentScreenState extends State<AdminContentScreen> {
  late List<ContentUpload> contentList;
  late List<KedaiManagement> kedaiList;
  String selectedFilter = 'Semua'; // Semua, Dipublikasi, Draft
  String? selectedKedaiId;

  @override
  void initState() {
    super.initState();
    contentList = AdminMockData.generateMockContent();
    kedaiList = AdminMockData.generateMockKedaiManagement();
    if (kedaiList.isNotEmpty) {
      selectedKedaiId = kedaiList[0].id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Kelola Konten Kedai'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddContentDialog,
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

            // Content List
            Text(
              'Daftar Konten',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _buildContentList(),

            const SizedBox(height: 24),

            // Info Banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info, color: Colors.green, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '📷 Konten yang dipublikasi akan terlihat di profil kedai untuk customer',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.green,
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
        children: ['Semua', 'Dipublikasi', 'Draft']
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
    int totalContent = contentList.length;
    int publishedCount =
        contentList.where((c) => c.isPublished).length;
    int draftCount = contentList.where((c) => !c.isPublished).length;

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

  Widget _buildContentList() {
    List<ContentUpload> filteredContent = contentList.where((content) {
      if (selectedFilter == 'Dipublikasi') {
        return content.isPublished;
      } else if (selectedFilter == 'Draft') {
        return !content.isPublished;
      }
      return true;
    }).toList();

    if (filteredContent.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              Icon(Icons.image_not_supported, size: 48, color: Colors.grey[300]),
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
      );
    }

    return Column(
      children: filteredContent
          .map((content) => _buildContentCard(content))
          .toList(),
    );
  }

  Widget _buildContentCard(ContentUpload content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          // Thumbnail
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Icon(
                content.contentType == 'photo'
                    ? Icons.image
                    : content.contentType == 'video'
                        ? Icons.videocam
                        : Icons.description,
                size: 48,
                color: Colors.grey[400],
              ),
            ),
          ),
          // Content Info
          Padding(
            padding: const EdgeInsets.all(12),
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
                          Text(
                            content.title,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                        content.isPublished ? '✓ Dipublikasi' : '📝 Draft',
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
                const SizedBox(height: 8),
                Text(
                  content.description,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey[700],
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Text(
                  'Diupload: ${content.uploadedAt.day}/${content.uploadedAt.month}/${content.uploadedAt.year}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey[500],
                        fontSize: 11,
                      ),
                ),
                const SizedBox(height: 12),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _showEditContentDialog(content),
                        icon: const Icon(Icons.edit, size: 16),
                        label: const Text('Edit'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            if (content.isPublished) {
                              content.unpublish();
                            } else {
                              content.publish();
                            }
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                content.isPublished
                                    ? 'Konten dipublikasi'
                                    : 'Konten disembunyikan',
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          content.isPublished
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 16,
                        ),
                        label: Text(
                          content.isPublished ? 'Sembunyikan' : 'Publikasi',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            contentList.remove(content);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Konten dihapus')),
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
          ),
        ],
      ),
    );
  }

  void _showAddContentDialog() {
    String contentType = 'photo';
    String title = '';
    String description = '';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Tambah Konten Baru'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: contentType,
                  items: const [
                    DropdownMenuItem(value: 'photo', child: Text('📷 Foto')),
                    DropdownMenuItem(value: 'video', child: Text('🎥 Video')),
                    DropdownMenuItem(
                        value: 'description', child: Text('📝 Deskripsi')),
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
                    labelText: 'Deskripsi',
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
                if (title.isNotEmpty && description.isNotEmpty) {
                  setState(() {
                    contentList.add(
                      ContentUpload(
                        id: 'CONTENT${contentList.length + 1}',
                        kedaiId: selectedKedaiId!,
                        contentType: contentType,
                        title: title,
                        description: description,
                        fileUrl:
                            'https://example.com/${contentType}${contentList.length}.jpg',
                        uploadedByAdminId: 'ADMIN001',
                        uploadedAt: DateTime.now(),
                        isPublished: false,
                      ),
                    );
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Konten berhasil ditambahkan')),
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

  void _showEditContentDialog(ContentUpload content) {
    String title = content.title;
    String description = content.description;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Konten'),
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
                const SnackBar(content: Text('Konten berhasil diperbarui')),
              );
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
