import 'package:flutter/material.dart';

/// ============================================================================
/// ADMIN MODELS - Data models untuk Admin/Operator role
/// ============================================================================
/// PENTING: Admin adalah OPERATOR INPUT, BUKAN DECISION MAKER
/// ❌ TIDAK ADA AKSES KE: Finansial, Omzet, Profit, HPP, atau Business Data
/// ✅ HANYA DAPAT: Input/Edit/Manage Kedai, Produk, Konten, Promo, Appointment
/// 
/// Total: 7 model classes
/// - Admin: Profile & credentials
/// - KedaiManagement: Kedai data (bukan finansial)
/// - ProductManagement: Produk (bukan harga/margin)
/// - ContentUpload: Foto/Video untuk customer view
/// - PromoEvent: Promo dan Event input
/// - Appointment: Janji temu customer
/// - ChatTicket: Tiket chat/support (management jalur)

/// ============================================================================
/// 1. ADMIN MODEL
/// ============================================================================
/// Admin adalah karyawan/operator dengan akses terbatas
class Admin {
  String id;
  String name;
  String email;
  String phoneNumber;
  String role; // 'super-admin', 'content-admin', 'support-admin'
  String status; // active, inactive, suspended
  List<String> permissions; // ['kedai-manage', 'produk-manage', 'content-upload', etc]
  DateTime createdAt;
  DateTime lastLogin;
  String profileImage;

  Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.status,
    required this.permissions,
    required this.createdAt,
    required this.lastLogin,
    this.profileImage = '',
  });

  /// Check if admin memiliki permission tertentu
  bool hasPermission(String permission) {
    return permissions.contains(permission);
  }

  /// Get role display name
  String get roleDisplayName {
    switch (role) {
      case 'super-admin':
        return 'Super Admin';
      case 'content-admin':
        return 'Admin Konten';
      case 'support-admin':
        return 'Admin Support';
      default:
        return 'Admin';
    }
  }
}

/// ============================================================================
/// 2. KEDAI MANAGEMENT MODEL
/// ============================================================================
/// Managemen data kedai - BUKAN finansial
class KedaiManagement {
  String id;
  String name;
  String description;
  String address;
  String phoneNumber;
  String categoryPrimary; // Kopi, Makanan, Minuman, dll
  List<String> categoriesSecondary;
  String operatingHours; // "08:00-22:00"
  bool isActive;
  DateTime createdAt;
  DateTime lastModified;
  String createdByAdminId;
  String lastModifiedByAdminId;
  String status; // active, inactive, suspended, closed

  KedaiManagement({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.phoneNumber,
    required this.categoryPrimary,
    this.categoriesSecondary = const [],
    required this.operatingHours,
    required this.isActive,
    required this.createdAt,
    required this.lastModified,
    required this.createdByAdminId,
    required this.lastModifiedByAdminId,
    this.status = 'active',
  });

  /// Nonaktifkan kedai (jangan hapus)
  void deactivate(String adminId) {
    isActive = false;
    status = 'inactive';
    lastModified = DateTime.now();
    lastModifiedByAdminId = adminId;
  }

  /// Aktifkan kembali kedai
  void activate(String adminId) {
    isActive = true;
    status = 'active';
    lastModified = DateTime.now();
    lastModifiedByAdminId = adminId;
  }
}

/// ============================================================================
/// 3. PRODUCT MANAGEMENT MODEL
/// ============================================================================
/// Managemen produk - BUKAN harga/margin (itu hak Owner)
class ProductManagement {
  String id;
  String kedaiId;
  String name;
  String description;
  String category; // Makanan, Minuman, Snack
  bool isAvailable;
  int estimatedPrepTimeMinutes;
  DateTime createdAt;
  DateTime lastModified;
  String createdByAdminId;
  String lastModifiedByAdminId;

