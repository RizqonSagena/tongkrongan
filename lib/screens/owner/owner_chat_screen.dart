import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class OwnerChatScreen extends StatefulWidget {
  const OwnerChatScreen({super.key});

  @override
  State<OwnerChatScreen> createState() => _OwnerChatScreenState();
}

class _OwnerChatScreenState extends State<OwnerChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  late List<ChatMessage> messages;

  @override
  void initState() {
    super.initState();
    messages = _generateMockMessages();
  }

  List<ChatMessage> _generateMockMessages() {
    return [
      ChatMessage(
        id: '1',
        senderName: 'Anda',
        senderType: 'owner',
        message: 'Halo, saya ingin update tentang perubahan harga produk',
        timestamp: DateTime.now().subtract(Duration(minutes: 30)),
      ),
      ChatMessage(
        id: '2',
        senderName: 'Admin Tongkrongan',
        senderType: 'management',
        message: 'Baik, silakan jelaskan perubahan harganya',
        timestamp: DateTime.now().subtract(Duration(minutes: 28)),
      ),
      ChatMessage(
        id: '3',
        senderName: 'Anda',
        senderType: 'owner',
        message: 'Kopi Susu dari Rp15.000 menjadi Rp16.000 karena kenaikan harga bahan',
        timestamp: DateTime.now().subtract(Duration(minutes: 25)),
      ),
      ChatMessage(
        id: '4',
        senderName: 'Admin Tongkrongan',
        senderType: 'management',
        message: 'Oke, saya akan update di sistem. Ada perubahan lainnya?',
        timestamp: DateTime.now().subtract(Duration(minutes: 23)),
      ),
      ChatMessage(
        id: '5',
        senderName: 'Anda',
        senderType: 'owner',
        message: 'Juga, saya ingin menambahkan promo baru untuk bulan depan',
        timestamp: DateTime.now().subtract(Duration(minutes: 20)),
      ),
      ChatMessage(
        id: '6',
        senderName: 'Admin Tongkrongan',
        senderType: 'management',
        message: 'Baik! Silakan kirimkan detail promosi dan jadwalnya 😊',
        timestamp: DateTime.now().subtract(Duration(minutes: 18)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Chat dengan Pengelola'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Info Banner
          _buildInfoBanner(),

          // Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) => _buildMessageBubble(messages[index]),
            ),
          ),

          // Input Field
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.info, color: Colors.blue, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Ini adalah komunikasi dengan Pengelola Aplikasi Tongkrongan. Untuk masalah teknis atau informasi penting, hubungi pengelola melalui chat ini.',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isOwner = message.senderType == 'owner';

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Align(
        alignment: isOwner ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isOwner ? AppTheme.primary : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment:
                isOwner ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isOwner)
                Text(
                  message.senderName,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 4),
              Text(
                message.message,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: isOwner ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _formatTime(message.timestamp),
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: isOwner ? Colors.white70 : Colors.grey.shade600,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Tulis pesan...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                suffixIcon: IconButton(
                  onPressed: () {
                    // Attachment action
                  },
                  icon: Icon(Icons.attachment, color: Colors.grey.shade600),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            onPressed: _sendMessage,
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.isEmpty) return;

    setState(() {
      messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderName: 'Anda',
          senderType: 'owner',
          message: _messageController.text,
          timestamp: DateTime.now(),
        ),
      );
      _messageController.clear();
    });

    // Simulate auto-reply after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        messages.add(
          ChatMessage(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            senderName: 'Admin Tongkrongan',
            senderType: 'management',
            message: 'Terima kasih, pesan Anda sudah kami terima. Tim kami akan segera memproses.',
            timestamp: DateTime.now(),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String id;
  final String senderName;
  final String senderType; // 'owner' or 'management'
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.senderName,
    required this.senderType,
    required this.message,
    required this.timestamp,
  });
}
