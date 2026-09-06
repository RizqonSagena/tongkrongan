import 'package:tongkrongan_umkm_owner_app/models/culinary.dart';

class CustomerService {
  static final CustomerService _instance = CustomerService._internal();
  factory CustomerService() => _instance;
  CustomerService._internal();

  final List<CulinaryCategory> categories = const [
    CulinaryCategory(id: 'kopi', name: 'Kopi', icon: '☕', count: '18 Tempat'),
    CulinaryCategory(id: 'cafe', name: 'Cafe', icon: '🍰', count: '14 Tempat'),
    CulinaryCategory(id: 'restoran', name: 'Restoran', icon: '🍴', count: '24 Tempat'),
    CulinaryCategory(id: 'tradisional', name: 'Makanan Tradisional', icon: '🍛', count: '32 Tempat'),
    CulinaryCategory(id: 'seafood', name: 'Seafood', icon: '🦐', count: '11 Tempat'),
    CulinaryCategory(id: 'bakery', name: 'Bakery', icon: '🍞', count: '9 Tempat'),
    CulinaryCategory(id: 'bakso', name: 'Bakso', icon: '🥣', count: '21 Tempat'),
    CulinaryCategory(id: 'kaki_lima', name: 'Pedagang Kaki Lima', icon: '🍢', count: '45 Tempat'),
    CulinaryCategory(id: 'oleh_oleh', name: 'Oleh-Oleh', icon: '🎁', count: '7 Tempat'),
  ];

  final List<CulinaryBusiness> businesses = [
    CulinaryBusiness(
      id: 'warung-1',
      name: 'Kedai Kopi TONGkrongan',
      category: 'Kopi',
      rating: 4.8,
      reviewCount: 230,
      distanceKm: 0.3,
      address: 'Jl. Tebet Raya No. 42, Jakarta Selatan',
      openingHours: '08:00 - 23:00 WIB',
      phone: '0812-3456-7890',
      coverImage: 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800&q=80',
      photos: [
        'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800&q=80',
        'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800&q=80',
      ],
      priceRange: 'Rp15.000 - Rp35.000',
      isOpen: true,
      isFavorite: true,
      description: 'Kedai kopi khas tongkrongan anak muda dengan biji kopi lokal Indonesia pilihan dan racikan signature es kopi susu gula aren yang otentik.',
      menuItems: const [
        MenuItem(
          id: 'menu-1',
          name: 'Es Kopi Susu Aren TONGkrongan',
          description: 'Espresso double shot, susu segar, dan sirup gula aren organik',
          price: 18000,
          imageUrl: 'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?w=600&q=80',
          isAvailable: true,
          category: 'Minuman',
          isPopular: true,
        ),
        MenuItem(
          id: 'menu-2',
          name: 'Manual Brew V60 Gayo',
          description: 'Kopi Arabika Aceh Gayo dengan notes fruity dan floral',
          price: 24000,
          imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=600&q=80',
          isAvailable: true,
          category: 'Minuman',
          isPopular: false,
        ),
        MenuItem(
          id: 'menu-3',
          name: 'Roti Bakar Cokelat Keju Special',
          description: 'Roti tebal dengan limpahan keju cheddar parut dan meises cokelat premium',
          price: 20000,
          imageUrl: 'https://images.unsplash.com/photo-1584776296944-ab6fb57b0bdd?w=600&q=80',
          isAvailable: true,
          category: 'Makanan Ringan',
          isPopular: true,
        ),
        MenuItem(
          id: 'menu-4',
          name: 'Pisang Goreng Wijen Krispi',
          description: 'Pisang kepok manis digoreng tepung wijen renyah disajikan dengan cocolan madu',
          price: 16000,
          imageUrl: 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=600&q=80',
          isAvailable: true,
          category: 'Makanan Ringan',
          isPopular: false,
        ),
      ],
    ),
    CulinaryBusiness(
      id: 'warung-2',
      name: 'Sambal Bakar Nusantara',
      category: 'Makanan Tradisional',
      rating: 4.9,
      reviewCount: 512,
      distanceKm: 0.8,
      address: 'Jl. KH Abdullah Syafei No. 18, Jakarta Selatan',
      openingHours: '10:00 - 22:00 WIB',
      phone: '0813-8899-0011',
      coverImage: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800&q=80',
      photos: [
        'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800&q=80',
      ],
      priceRange: 'Rp18.000 - Rp45.000',
      isOpen: true,
      isFavorite: false,
      description: 'Spesialis aneka lauk dibakar langsung di atas cobek tanah liat dengan lumuran sambal pedas membara.',
      menuItems: const [
        MenuItem(
          id: 'menu-21',
          name: 'Sambal Bakar Ayam Goreng',
          description: 'Ayam ungkep rempah digoreng lalu dibakar di cobek sambal pedas gurih',
          price: 25000,
          imageUrl: 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=600&q=80',
          isAvailable: true,
          category: 'Makanan Utama',
          isPopular: true,
        ),
        MenuItem(
          id: 'menu-22',
          name: 'Sambal Bakar Cumi Asin Petai',
          description: 'Cumi asin empuk dan petai segar berpadu sambal bawang cobek',
          price: 28000,
          imageUrl: 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=600&q=80',
          isAvailable: true,
          category: 'Makanan Utama',
          isPopular: true,
        ),
      ],
    ),
    CulinaryBusiness(
      id: 'warung-3',
      name: 'Warung Seafood 68 Santa',
      category: 'Seafood',
      rating: 4.7,
      reviewCount: 380,
      distanceKm: 1.5,
      address: 'Jl. Wolter Monginsidi No. 68, Kebayoran Baru',
      openingHours: '17:00 - 02:00 WIB',
      phone: '0857-1122-3344',
      coverImage: 'https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?w=800&q=80',
      photos: [
        'https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?w=800&q=80',
      ],
      priceRange: 'Rp30.000 - Rp95.000',
      isOpen: true,
      isFavorite: true,
      description: 'Seafood tenda legendaris Jakarta Selatan dengan saus padang gurih pedas manis dan kepiting tarakan segar.',
      menuItems: const [
        MenuItem(
          id: 'menu-31',
          name: 'Udang Saus Padang Porsi Sedang',
          description: 'Udang pacet fresh dengan saus telur kental khas Padang',
          price: 45000,
          imageUrl: 'https://images.unsplash.com/photo-1565680018434-b513d5e5fd47?w=600&q=80',
          isAvailable: true,
          category: 'Seafood',
          isPopular: true,
        ),
      ],
    ),
    CulinaryBusiness(
      id: 'warung-4',
      name: 'Bakso Urat & Rusuk Pak Kumis',
      category: 'Bakso',
      rating: 4.8,
      reviewCount: 620,
      distanceKm: 2.2,
      address: 'Jl. Lapangan Roos Raya No. 5, Tebet',
      openingHours: '10:00 - 21:00 WIB',
      phone: '0878-9900-1122',
      coverImage: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=800&q=80',
      photos: [
        'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=800&q=80',
      ],
      priceRange: 'Rp22.000 - Rp40.000',
      isOpen: true,
      isFavorite: false,
      description: 'Bakso daging sapi asli dengan urat kasar yang kenyal, dipadu kuah kaldu sapi pekat bertabur tetelan melimpah.',
      menuItems: const [
        MenuItem(
          id: 'menu-41',
          name: 'Bakso Rusuk Komplit',
          description: '1 Bakso urat besar, 3 bakso halus, potongan tulang rusuk iga, mie kuning dan bihun',
          price: 35000,
          imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=600&q=80',
          isAvailable: true,
          category: 'Bakso',
          isPopular: true,
        ),
      ],
    ),
    CulinaryBusiness(
      id: 'warung-5',
      name: 'Roti Bakar & Martabak Mas Bro',
      category: 'Bakery',
      rating: 4.6,
      reviewCount: 190,
      distanceKm: 0.5,
      address: 'Jl. Tebet Timur Dalam No. 12',
      openingHours: '16:00 - 01:00 WIB',
      phone: '0819-2233-4455',
      coverImage: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800&q=80',
      photos: [
        'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800&q=80',
      ],
      priceRange: 'Rp14.000 - Rp32.000',
      isOpen: true,
      isFavorite: false,
      description: 'Camilan malam nikmat dengan puluhan variasi roti bakar manis dan asin.',
      menuItems: const [],
    ),
  ];