  ProductManagement({
    required this.id,
    required this.kedaiId,
    required this.name,
    required this.description,
    required this.category,
    required this.isAvailable,
    required this.estimatedPrepTimeMinutes,
    required this.createdAt,
    required this.lastModified,
    required this.createdByAdminId,
    required this.lastModifiedByAdminId,
  });

  /// Nonaktifkan produk (jangan hapus)
  void deactivate(String adminId) {
    isAvailable = false;
    lastModified = DateTime.now();
    lastModifiedByAdminId = adminId;
  }

  /// Aktifkan produk
  void activate(String adminId) {
    isAvailable = true;
    lastModified = DateTime.now();
    lastModifiedByAdminId = adminId;
  }
}

/// ============================================================================
/// 4. CONTENT UPLOAD MODEL
/// ============================================================================
/// Konten kedai untuk ditampilkan ke customer (foto, video, deskripsi)
class ContentUpload {
  String id;
  String kedaiId;
  String contentType; // 'photo', 'video', 'description'
  String title;
  String description;
  String fileUrl;
  String thumbnailUrl;
  String uploadedByAdminId;
  DateTime uploadedAt;
  bool isPublished;
  int orderIndex; // Urutan tampilan

  ContentUpload({
    required this.id,
    required this.kedaiId,
    required this.contentType,
    required this.title,
    required this.description,
    required this.fileUrl,
    this.thumbnailUrl = '',
    required this.uploadedByAdminId,
    required this.uploadedAt,
    this.isPublished = true,
    this.orderIndex = 0,
  });

  /// Publish konten (visible to customer)
  void publish() {
    isPublished = true;
  }

  /// Unpublish konten (hidden from customer)
  void unpublish() {
    isPublished = false;
  }

  /// Get content type display
  String get contentTypeDisplay {
    switch (contentType) {
      case 'photo':
        return '📷 Foto';
      case 'video':
        return '🎥 Video';
      case 'description':
        return '📝 Deskripsi';
      default:
        return contentType;
    }
  }
}

/// ============================================================================
/// 5. PROMO EVENT MODEL
/// ============================================================================
/// Promo dan Event - diinput admin berdasarkan request management/owner
class PromoEvent {
  String id;
  String kedaiId;
  String type; // 'promo', 'event'
  String title;
  String description;
  String imageUrl;
  DateTime startDate;
  DateTime endDate;
  String? couponCode;
  double? discountPercentage;
  String? eventType; // untuk event: 'special', 'seasonal', 'promotion'
  String status; // active, upcoming, expired, draft
  String createdByAdminId;
  DateTime createdAt;

  PromoEvent({
    required this.id,
    required this.kedaiId,
    required this.type,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    this.couponCode,
    this.discountPercentage,
    this.eventType,
    this.status = 'draft',
    required this.createdByAdminId,
    required this.createdAt,
  });

  /// Publish promo/event
  void publish() {
    status = 'active';
  }

  /// Archive promo/event
  void archive() {
    status = 'expired';
  }

  /// Check if promo/event masih aktif
  bool get isActive {
    return status == 'active' &&
        DateTime.now().isAfter(startDate) &&
        DateTime.now().isBefore(endDate);
  }
}

/// ============================================================================
/// 6. APPOINTMENT MODEL
/// ============================================================================
/// Janji temu / reservasi customer yang dikelola admin
class Appointment {
  String id;
  String customerId;
  String customerName;
  String customerPhone;
  String kedaiId;
  DateTime appointmentDate;
  String appointmentTime;
  int numberOfPeople;
  String purpose;
  String? notes;
  String status; // pending, confirmed, rejected, completed, cancelled
  String? assignedAdminId;
  DateTime createdAt;
  DateTime? respondedAt;

  Appointment({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
    required this.kedaiId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.numberOfPeople,
    required this.purpose,
    this.notes,
    this.status = 'pending',
    this.assignedAdminId,
    required this.createdAt,
    this.respondedAt,
  });

