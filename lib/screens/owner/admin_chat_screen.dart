import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tongkrongan_umkm_owner_app/models/admin_chat.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/owner/bottom_navigation.dart';

class AdminChatScreen extends StatefulWidget {
  const AdminChatScreen({super.key});

  @override
  State<AdminChatScreen> createState() => _AdminChatScreenState();
}

class _AdminChatScreenState extends State<AdminChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  // Mock data untuk conversation
  late AdminChatConversation _conversation;

  @override
  void initState() {
    super.initState();
    _initializeMockData();
  }

  void _initializeMockData() {
    _conversation = AdminChatConversation(
      id: 'conv-1',
      ownerId: 'owner-123',
      ownerName: 'Budi Santoso',
      ownerBusinessName: 'Warung Nasi Kampung',
      adminId: 'admin-1',
      adminName: 'Admin Support',
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
        AdminChatMessage(
          id: 'msg-2',
          senderId: 'admin-1',
          senderName: 'Admin Support',
          senderRole: 'admin',
          message: 'Halo Budi, saya siap membantu. Ada yang bisa saya bantu dengan fitur HPP?',
          timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 1)),
          isRead: true,
        ),
        AdminChatMessage(
          id: 'msg-3',
          senderId: 'owner-123',
          senderName: 'Budi Santoso',
          senderRole: 'owner',
          message: 'Ya, saya ingin tahu bagaimana cara menginput HPP untuk setiap produk',
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
          isRead: true,
        ),
        AdminChatMessage(
          id: 'msg-4',
          senderId: 'admin-1',
          senderName: 'Admin Support',
          senderRole: 'admin',
          message: 'Tenang saja, di menu Kelola HPP Anda bisa menambah HPP baru dengan klik tombol tambah (+). Kemudian isi nama produk, HPP, dan harga jualnya. Apakah sudah jelas?',
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 50)),
          isRead: true,
        ),
        AdminChatMessage(
          id: 'msg-5',
          senderId: 'owner-123',
          senderName: 'Budi Santoso',
          senderRole: 'owner',
          message: 'Oh iya, sudah jelas. Terima kasih banyak ya!',
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
          isRead: true,
        ),
        AdminChatMessage(
          id: 'msg-6',
          senderId: 'admin-1',
          senderName: 'Admin Support',
          senderRole: 'admin',
          message: 'Sama-sama! Jika ada pertanyaan lagi, jangan ragu untuk menghubungi kami. Semoga sukses untuk bisnis Anda!',
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 40)),
          isRead: true,
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      lastMessageAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 40)),
      isActive: true,
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _conversation.messages.add(
        AdminChatMessage(
          id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
          senderId: 'owner-123',
          senderName: _conversation.ownerName,
          senderRole: 'owner',
          message: _messageController.text,
          timestamp: DateTime.now(),
          isRead: false,
        ),
      );
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate admin reply after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _conversation.messages.add(
            AdminChatMessage(
              id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
              senderId: 'admin-1',
              senderName: _conversation.adminName,
              senderRole: 'admin',
              message: 'Terima kasih telah menghubungi kami. Tim admin kami akan segera merespon pertanyaan Anda.',
              timestamp: DateTime.now(),
              isRead: false,
            ),
          );
        });
        _scrollToBottom();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chat dengan Admin',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: AppTheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _conversation.adminName,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              _showMoreOptions();
            },
            icon: const Icon(Icons.more_vert, color: AppTheme.onSurface),
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _conversation.messages.length,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              itemBuilder: (context, index) {
                final message = _conversation.messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // Input Area
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Show attachment options
                    },
                    icon: const Icon(Icons.attach_file, color: AppTheme.primary),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Tulis pesan...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Show emoji picker
                          },
                          icon: const Icon(Icons.emoji_emotions_outlined, color: AppTheme.primary),
                        ),
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: AppTheme.primary,
                    child: IconButton(
                      onPressed: _sendMessage,
                      icon: const Icon(Icons.send, color: Colors.white),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const OwnerBottomNavigation(currentRoute: '/admin-chat'),
    );
  }

  Widget _buildMessageBubble(AdminChatMessage message) {
    final isOwner = message.senderRole == 'owner';
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isOwner ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isOwner)
            CircleAvatar(
              backgroundColor: Colors.grey.shade400,
              child: Text(
                message.senderName[0].toUpperCase(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          if (!isOwner) const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: isOwner ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isOwner)
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 4),
                    child: Text(
                      message.senderName,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isOwner ? AppTheme.primary : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: isOwner ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.message,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: isOwner ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('HH:mm').format(message.timestamp),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: isOwner ? Colors.white70 : Colors.grey.shade600,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isOwner) const SizedBox(width: 8),
          if (isOwner)
            CircleAvatar(
              backgroundColor: AppTheme.primary,
              child: Text(
                'B',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.info, color: AppTheme.primary),
                title: const Text('Info Percakapan'),
                onTap: () {
                  Navigator.pop(context);
                  _showConversationInfo();
                },
              ),
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
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Hapus Percakapan'),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showConversationInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Info Percakapan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow('Dengan', _conversation.adminName),
              const SizedBox(height: 12),
              _buildInfoRow(
                'Dibuat',
                DateFormat('dd MMM yyyy HH:mm', 'id_ID').format(_conversation.createdAt),
              ),
              const SizedBox(height: 12),
              _buildInfoRow(
                'Pesan Terakhir',
                DateFormat('dd MMM yyyy HH:mm', 'id_ID').format(_conversation.lastMessageAt),
              ),
              const SizedBox(height: 12),
              _buildInfoRow('Total Pesan', '${_conversation.messages.length}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation() {
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
                Navigator.pop(context);
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
}
