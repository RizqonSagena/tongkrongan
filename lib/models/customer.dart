/// Model Customer untuk aplikasi Tongkrongan
/// Customer = pengguna yang mencari, melihat, menyimpan, memberi rating, dan menghubungi pengelola

import 'package:flutter/foundation.dart';

// ============================================================================
// CUSTOMER PROFILE & AUTHENTICATION
// ============================================================================

class Customer {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? profileImageUrl;
  final String? address;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;
  final DateTime lastLoginAt;
  final bool isVerified;
  final List<String> favoriteKedaiIds; // List ID kedai favorit

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profileImageUrl,
    this.address,
    this.latitude,
    this.longitude,
    required this.createdAt,
    required this.lastLoginAt,
    this.isVerified = false,
    this.favoriteKedaiIds = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt.toIso8601String(),
      'isVerified': isVerified,
      'favoriteKedaiIds': favoriteKedaiIds,
    };
  }

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      profileImageUrl: json['profileImageUrl'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      lastLoginAt: json['lastLoginAt'] != null ? DateTime.parse(json['lastLoginAt']) : DateTime.now(),
      isVerified: json['isVerified'] ?? false,
      favoriteKedaiIds: List<String>.from(json['favoriteKedaiIds'] ?? []),
    );
  }
}

// ============================================================================
// KEDAI (Warung/Toko Makanan)
// ============================================================================

class Kedai {
  final String id;
  final String name;
  final String description;
  final String category; // Nasi Kuning, Kopi, Bakso, dll
  final String imageUrl;
  final List<String>? additionalImageUrls;
  final String address;
  final double latitude;
  final double longitude;
  final String phoneNumber;
  final String? whatsappNumber;
  final double rating; // Rata-rata rating (0-5)
  final int totalRatings;
  final bool isOpen; // Status buka/tutup hari ini
  final String? openingHours; // Contoh: "08:00 - 22:00"
  final double? distanceFromCustomer; // Jarak dalam km
  final DateTime createdAt;
  final List<String> ownerIds; // ID owner yang mengelola kedai ini

  Kedai({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    this.additionalImageUrls,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber,
    this.whatsappNumber,
    this.rating = 0.0,
    this.totalRatings = 0,
    this.isOpen = true,
    this.openingHours,
    this.distanceFromCustomer,
    required this.createdAt,
    this.ownerIds = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
      'additionalImageUrls': additionalImageUrls,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'phoneNumber': phoneNumber,
      'whatsappNumber': whatsappNumber,
      'rating': rating,
      'totalRatings': totalRatings,
      'isOpen': isOpen,
      'openingHours': openingHours,
      'distanceFromCustomer': distanceFromCustomer,
      'createdAt': createdAt.toIso8601String(),
      'ownerIds': ownerIds,
    };
  }

  factory Kedai.fromJson(Map<String, dynamic> json) {
    return Kedai(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      additionalImageUrls: List<String>.from(json['additionalImageUrls'] ?? []),
      address: json['address'] ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      phoneNumber: json['phoneNumber'] ?? '',
      whatsappNumber: json['whatsappNumber'],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalRatings: json['totalRatings'] ?? 0,
      isOpen: json['isOpen'] ?? true,
      openingHours: json['openingHours'],
      distanceFromCustomer: (json['distanceFromCustomer'] as num?)?.toDouble(),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      ownerIds: List<String>.from(json['ownerIds'] ?? []),
    );
  }
}

// ============================================================================
// MENU & ITEM MAKANAN/MINUMAN
// ============================================================================

enum MenuCategory { makanan, minuman, snack, dessert, lainnya }

class MenuItem {
  final String id;
  final String kedaiId;
  final String name;
  final String description;
  final double price;
  final MenuCategory category;
  final String? imageUrl;
  final bool isAvailable;
  final int? estimatedPreparationTime; // dalam menit
  final double? rating;