  /// Admin confirm appointment
  void confirm(String adminId) {
    status = 'confirmed';
    assignedAdminId = adminId;
    respondedAt = DateTime.now();
  }

  /// Admin reject appointment
  void reject(String adminId) {
    status = 'rejected';
    assignedAdminId = adminId;
    respondedAt = DateTime.now();
  }

  /// Mark as completed
  void complete() {
    status = 'completed';
  }

  /// Cancel appointment
  void cancel() {
    status = 'cancelled';
  }

  /// Format untuk display
  String get formattedDateTime =>
      '${appointmentDate.day}/${appointmentDate.month}/${appointmentDate.year} - $appointmentTime';

  /// Get status display
  String get statusDisplay {
    switch (status) {
      case 'pending':
        return '⏳ Menunggu';
      case 'confirmed':
        return '✓ Terkonfirmasi';
      case 'rejected':
        return '✗ Ditolak';
      case 'completed':
        return '✓✓ Selesai';
      case 'cancelled':
        return '🚫 Dibatalkan';
      default:
        return status;
    }
  }
}

/// ============================================================================
/// 7. CHAT TICKET MODEL
/// ============================================================================
/// Chat/Ticket support - admin adalah bagian dari jalur management
class ChatTicket {
  String id;
  String customerId;
  String customerName;
  String? kedaiId;
  String subject;
  String description;
  List<ChatMessage> messages;
  String status; // open, pending, resolved, closed
  String? assignedAdminId;
  int priorityLevel; // 1=low, 2=medium, 3=high, 4=urgent
  DateTime createdAt;
  DateTime? resolvedAt;

  ChatTicket({
    required this.id,
    required this.customerId,
    required this.customerName,
    this.kedaiId,
    required this.subject,
    required this.description,
    required this.messages,
    this.status = 'open',
    this.assignedAdminId,
    this.priorityLevel = 2,
    required this.createdAt,
    this.resolvedAt,
  });

  /// Assign ke admin
  void assign(String adminId) {
    assignedAdminId = adminId;
    status = 'pending';
  }

  /// Mark as resolved
  void resolve() {
    status = 'resolved';
    resolvedAt = DateTime.now();
  }

  /// Close ticket
  void close() {
    status = 'closed';
  }

  /// Add message
  void addMessage(ChatMessage message) {
    messages.add(message);
  }

  /// Get priority display
  String get priorityDisplay {
    switch (priorityLevel) {
      case 1:
        return '🟢 Rendah';
      case 2:
        return '🟡 Sedang';
      case 3:
        return '🟠 Tinggi';
      case 4:
        return '🔴 Sangat Urgent';
      default:
        return 'Unknown';
    }
  }

