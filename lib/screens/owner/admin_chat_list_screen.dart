import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tongkrongan_umkm_owner_app/models/admin_chat.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/owner/bottom_navigation.dart';

class AdminChatListScreen extends StatefulWidget {
  const AdminChatListScreen({super.key});

  @override
  State<AdminChatListScreen> createState() => _AdminChatListScreenState();
}

class _AdminChatListScreenState extends State<AdminChatListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _filterStatus = 'all'; // all, active, archived
  bool _showArchived = false;

  // Mock data
  late List<AdminChatConversation> _conversations;

  @override
  void initState() {
    super.initState();
    _initializeMockData();
  }

  void _initializeMockData() {
    _conversations = [
      AdminChatConversation(
        id: 'conv-1',
        ownerId: 'owner-123',
        ownerName: 'Budi Santoso',
        ownerBusinessName: 'Warung Nasi Kampung',
        adminId: 'admin-1',
        adminName: 'Admin Support 1',
        messages: [
          AdminChatMessage(
            id: 'msg-1',
            senderId: 'owner-123',
            senderName: 'Budi Santoso',
            senderRole: 'owner',
            message: 'Halo, saya ingin bertanya tentang fitur HPP',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            isRead: true,
          ),
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        lastMessageAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 40)),
        isActive: true,
        unreadCount: 0,
      ),
      AdminChatConversation(
        id: 'conv-2',
        ownerId: 'owner-123',
        ownerName: 'Budi Santoso',
        ownerBusinessName: 'Warung Nasi Kampung',
        adminId: 'admin-2',
        adminName: 'Admin Support 2',
        messages: [
          AdminChatMessage(
            id: 'msg-2',
            senderId: 'admin-2',
            senderName: 'Admin Support 2',
            senderRole: 'admin',
            message: 'Berapa keuntungan Anda bulan ini?',
            timestamp: DateTime.now().subtract(const Duration(hours: 3)),
            isRead: false,
          ),
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        lastMessageAt: DateTime.now().subtract(const Duration(hours: 3)),
        isActive: true,
        unreadCount: 1,
      ),
      AdminChatConversation(
        id: 'conv-3',
        ownerId: 'owner-123',
        ownerName: 'Budi Santoso',
        ownerBusinessName: 'Warung Nasi Kampung',
        adminId: 'admin-3',
        adminName: 'Admin Support 3',
        messages: [
          AdminChatMessage(
            id: 'msg-3',
            senderId: 'owner-123',
            senderName: 'Budi Santoso',
            senderRole: 'owner',
            message: 'Terima kasih atas bantuannya',
            timestamp: DateTime.now().subtract(const Duration(days: 7)),
            isRead: true,
          ),
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        lastMessageAt: DateTime.now().subtract(const Duration(days: 7)),
        isActive: false,
        unreadCount: 0,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        title: Text(
          'Chat dengan Admin',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: AppTheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari percakapan...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),

          // Filter Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildFilterTab('Semua', 'all'),
                const SizedBox(width: 12),
                _buildFilterTab('Aktif', 'active'),
                const SizedBox(width: 12),
                _buildFilterTab('Arsip', 'archived'),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Conversations List
          Expanded(
            child: _conversations.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    itemCount: _conversations.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final conversation = _conversations[index];
                      return _buildConversationCard(conversation);
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const OwnerBottomNavigation(currentRoute: '/admin-chat-list'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primary,
        onPressed: _showStartChatDialog,
        child: const Icon(Icons.message, color: Colors.white),
      ),
    );
  }

  Widget _buildFilterTab(String label, String value) {
    final isSelected = _filterStatus == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _filterStatus = value;
        });
      },
      backgroundColor: Colors.white,
      selectedColor: AppTheme.primary.withOpacity(0.2),
      side: BorderSide(
        color: isSelected ? AppTheme.primary : Colors.grey.shade300,
      ),
    );
  }

  Widget _buildConversationCard(AdminChatConversation conversation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            context.go('/admin-chat');
          },
          onLongPress: () {
            _showConversationOptions(conversation);
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppTheme.primary.withOpacity(0.2),
                      child: Text(
                        conversation.adminName[0].toUpperCase(),
                        style: const TextStyle(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            conversation.adminName,
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            conversation.ownerBusinessName,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('dd MMM', 'id_ID').format(conversation.lastMessageAt),
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (conversation.unreadCount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${conversation.unreadCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Message Preview
                Text(
                  conversation.lastMessagePreview,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey.shade700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 8),

                // Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (!conversation.isActive)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Diarsipkan',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey.shade600,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    Text(
                      '${conversation.messages.length} pesan',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey.shade500,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak ada percakapan',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Mulai percakapan dengan admin untuk mendapatkan dukungan',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _showStartChatDialog,
            icon: const Icon(Icons.message),
            label: const Text('Mulai Percakapan'),
          ),
        ],
      ),
    );
  }

  void _showStartChatDialog() {
    final categoryController = TextEditingController();
    final messageController = TextEditingController();
    String? selectedCategory;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Hubungi Admin'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Pilih kategori masalah Anda:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    ...SupportCategory.defaultCategories.map(
                      (category) => RadioListTile<String>(
                        title: Text(category.name),
                        subtitle: Text(
                          category.description,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        value: category.id,
                        groupValue: selectedCategory,
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        labelText: 'Deskripsikan masalah Anda',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Jelaskan masalah atau pertanyaan Anda',
                      ),
                      maxLines: 4,
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
                    if (selectedCategory == null || messageController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Harap isi semua field'),
                        ),
                      );
                      return;
                    }

                    // Add new conversation logic
                    final newConversation = AdminChatConversation(
                      id: 'conv-${_conversations.length + 1}',
                      ownerId: 'owner-123',
                      ownerName: 'Budi Santoso',
                      ownerBusinessName: 'Warung Nasi Kampung',
                      adminId: 'admin-new',
                      adminName: 'Admin Support',
                      messages: [
                        AdminChatMessage(
                          id: 'msg-1',
                          senderId: 'owner-123',
                          senderName: 'Budi Santoso',
                          senderRole: 'owner',
                          message: messageController.text,
                          timestamp: DateTime.now(),
                          isRead: false,
                        ),
                      ],
                      createdAt: DateTime.now(),
                      lastMessageAt: DateTime.now(),
                      isActive: true,
                    );

                    setState(() {
                      _conversations.insert(0, newConversation);
                    });

                    Navigator.pop(context);
                    context.go('/admin-chat');

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Percakapan dimulai. Admin akan segera merespon.'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: const Text('Mulai Percakapan'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showConversationOptions(AdminChatConversation conversation) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.open_in_new, color: AppTheme.primary),
                title: const Text('Buka Percakapan'),
                onTap: () {
                  Navigator.pop(context);
                  context.go('/admin-chat');
                },
              ),
              if (conversation.isActive)
                ListTile(
                  leading: const Icon(Icons.archive, color: Colors.orange),
                  title: const Text('Arsipkan Percakapan'),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Percakapan diarsipkan')),
                    );
                  },
                ),
              if (!conversation.isActive)
                ListTile(
                  leading: const Icon(Icons.restore, color: Colors.green),
                  title: const Text('Restore Percakapan'),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Percakapan dikembalikan')),
                    );
                  },
                ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Hapus Percakapan'),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(conversation);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(AdminChatConversation conversation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Percakapan'),
          content: const Text('Apakah Anda yakin ingin menghapus percakapan ini? Tindakan ini tidak dapat dibatalkan.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _conversations.remove(conversation);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Percakapan berhasil dihapus'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