  MenuItem({
    required this.id,
    required this.kedaiId,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.imageUrl,
    this.isAvailable = true,
    this.estimatedPreparationTime,
    this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kedaiId': kedaiId,
      'name': name,
      'description': description,
      'price': price,
      'category': category.toString(),
      'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      'estimatedPreparationTime': estimatedPreparationTime,
      'rating': rating,
    };
  }

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] ?? '',
      kedaiId: json['kedaiId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      category: MenuCategory.values.firstWhere(
        (e) => e.toString() == json['category'],
        orElse: () => MenuCategory.lainnya,
      ),
      imageUrl: json['imageUrl'],
      isAvailable: json['isAvailable'] ?? true,
      estimatedPreparationTime: json['estimatedPreparationTime'],
      rating: (json['rating'] as num?)?.toDouble(),
    );
  }
}

// ============================================================================
// RATING & REVIEW
// ============================================================================

class KedaiRating {
  final String id;
  final String kedaiId;
  final String customerId;
  final String customerName;
  final double rating; // 1-5 bintang
  final String? review; // Optional, tidak wajib
  final DateTime createdAt;
  final int helpfulCount; // Berapa banyak yang bilang helpful

  KedaiRating({
    required this.id,
    required this.kedaiId,
    required this.customerId,
    required this.customerName,
    required this.rating,
    this.review,
    required this.createdAt,
    this.helpfulCount = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kedaiId': kedaiId,
      'customerId': customerId,
      'customerName': customerName,
      'rating': rating,
      'review': review,
      'createdAt': createdAt.toIso8601String(),
      'helpfulCount': helpfulCount,
    };
  }

  factory KedaiRating.fromJson(Map<String, dynamic> json) {
    return KedaiRating(
      id: json['id'] ?? '',
      kedaiId: json['kedaiId'] ?? '',
      customerId: json['customerId'] ?? '',
      customerName: json['customerName'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      review: json['review'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      helpfulCount: json['helpfulCount'] ?? 0,
    );
  }
}

// ============================================================================
// PROMO
// ============================================================================

class Promo {
  final String id;
  final String kedaiId;
  final String title;
  final String description;
  final String? itemName; // Item yang di-promo
  final double? originalPrice;
  final double discountedPrice;
  final int discountPercentage; // Contoh: 20 untuk 20%
  final DateTime startDate;
  final DateTime endDate;
  final String? imageUrl;
  final bool isActive;

  Promo({
    required this.id,
    required this.kedaiId,
    required this.title,
    required this.description,
    this.itemName,
    this.originalPrice,
    required this.discountedPrice,
    required this.discountPercentage,
    required this.startDate,
    required this.endDate,
    this.imageUrl,
    this.isActive = true,
  });

  bool get isExpired => DateTime.now().isAfter(endDate);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kedaiId': kedaiId,
      'title': title,
      'description': description,
      'itemName': itemName,
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
      'discountPercentage': discountPercentage,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'imageUrl': imageUrl,
      'isActive': isActive,
    };
  }

  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
      id: json['id'] ?? '',
      kedaiId: json['kedaiId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      itemName: json['itemName'],
      originalPrice: (json['originalPrice'] as num?)?.toDouble(),
      discountedPrice: (json['discountedPrice'] as num?)?.toDouble() ?? 0.0,
      discountPercentage: json['discountPercentage'] ?? 0,
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : DateTime.now(),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : DateTime.now(),
      imageUrl: json['imageUrl'],
      isActive: json['isActive'] ?? true,
    );
  }
}

// ============================================================================
// EVENT
// ============================================================================

class KedaiEvent {
  final String id;
  final String kedaiId;
  final String title;
  final String description;
  final DateTime eventDate;
  final String? startTime; // Format HH:mm
  final String? endTime; // Format HH:mm
  final String? imageUrl;
  final String? location; // Lokasi dalam kedai atau di sekitar
  final bool isActive;

  KedaiEvent({
    required this.id,
    required this.kedaiId,
    required this.title,
    required this.description,
    required this.eventDate,
    this.startTime,
    this.endTime,
    this.imageUrl,
    this.location,
    this.isActive = true,
  });

