import 'package:tongkrongan_umkm_owner_app/models/advertising.dart';

class AdvertisingService {
  static final AdvertisingService _instance = AdvertisingService._internal();
  factory AdvertisingService() => _instance;
  AdvertisingService._internal();

  final AutoPlayConfig autoPlayConfig = AutoPlayConfig(
    isEnabled: true,
    scheduleTimes: ['08:00', '14:00', '19:00'],
    frequencyPerDay: 3,
    platforms: ['Instagram', 'TikTok', 'Facebook'],
    targetRadiusKm: 5.0,
    nextScheduledPromotion: '19:00 Hari Ini',
  );

  final List<PlatformConnection> platformConnections = [
    PlatformConnection(
      platformName: 'Instagram',
      icon: '📸',
      isConnected: true,
      accountHandle: '@tongkrongan_tebet',
      lastSync: '10 menit yang lalu',
    ),
    PlatformConnection(
      platformName: 'TikTok',
      icon: '🎵',
      isConnected: true,
      accountHandle: '@tongkrongan_official',
      lastSync: '1 jam yang lalu',
    ),
    PlatformConnection(
      platformName: 'Facebook',
      icon: '📘',
      isConnected: false,
      accountHandle: null,
      lastSync: null,
    ),
  ];

  final List<AdCampaign> campaigns = [
    AdCampaign(
      id: 'camp-1',
      name: 'Promo Es Kopi Susu Aren Spesial',
      productName: 'Es Kopi Susu Aren TONGkrongan',
      mediaUrl: 'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?w=800&q=80',
      caption: 'Beli 2 Es Kopi Susu Aren Gratis 1 Roti Bakar Cokelat! Khusus dine-in dan takeaway di cabang Tebet. Jangan sampai kehabisan sob! ☕🔥 #KopiTongkrongan',
      targetLocation: 'Tebet & Sekitarnya',
      radiusKm: 5.0,
      targetAudience: 'Anak muda, mahasiswa, pekerja kantoran (18-35 tahun)',
      platforms: ['Instagram', 'TikTok', 'Facebook'],
      budget: 350000,
      schedule: '08:00, 14:00, 19:00 (3x/hari)',
      status: CampaignStatus.active,
      reach: 24500,
      impressions: 48900,
      engagementRate: 5.4,
      clicks: 1820,
      estimatedCustomers: 340,
      spending: 280000,
    ),
    AdCampaign(
      id: 'camp-2',
      name: 'Makan Siang Murah Sambal Bakar',
      productName: 'Paket Sambal Bakar Komplit',
      mediaUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800&q=80',
      caption: 'Makan siang pedas nampol mulai 20 ribuan! Nasi pulen + ayam bakar cobek + es teh manis refill. Yuk mampir!',
      targetLocation: 'Jakarta Selatan',
      radiusKm: 3.0,
      targetAudience: 'Pecinta pedas, pekerja kantor',
      platforms: ['Instagram', 'TikTok'],
      budget: 200000,
      schedule: '11:00 - 13:00 WIB',
      status: CampaignStatus.active,
      reach: 14200,
      impressions: 26100,
      engagementRate: 6.1,
      clicks: 940,
      estimatedCustomers: 185,
      spending: 195000,
    ),
    AdCampaign(
      id: 'camp-3',
      name: 'Weekend Seafood Feast Discount 25%',
      productName: 'Kepiting & Udang Saus Padang',
      mediaUrl: 'https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?w=800&q=80',
      caption: 'Malam mingguan pesta seafood bareng keluarga dan sahabat! Dapatkan potongan 25% untuk pemesanan di atas 150rb.',
      targetLocation: 'Kebayoran & Tebet',
      radiusKm: 7.0,
      targetAudience: 'Keluarga, komunitas kuliner',
      platforms: ['Instagram', 'Facebook'],
      budget: 500000,
      schedule: 'Sabtu & Minggu 17:00 WIB',
      status: CampaignStatus.paused,
      reach: 38200,
      impressions: 62400,
      engagementRate: 4.2,
      clicks: 2150,
      estimatedCustomers: 410,
      spending: 420000,
    ),
    AdCampaign(
      id: 'camp-4',
      name: 'Grand Opening Diskon 50%',
      productName: 'Semua Menu Minuman',
      mediaUrl: 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800&q=80',
      caption: 'Terima kasih atas antusiasme luar biasa di hari pembukaan! Promo telah berakhir.',
      targetLocation: 'Tebet',
      radiusKm: 5.0,
      targetAudience: 'Semua kalangan',
      platforms: ['Instagram', 'TikTok', 'Facebook'],
      budget: 1000000,
      schedule: '1 - 3 September',
      status: CampaignStatus.completed,
      reach: 89000,
      impressions: 145000,
      engagementRate: 7.8,
      clicks: 6300,
      estimatedCustomers: 1250,
      spending: 1000000,
    ),
  ];

