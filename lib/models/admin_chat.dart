/// Model untuk Chat dengan Admin
class AdminChatMessage {
  final String id;
  final String senderId;
  final String senderName;
  final String senderRole; // 'owner' atau 'admin'
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final String? attachmentUrl;
  final String? attachmentType; // 'image', 'document', null
  final String? replyToMessageId;
  final String? replyToContent;

  AdminChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderRole,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.attachmentUrl,
    this.attachmentType,
    this.replyToMessageId,
    this.replyToContent,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'senderRole': senderRole,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'attachmentUrl': attachmentUrl,
      'attachmentType': attachmentType,
      'replyToMessageId': replyToMessageId,
      'replyToContent': replyToContent,
    };
  }

  factory AdminChatMessage.fromJson(Map<String, dynamic> json) {
    return AdminChatMessage(
      id: json['id'] ?? '',
      senderId: json['senderId'] ?? '',
      senderName: json['senderName'] ?? '',
      senderRole: json['senderRole'] ?? 'owner',
      message: json['message'] ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      isRead: json['isRead'] ?? false,
      attachmentUrl: json['attachmentUrl'],
      attachmentType: json['attachmentType'],
      replyToMessageId: json['replyToMessageId'],
      replyToContent: json['replyToContent'],
    );
  }

  // Untuk menampilkan waktu dengan format yang lebih readable
  String get formattedTime {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inSeconds < 60) {
      return 'Baru saja';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}j lalu';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}h lalu';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}

/// Model untuk Conversation Chat dengan Admin
class AdminChatConversation {
  final String id;
  final String ownerId;
  final String ownerName;
  final String ownerBusinessName;
  final String adminId;
  final String adminName;
  final List<AdminChatMessage> messages;
  final DateTime createdAt;
  final DateTime lastMessageAt;
  final bool isActive;
  final int unreadCount;

  AdminChatConversation({
    required this.id,
    required this.ownerId,
    required this.ownerName,
    required this.ownerBusinessName,
    required this.adminId,
    required this.adminName,
    required this.messages,
    required this.createdAt,
    required this.lastMessageAt,
    this.isActive = true,
    this.unreadCount = 0,
  });

  // Get last message untuk preview
  String get lastMessagePreview {
    if (messages.isEmpty) return 'Belum ada pesan';
    return messages.last.message;
  }

  // Get total unread messages
  int get totalUnread {
    return messages.where((msg) => !msg.isRead && msg.senderRole == 'admin').length;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'ownerBusinessName': ownerBusinessName,
      'adminId': adminId,
      'adminName': adminName,
      'messages': messages.map((m) => m.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'lastMessageAt': lastMessageAt.toIso8601String(),
      'isActive': isActive,
      'unreadCount': unreadCount,
    };
  }

  factory AdminChatConversation.fromJson(Map<String, dynamic> json) {
    return AdminChatConversation(
      id: json['id'] ?? '',
      ownerId: json['ownerId'] ?? '',
      ownerName: json['ownerName'] ?? '',
      ownerBusinessName: json['ownerBusinessName'] ?? '',
      adminId: json['adminId'] ?? '',
      adminName: json['adminName'] ?? '',
      messages: (json['messages'] as List?)
              ?.map((m) => AdminChatMessage.fromJson(m))
              .toList() ??
          [],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      lastMessageAt: json['lastMessageAt'] != null
          ? DateTime.parse(json['lastMessageAt'])
          : DateTime.now(),
      isActive: json['isActive'] ?? true,
      unreadCount: json['unreadCount'] ?? 0,
    );
  }
}

/// Model untuk Support Ticket Category
class SupportCategory {
  final String id;
  final String name;
  final String description;
  final String icon;
  final int priority; // 1 = low, 2 = medium, 3 = high

  SupportCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    this.priority = 2,
  });

  static List<SupportCategory> defaultCategories = [
    SupportCategory(
      id: '1',
      name: 'Bantuan Teknis',
      description: 'Masalah dengan fitur atau sistem',
      icon: '🔧',
      priority: 2,
    ),
    SupportCategory(
      id: '2',
      name: 'Pertanyaan Umum',
      description: 'Pertanyaan tentang penggunaan platform',
      icon: '❓',
      priority: 1,
    ),
    SupportCategory(
      id: '3',
      name: 'Laporan Bug',
      description: 'Melaporkan bug atau error',
      icon: '🐛',
      priority: 3,
    ),
    SupportCategory(
      id: '4',
      name: 'Pengajuan Fitur',
      description: 'Mengajukan ide fitur baru',
      icon: '💡',
      priority: 1,
    ),
    SupportCategory(
      id: '5',
      name: 'Masalah Pembayaran',
      description: 'Masalah terkait pembayaran atau billing',
      icon: '💳',
      priority: 3,
    ),
    SupportCategory(
      id: '6',
      name: 'Lainnya',
      description: 'Kategori lainnya',
      icon: '📋',
      priority: 1,
    ),
  ];
}