  bool get isUpcoming => eventDate.isAfter(DateTime.now());

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kedaiId': kedaiId,
      'title': title,
      'description': description,
      'eventDate': eventDate.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'imageUrl': imageUrl,
      'location': location,
      'isActive': isActive,
    };
  }

  factory KedaiEvent.fromJson(Map<String, dynamic> json) {
    return KedaiEvent(
      id: json['id'] ?? '',
      kedaiId: json['kedaiId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      eventDate: json['eventDate'] != null ? DateTime.parse(json['eventDate']) : DateTime.now(),
      startTime: json['startTime'],
      endTime: json['endTime'],
      imageUrl: json['imageUrl'],
      location: json['location'],
      isActive: json['isActive'] ?? true,
    );
  }
}

// ============================================================================
// CHAT DENGAN PENGELOLA (BUKAN OWNER)
// ============================================================================

class ManagementChatMessage {
  final String id;
  final String senderId; // Customer ID atau Management ID
  final String senderName;
  final String senderRole; // 'customer' atau 'management'
  final String? kedaiId; // Kedai yang ditanya (optional)
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final String? attachmentUrl;
  final String? attachmentType; // 'image', 'document'

  ManagementChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderRole,
    this.kedaiId,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.attachmentUrl,
    this.attachmentType,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'senderRole': senderRole,
      'kedaiId': kedaiId,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'attachmentUrl': attachmentUrl,
      'attachmentType': attachmentType,
    };
  }

  factory ManagementChatMessage.fromJson(Map<String, dynamic> json) {
    return ManagementChatMessage(
      id: json['id'] ?? '',
      senderId: json['senderId'] ?? '',
      senderName: json['senderName'] ?? '',
      senderRole: json['senderRole'] ?? 'customer',
      kedaiId: json['kedaiId'],
      message: json['message'] ?? '',
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : DateTime.now(),
      isRead: json['isRead'] ?? false,
      attachmentUrl: json['attachmentUrl'],
      attachmentType: json['attachmentType'],
    );
  }

  String get formattedTime {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inSeconds < 60) {
      return 'Baru saja';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}j';
    } else {
      return '${timestamp.day}/${timestamp.month}';
    }
  }
}

class ManagementChatConversation {
  final String id;
  final String customerId;
  final String customerName;
  final String? kedaiId; // Kedai yang ditanyakan (opsional)
  final String? kedaiName;
  final List<ManagementChatMessage> messages;
  final DateTime createdAt;
  final DateTime lastMessageAt;
  final int unreadCount;

  ManagementChatConversation({
    required this.id,
    required this.customerId,
    required this.customerName,
    this.kedaiId,
    this.kedaiName,
    required this.messages,
    required this.createdAt,
    required this.lastMessageAt,
    this.unreadCount = 0,
  });

  String get lastMessagePreview {
    if (messages.isEmpty) return 'Belum ada pesan';
    return messages.last.message;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'kedaiId': kedaiId,
      'kedaiName': kedaiName,
      'messages': messages.map((m) => m.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'lastMessageAt': lastMessageAt.toIso8601String(),
      'unreadCount': unreadCount,
    };
  }

  factory ManagementChatConversation.fromJson(Map<String, dynamic> json) {
    return ManagementChatConversation(
      id: json['id'] ?? '',
      customerId: json['customerId'] ?? '',
      customerName: json['customerName'] ?? '',
      kedaiId: json['kedaiId'],
      kedaiName: json['kedaiName'],
      messages: (json['messages'] as List?)
              ?.map((m) => ManagementChatMessage.fromJson(m))
              .toList() ??
          [],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      lastMessageAt: json['lastMessageAt'] != null ? DateTime.parse(json['lastMessageAt']) : DateTime.now(),
      unreadCount: json['unreadCount'] ?? 0,
    );
  }
}

// ============================================================================
// RESERVASI / JANJI TEMU
// ============================================================================

enum ReservationStatus { pending, confirmed, rejected, completed, cancelled }

