class CulinaryBusiness {
  final String id;
  final String name;
  final String category;
  final double rating;
  final int reviewCount;
  final double distanceKm;
  final String address;
  final String openingHours;
  final String phone;
  final String coverImage;
  final List<String> photos;
  final String priceRange;
  final bool isOpen;
  bool isFavorite;
  final String description;
  final List<MenuItem> menuItems;

  CulinaryBusiness({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.distanceKm,
    required this.address,
    required this.openingHours,
    required this.phone,
    required this.coverImage,
    required this.photos,
    required this.priceRange,
    required this.isOpen,
    required this.description, this.isFavorite = false,
    this.menuItems = const [],
  });

  String get formattedDistance => distanceKm < 1.0 
      ? '${(distanceKm * 1000).toInt()} m' 
      : '${distanceKm.toStringAsFixed(1)} KM';
}

class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isAvailable;
  final String category;
  final bool isPopular;

  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category, this.isAvailable = true,
    this.isPopular = false,
  });

  String get formattedPrice {
    final cleanPrice = price.toInt();
    final buffer = StringBuffer();
    final priceStr = cleanPrice.toString();
    for (int i = 0; i < priceStr.length; i++) {
      if (i > 0 && (priceStr.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(priceStr[i]);
    }
    return 'Rp$buffer';
  }
}

class CulinaryCategory {
  final String id;
  final String name;
  final String icon;
  final String count;

  const CulinaryCategory({
    required this.id,
    required this.name,
    required this.icon,
    this.count = '12+ Tempat',
  });
}

class CustomerNotificationItem {
  final String id;
  final String title;
  final String message;
  final String time;
  final String type; // promo, nearby, favorite
  final bool isUnread;

  const CustomerNotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isUnread = true,
  });
}