  /// Get status color
  Color get statusColor {
    switch (status) {
      case 'open':
        return Colors.blue;
      case 'pending':
        return Colors.orange;
      case 'resolved':
        return Colors.green;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}

/// Chat message dalam ticket
class ChatMessage {
  String id;
  String senderType; // 'customer', 'admin', 'management'
  String senderName;
  String message;
  DateTime timestamp;
  bool isRead;

  ChatMessage({
    required this.id,
    required this.senderType,
    required this.senderName,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });
}

/// ============================================================================
/// HELPER: Mock Data Generator untuk testing
/// ============================================================================
class AdminMockData {
  /// Generate mock admin
  static Admin generateMockAdmin() {
    return Admin(
      id: 'ADMIN001',
      name: 'Budi Santoso',
      email: 'budi.santoso@tongkrongan.com',
      phoneNumber: '+62 812-3456-7890',
      role: 'content-admin',
      status: 'active',
      permissions: [
        'kedai-manage',
        'product-manage',
        'content-upload',
        'promo-manage',
        'appointment-manage',
        'chat-support',
      ],
      createdAt: DateTime.now().subtract(Duration(days: 90)),
      lastLogin: DateTime.now().subtract(Duration(hours: 2)),
    );
  }

  /// Generate mock kedai management
  static List<KedaiManagement> generateMockKedaiManagement() {
    return [
      KedaiManagement(
        id: 'KEDAI001',
        name: 'Kopi Rumah Nenek',
        description: 'Kopi tradisional dengan suasana homey',
        address: 'Jl. Diponegoro No. 45, Jakarta Selatan',
        phoneNumber: '021-1234567',
        categoryPrimary: 'Kopi',
        categoriesSecondary: ['Makanan', 'Snack'],
        operatingHours: '08:00-22:00',
        isActive: true,
        createdAt: DateTime.now().subtract(Duration(days: 180)),
        lastModified: DateTime.now().subtract(Duration(days: 5)),
        createdByAdminId: 'ADMIN001',
        lastModifiedByAdminId: 'ADMIN001',
        status: 'active',
      ),
      KedaiManagement(
        id: 'KEDAI002',
        name: 'Warung Mak Ijah',
        description: 'Warung makanan lokal favorit',
        address: 'Jl. Sudirman Km 5, Jakarta Pusat',
        phoneNumber: '021-9876543',
        categoryPrimary: 'Makanan',
        categoriesSecondary: ['Minuman'],
        operatingHours: '10:00-21:00',
        isActive: true,
        createdAt: DateTime.now().subtract(Duration(days: 120)),
        lastModified: DateTime.now(),
        createdByAdminId: 'ADMIN001',
        lastModifiedByAdminId: 'ADMIN001',
        status: 'active',
      ),
      KedaiManagement(
        id: 'KEDAI003',
        name: 'Juice Bar Fresh',
        description: 'Juice segar dan smoothie bowl',
        address: 'Jl. Gatot Subroto No. 12, Jakarta Barat',
        phoneNumber: '021-5555555',
        categoryPrimary: 'Minuman',
        categoriesSecondary: ['Makanan Sehat'],
        operatingHours: '07:00-20:00',
        isActive: false,
        createdAt: DateTime.now().subtract(Duration(days: 150)),
        lastModified: DateTime.now().subtract(Duration(days: 30)),
        createdByAdminId: 'ADMIN001',
        lastModifiedByAdminId: 'ADMIN001',
        status: 'inactive',
      ),
    ];
  }

  /// Generate mock product management
  static List<ProductManagement> generateMockProducts() {
    return [
      ProductManagement(
        id: 'PROD001',
        kedaiId: 'KEDAI001',
        name: 'Kopi Susu Premium',
        description: 'Kopi arabika pilihan dengan susu fresh',
        category: 'Minuman',
        isAvailable: true,
        estimatedPrepTimeMinutes: 5,
        createdAt: DateTime.now().subtract(Duration(days: 60)),
        lastModified: DateTime.now(),
        createdByAdminId: 'ADMIN001',
        lastModifiedByAdminId: 'ADMIN001',
      ),
      ProductManagement(
        id: 'PROD002',
        kedaiId: 'KEDAI001',
        name: 'Croissant Cokelat',
        description: 'Pastry mentega dengan cokelat premium',
        category: 'Makanan',
        isAvailable: true,
        estimatedPrepTimeMinutes: 2,
        createdAt: DateTime.now().subtract(Duration(days: 45)),
        lastModified: DateTime.now(),
        createdByAdminId: 'ADMIN001',
        lastModifiedByAdminId: 'ADMIN001',
      ),
    ];
  }

  /// Generate mock content
  static List<ContentUpload> generateMockContent() {
    return [
      ContentUpload(
        id: 'CONTENT001',
        kedaiId: 'KEDAI001',
        contentType: 'photo',
        title: 'Suasana Kedai',
        description: 'Foto interior kedai yang nyaman dan modern',
        fileUrl: 'https://example.com/photo1.jpg',
        thumbnailUrl: 'https://example.com/photo1_thumb.jpg',
        uploadedByAdminId: 'ADMIN001',
        uploadedAt: DateTime.now().subtract(Duration(days: 7)),
        isPublished: true,
        orderIndex: 1,
      ),
      ContentUpload(
        id: 'CONTENT002',
        kedaiId: 'KEDAI001',
        contentType: 'video',
        title: 'Proses Membuat Kopi',
        description: 'Video cara membuat kopi special kami',
        fileUrl: 'https://example.com/video1.mp4',
        uploadedByAdminId: 'ADMIN001',
        uploadedAt: DateTime.now().subtract(Duration(days: 14)),
        isPublished: true,
        orderIndex: 2,
      ),
    ];
  }

  /// Generate mock appointments
  static List<Appointment> generateMockAppointments() {
    return [
      Appointment(
        id: 'APT001',
        customerId: 'CUST001',
        customerName: 'Ahmad Rizki',
        customerPhone: '+62 812-111-2222',
        kedaiId: 'KEDAI001',
        appointmentDate: DateTime.now().add(Duration(days: 3)),
        appointmentTime: '14:00',
        numberOfPeople: 5,
        purpose: 'Meeting kantor',
        notes: 'Tempat sudut dekat jendela, jika possible',
        status: 'pending',
        createdAt: DateTime.now().subtract(Duration(hours: 2)),
      ),
      Appointment(
        id: 'APT002',
        customerId: 'CUST002',
        customerName: 'Siti Nurhaliza',
        customerPhone: '+62 812-333-4444',
        kedaiId: 'KEDAI001',
        appointmentDate: DateTime.now().add(Duration(days: 5)),
        appointmentTime: '16:00',
        numberOfPeople: 3,
        purpose: 'Kumpul teman',
        status: 'confirmed',
        assignedAdminId: 'ADMIN001',
        respondedAt: DateTime.now().subtract(Duration(hours: 1)),
        createdAt: DateTime.now().subtract(Duration(days: 1)),
      ),
    ];
  }

  /// Generate mock chat tickets
  static List<ChatTicket> generateMockChatTickets() {
    return [
      ChatTicket(
        id: 'TICKET001',
        customerId: 'CUST001',
        customerName: 'Ahmad Rizki',
        kedaiId: 'KEDAI001',
        subject: 'Pertanyaan tentang menu baru',
        description: 'Saya ingin tahu apakah ada menu vegan?',
        messages: [
          ChatMessage(
            id: 'MSG001',
            senderType: 'customer',
            senderName: 'Ahmad Rizki',
            message: 'Halo, ada menu vegan kah?',
            timestamp: DateTime.now().subtract(Duration(hours: 3)),
          ),
          ChatMessage(
            id: 'MSG002',
            senderType: 'admin',
            senderName: 'Admin Tongkrongan',
            message: 'Halo Ahmad, kami sedang develop menu vegan. Akan launch bulan depan!',
            timestamp: DateTime.now().subtract(Duration(hours: 2)),
            isRead: true,
          ),
        ],
        status: 'resolved',
        assignedAdminId: 'ADMIN001',
        priorityLevel: 2,
        createdAt: DateTime.now().subtract(Duration(days: 2)),
        resolvedAt: DateTime.now().subtract(Duration(hours: 2)),
      ),
      ChatTicket(
        id: 'TICKET002',
        customerId: 'CUST003',
        customerName: 'Budi Hartono',
        kedaiId: 'KEDAI002',
        subject: 'Komplain kualitas makanan',
        description: 'Pesanan saya kemarin kurang higienis',
        messages: [
          ChatMessage(
            id: 'MSG003',
            senderType: 'customer',
            senderName: 'Budi Hartono',
            message: 'Saya komplain tentang kualitas makanan kemarin',
            timestamp: DateTime.now().subtract(Duration(hours: 1)),
          ),
        ],
        status: 'pending',
        assignedAdminId: 'ADMIN001',
        priorityLevel: 4,
        createdAt: DateTime.now().subtract(Duration(hours: 1)),
      ),
    ];
  }
}