class Reservation {
  final String id;
  final String customerId;
  final String customerName;
  final String kedaiId;
  final String kedaiName;
  final DateTime reservationDate;
  final String? reservationTime; // Format HH:mm
  final String purpose; // "Reservasi", "Kunjungan", "Event", dll
  final int? numberOfPeople; // Jumlah orang (untuk reservasi meja)
  final String? notes; // Catatan tambahan
  final ReservationStatus status;
  final DateTime createdAt;
  final DateTime? confirmedAt;
  final String? rejectionReason;

  Reservation({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.kedaiId,
    required this.kedaiName,
    required this.reservationDate,
    this.reservationTime,
    required this.purpose,
    this.numberOfPeople,
    this.notes,
    this.status = ReservationStatus.pending,
    required this.createdAt,
    this.confirmedAt,
    this.rejectionReason,
  });

  bool get isPending => status == ReservationStatus.pending;
  bool get isConfirmed => status == ReservationStatus.confirmed;
  bool get isCompleted => status == ReservationStatus.completed;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'kedaiId': kedaiId,
      'kedaiName': kedaiName,
      'reservationDate': reservationDate.toIso8601String(),
      'reservationTime': reservationTime,
      'purpose': purpose,
      'numberOfPeople': numberOfPeople,
      'notes': notes,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'confirmedAt': confirmedAt?.toIso8601String(),
      'rejectionReason': rejectionReason,
    };
  }

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'] ?? '',
      customerId: json['customerId'] ?? '',
      customerName: json['customerName'] ?? '',
      kedaiId: json['kedaiId'] ?? '',
      kedaiName: json['kedaiName'] ?? '',
      reservationDate: json['reservationDate'] != null ? DateTime.parse(json['reservationDate']) : DateTime.now(),
      reservationTime: json['reservationTime'],
      purpose: json['purpose'] ?? '',
      numberOfPeople: json['numberOfPeople'],
      notes: json['notes'],
      status: ReservationStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => ReservationStatus.pending,
      ),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      confirmedAt: json['confirmedAt'] != null ? DateTime.parse(json['confirmedAt']) : null,
      rejectionReason: json['rejectionReason'],
    );
  }
}

// ============================================================================
// FAVORIT KEDAI
// ============================================================================

class FavoriteKedai {
  final String id;
  final String customerId;
  final String kedaiId;
  final Kedai kedai; // Full kedai object
  final DateTime addedAt;

  FavoriteKedai({
    required this.id,
    required this.customerId,
    required this.kedaiId,
    required this.kedai,
    required this.addedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'kedaiId': kedaiId,
      'kedai': kedai.toJson(),
      'addedAt': addedAt.toIso8601String(),
    };
  }

  factory FavoriteKedai.fromJson(Map<String, dynamic> json) {
    return FavoriteKedai(
      id: json['id'] ?? '',
      customerId: json['customerId'] ?? '',
      kedaiId: json['kedaiId'] ?? '',
      kedai: Kedai.fromJson(json['kedai'] ?? {}),
      addedAt: json['addedAt'] != null ? DateTime.parse(json['addedAt']) : DateTime.now(),
    );
  }
}

// ============================================================================
// SEARCH FILTER
// ============================================================================

class SearchFilter {
  final String? searchQuery;
  final List<String>? selectedCategories;
  final double? radiusInKm; // 1, 5, 10, 25 km
  final bool? isOpenOnly;
  final double? minRating; // Minimum rating (0-5)
  final bool? hasPromo;
  final bool? hasEvent;

  SearchFilter({
    this.searchQuery,
    this.selectedCategories,
    this.radiusInKm,
    this.isOpenOnly = false,
    this.minRating,
    this.hasPromo = false,
    this.hasEvent = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'searchQuery': searchQuery,
      'selectedCategories': selectedCategories,
      'radiusInKm': radiusInKm,
      'isOpenOnly': isOpenOnly,
      'minRating': minRating,
      'hasPromo': hasPromo,
      'hasEvent': hasEvent,
    };
  }
}