  final List<CustomerNotificationItem> notifications = const [
    CustomerNotificationItem(
      id: 'notif-1',
      title: 'Promo Baru di Sekitar Anda! 🎁',
      message: 'Diskon 20% untuk semua menu kopi di Kedai Kopi TONGkrongan (300m dari lokasi Anda).',
      time: '10 menit yang lalu',
      type: 'promo',
      isUnread: true,
    ),
    CustomerNotificationItem(
      id: 'notif-2',
      title: 'Warung Favorit Buka! 🦐',
      message: 'Warung Seafood 68 Santa baru saja membuka pesanan malam ini.',
      time: '1 jam yang lalu',
      type: 'favorite',
      isUnread: true,
    ),
    CustomerNotificationItem(
      id: 'notif-3',
      title: 'Kuliner Trending Hari Ini 🔥',
      message: 'Sambal Bakar Nusantara dikunjungi lebih dari 300 pelanggan hari ini di Tebet.',
      time: '3 jam yang lalu',
      type: 'nearby',
      isUnread: false,
    ),
  ];

  List<CulinaryBusiness> getFavorites() {
    return businesses.where((b) => b.isFavorite).toList();
  }

  void toggleFavorite(String id) {
    final index = businesses.indexWhere((b) => b.id == id);
    if (index != -1) {
      businesses[index].isFavorite = !businesses[index].isFavorite;
    }
  }

  CulinaryBusiness? getBusinessById(String id) {
    try {
      return businesses.firstWhere((b) => b.id == id);
    } catch (_) {
      return businesses.isNotEmpty ? businesses.first : null;
    }
  }

  List<CulinaryBusiness> getBusinessesByCategory(String category) {
    return businesses.where((b) => 
      b.category.toLowerCase().contains(category.toLowerCase()) || 
      category.toLowerCase().contains(b.category.toLowerCase())
    ).toList();
  }

  List<CulinaryBusiness> filterByRadius(double radiusKm) {
    return businesses.where((b) => b.distanceKm <= radiusKm).toList();
  }
}