  final List<ContentCreator> creators = const [
    ContentCreator(
      id: 'creator-1',
      name: 'Dimas Kulineran (Food Vlogger)',
      avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400&q=80',
      category: 'Food Vlogger',
      followers: '340K',
      engagementRate: '5.6%',
      location: 'Jakarta Selatan',
      promotionPrice: 750000,
      rating: 4.9,
      bio: 'Spesialis kuliner kaki lima, hidden gem warung makan legendaris & street food viral di Jabodetabek.',
      portfolioUrls: [
        'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=600&q=80',
        'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=600&q=80',
      ],
      previousCampaigns: [
        'Review Sambal Bakar Viral (1.2M Views)',
        'Eksplor Kopi Susu Tebet (850K Views)',
      ],
      pricePackages: {
        '1x TikTok Video Review': 750000,
        '1x Instagram Reels + 3x Stories': 950000,
        'Paket Komplit (TikTok + Reels + YT Shorts)': 1500000,
      },
    ),
    ContentCreator(
      id: 'creator-2',
      name: 'Siti Foodie Diaries',
      avatarUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=400&q=80',
      category: 'Content Creator',
      followers: '185K',
      engagementRate: '6.2%',
      location: 'Jakarta Timur & Selatan',
      promotionPrice: 500000,
      rating: 4.8,
      bio: 'Aesthetic cafe review, review menu UMKM autentik, fotografi makanan menggugah selera.',
      portfolioUrls: [
        'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?w=600&q=80',
      ],
      previousCampaigns: [
        'Rekomendasi Cafe Nongkrong WFC Tebet',
      ],
      pricePackages: {
        '1x Reels Review': 500000,
        'Photo Post Feeds + 2 Stories': 350000,
      },
    ),
    ContentCreator(
      id: 'creator-3',
      name: 'Bang Rian Info Tebet',
      avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&q=80',
      category: 'Local Influencer',
      followers: '92K',
      engagementRate: '8.1%',
      location: 'Tebet & Manggarai',
      promotionPrice: 300000,
      rating: 4.7,
      bio: 'Komunitas lokal seputar info kuliner, diskon, dan event di sekitar Tebet Raya.',
      portfolioUrls: [],
      previousCampaigns: [
        'Liputan Warung Tenda Malam Tebet',
      ],
      pricePackages: {
        'Broadcast Community Story': 300000,
        'Feeds Post Info Kuliner': 450000,
      },
    ),
  ];

  final List<PromotionEvent> calendarEvents = const [
    PromotionEvent(
      id: 'evt-1',
      campaignName: 'Promo Es Kopi Susu',
      platform: 'Instagram + TikTok',
      scheduledTime: '08:00 WIB',
      date: 'Hari Ini, 5 Sep',
      status: PromotionEventStatus.published,
    ),
    PromotionEvent(
      id: 'evt-2',
      campaignName: 'Promo Makan Siang Murah',
      platform: 'Instagram',
      scheduledTime: '11:30 WIB',
      date: 'Hari Ini, 5 Sep',
      status: PromotionEventStatus.published,
    ),
    PromotionEvent(
      id: 'evt-3',
      campaignName: 'Promo Es Kopi Susu Sore',
      platform: 'TikTok + FB',
      scheduledTime: '14:00 WIB',
      date: 'Hari Ini, 5 Sep',
      status: PromotionEventStatus.published,
    ),
    PromotionEvent(
      id: 'evt-4',
      campaignName: 'Auto Play Malam Kopi & Roti',
      platform: 'Instagram + TikTok + FB',
      scheduledTime: '19:00 WIB',
      date: 'Hari Ini, 5 Sep',
      status: PromotionEventStatus.scheduled,
    ),
    PromotionEvent(
      id: 'evt-5',
      campaignName: 'Sarapan Kopi Pagi',
      platform: 'Instagram',
      scheduledTime: '08:00 WIB',
      date: 'Besok, 6 Sep',
      status: PromotionEventStatus.scheduled,
    ),
    PromotionEvent(
      id: 'evt-6',
      campaignName: 'Diskon Seafood Jumat',
      platform: 'TikTok',
      scheduledTime: '18:00 WIB',
      date: 'Besok, 6 Sep',
      status: PromotionEventStatus.paused,
    ),
  ];

  void addCampaign(AdCampaign campaign) {
    campaigns.insert(0, campaign);
  }

  void toggleCampaignStatus(String id) {
    final index = campaigns.indexWhere((c) => c.id == id);
    if (index != -1) {
      if (campaigns[index].status == CampaignStatus.active) {
        campaigns[index].status = CampaignStatus.paused;
      } else if (campaigns[index].status == CampaignStatus.paused) {
        campaigns[index].status = CampaignStatus.active;
      }
    }
  }

  AdCampaign? getCampaignById(String id) {
    try {
      return campaigns.firstWhere((c) => c.id == id);
    } catch (_) {
      return campaigns.isNotEmpty ? campaigns.first : null;
    }
  }

  ContentCreator? getCreatorById(String id) {
    try {
      return creators.firstWhere((c) => c.id == id);
    } catch (_) {
      return creators.isNotEmpty ? creators.first : null;
    }
  }
}
