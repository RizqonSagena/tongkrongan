enum CampaignStatus {
  active,
  paused,
  completed;

  String get displayName {
    switch (this) {
      case CampaignStatus.active:
        return 'ACTIVE';
      case CampaignStatus.paused:
        return 'PAUSED';
      case CampaignStatus.completed:
        return 'COMPLETED';
    }
  }
}

class AdCampaign {
  final String id;
  final String name;
  final String productName;
  final String mediaUrl;
  final String caption;
  final String targetLocation;
  final double radiusKm;
  final String targetAudience;
  final List<String> platforms; // 'Instagram', 'TikTok', 'Facebook'
  final double budget;
  final String schedule;
  CampaignStatus status;
  final int reach;
  final int impressions;
  final double engagementRate;
  final int clicks;
  final int estimatedCustomers;
  final double spending;

  AdCampaign({
    required this.id,
    required this.name,
    required this.productName,
    required this.mediaUrl,
    required this.caption,
    required this.targetLocation,
    required this.radiusKm,
    required this.targetAudience,
    required this.platforms,
    required this.budget,
    required this.schedule,
    this.status = CampaignStatus.active,
    this.reach = 0,
    this.impressions = 0,
    this.engagementRate = 0.0,
    this.clicks = 0,
    this.estimatedCustomers = 0,
    this.spending = 0,
  });

  String get formattedBudget => 'Rp${budget.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  String get formattedSpending => 'Rp${spending.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
}

class AutoPlayConfig {
  bool isEnabled;
  List<String> scheduleTimes; // ['08:00', '14:00', '19:00']
  int frequencyPerDay; // 3
  List<String> platforms; // ['Instagram', 'TikTok', 'Facebook']
  double targetRadiusKm; // 5.0
  String nextScheduledPromotion; // '19:00 Hari Ini'

  AutoPlayConfig({
    required this.scheduleTimes, required this.platforms, this.isEnabled = true,
    this.frequencyPerDay = 3,
    this.targetRadiusKm = 5.0,
    this.nextScheduledPromotion = '19:00 Hari Ini',
  });
}

class ContentCreator {
  final String id;
  final String name;
  final String avatarUrl;
  final String category; // 'Content Creator', 'Food Vlogger', 'Local Influencer'
  final String followers; // e.g. '125K'
  final String engagementRate; // '4.8%'
  final String location;
  final double promotionPrice;
  final double rating;
  final String bio;
  final List<String> portfolioUrls;
  final List<String> previousCampaigns;
  final Map<String, double> pricePackages;

  const ContentCreator({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.category,
    required this.followers,
    required this.engagementRate,
    required this.location,
    required this.promotionPrice,
    required this.rating,
    required this.bio,
    this.portfolioUrls = const [],
    this.previousCampaigns = const [],
    this.pricePackages = const {},
  });

  String get formattedPrice => 'Rp${promotionPrice.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
}

class PlatformConnection {
  final String platformName; // 'Instagram', 'TikTok', 'Facebook'
  final String icon;
  bool isConnected;
  String? accountHandle;
  String? lastSync;

  PlatformConnection({
    required this.platformName,
    required this.icon,
    this.isConnected = false,
    this.accountHandle,
    this.lastSync,
  });
}

enum PromotionEventStatus {
  scheduled,
  published,
  failed,
  paused;

  String get displayName {
    switch (this) {
      case PromotionEventStatus.scheduled:
        return 'Scheduled';
      case PromotionEventStatus.published:
        return 'Published';
      case PromotionEventStatus.failed:
        return 'Failed';
      case PromotionEventStatus.paused:
        return 'Paused';
    }
  }
}

class PromotionEvent {
  final String id;
  final String campaignName;
  final String platform;
  final String scheduledTime;
  final String date;
  final PromotionEventStatus status;

  const PromotionEvent({
    required this.id,
    required this.campaignName,
    required this.platform,
    required this.scheduledTime,
    required this.date,
    required this.status,
  });
}
