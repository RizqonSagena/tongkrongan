import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tongkrongan_umkm_owner_app/models/customer.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/customer/customer_bottom_navigation.dart';

class ManagementChatScreen extends StatefulWidget {
  final String? kedaiId;

  const ManagementChatScreen({
    super.key,
    this.kedaiId,
  });

  @override
  State<ManagementChatScreen> createState() => _ManagementChatScreenState();
}

class _ManagementChatScreenState extends State<ManagementChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late ManagementChatConversation _conversation;

  @override
  void initState() {
    super.initState();
    _initializeMockData();
  }

  void _initializeMockData() {
    _conversation = ManagementChatConversation(
      id: 'conv-${widget.kedaiId ?? 'general'}',
      customerId: 'cust-123',
      customerName: 'Budi Santoso',
      kedaiId: widget.kedaiId,
      kedaiName: widget.kedaiId != null ? 'Nasi Kuning Pak Hendra' : null,
      messages: [
        ManagementChatMessage(
          id: 'msg-1',
          senderId: 'cust-123',
          senderName: 'Budi Santoso',
          senderRole: 'customer',
          kedaiId: widget.kedaiId,
          message: 'Halo, saya ingin tanya lokasi kedai Anda',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          isRead: true,
        ),
        ManagementChatMessage(
          id: 'msg-2',
          senderId: 'mgmt-1',
          senderName: 'Management Tongkrongan',
          senderRole: 'management',
          kedaiId: widget.kedaiId,
          message: 'Halo Budi! Lokasi kami di Jl. Raya Bogor No. 123, Jakarta. Sudah bisa terlihat di Google Maps. Ada yang bisa kami bantu?',
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
          isRead: true,
        ),
        ManagementChatMessage(
          id: 'msg-3',
          senderId: 'cust-123',
          senderName: 'Budi Santoso',
          senderRole: 'customer',
          kedaiId: widget.kedaiId,
          message: 'Apakah bisa booking untuk group 10 orang?',
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 50)),
          isRead: true,
        ),
        ManagementChatMessage(
          id: 'msg-4',
          senderId: 'mgmt-1',
          senderName: 'Management Tongkrongan',
          senderRole: 'management',
          kedaiId: widget.kedaiId,
          message: 'Tentu bisa! Untuk grup 10 orang kami bisa menyiapkan tempat khusus. Kapan rencananya?',
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
          isRead: true,
        ),
        ManagementChatMessage(
          id: 'msg-5',
          senderId: 'cust-123',
          senderName: 'Budi Santoso',
          senderRole: 'customer',
          kedaiId: widget.kedaiId,
          message: 'Rencananya minggu depan hari Sabtu jam 18:00. Berapa estimasi harganya?',
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 40)),
          isRead: true,
        ),
        ManagementChatMessage(
          id: 'msg-6',
          senderId: 'mgmt-1',
          senderName: 'Management Tongkrongan',
          senderRole: 'management',
          message: 'Untuk 10 orang dengan menu nasi kuning spesial, estimasi sekitar Rp250.000 per orang termasuk minuman. Bisa disesuaikan sesuai keinginan. Mau langsung booking atau ada pertanyaan lagi?',
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 35)),
          isRead: true,
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      lastMessageAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 35)),
      unreadCount: 0,
    );
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
        ManagementChatMessage(
          id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
          senderId: 'cust-123',
          senderName: _conversation.customerName,
          senderRole: 'customer',
          kedaiId: widget.kedaiId,
          message: _messageController.text,
          timestamp: DateTime.now(),
          isRead: false,
        ),
      );
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate management reply after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _conversation.messages.add(
            ManagementChatMessage(
              id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
              senderId: 'mgmt-1',
              senderName: 'Management Tongkrongan',
              senderRole: 'management',
              kedaiId: widget.kedaiId,
              message: 'Terima kasih atas pertanyaannya. Tim kami akan segera merespon dengan jawaban yang lebih detail.',
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
              'Chat dengan Pengelola',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: AppTheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            if (widget.kedaiId != null)
              Text(
                _conversation.kedaiName ?? 'Pertanyaan Umum',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              )
            else
              Text(
                'Pertanyaan Umum & Support',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
          ],
        ),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Info banner
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.blue.withOpacity(0.1),
            child: Row(
              children: [
                const Icon(Icons.info, color: Colors.blue, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Ini adalah chat dengan pengelola aplikasi Tongkrongan, bukan langsung dengan pemilik kedai.',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),

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
      bottomNavigationBar: const CustomerBottomNavigation(currentRoute: '/management-chat'),
    );
  }

  Widget _buildMessageBubble(ManagementChatMessage message) {
    final isCustomer = message.senderRole == 'customer';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isCustomer ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isCustomer)
            CircleAvatar(
              backgroundColor: Colors.grey.shade400,
              radius: 16,
              child: Text(
                message.senderName[0].toUpperCase(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          if (!isCustomer) const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: isCustomer ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isCustomer)
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
                    color: isCustomer ? AppTheme.primary : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: isCustomer ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.message,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: isCustomer ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('HH:mm').format(message.timestamp),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: isCustomer ? Colors.white70 : Colors.grey.shade600,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isCustomer) const SizedBox(width: 8),
          if (isCustomer)
            CircleAvatar(
              backgroundColor: AppTheme.primary,
              radius: 16,
              child: Text(
                'B',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
