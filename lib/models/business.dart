class Business {
  final String id;
  final String name;
  final String category;
  final String description;
  final String address;
  final String phone;
  final String? email;
  final String? logo;
  final BusinessStatus status;
  final BusinessHours operatingHours;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Business({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.address,
    required this.phone,
    required this.operatingHours, required this.createdAt, this.email,
    this.logo,
    this.status = BusinessStatus.active,
    this.updatedAt,
  });

  Business copyWith({
    String? id,
    String? name,
    String? category,
    String? description,
    String? address,
    String? phone,
    String? email,
    String? logo,
    BusinessStatus? status,
    BusinessHours? operatingHours,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Business(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      logo: logo ?? this.logo,
      status: status ?? this.status,
      operatingHours: operatingHours ?? this.operatingHours,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'address': address,
      'phone': phone,
      'email': email,
      'logo': logo,
      'status': status.name,
      'operatingHours': operatingHours.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      logo: json['logo'],
      status: BusinessStatus.values.byName(json['status'] ?? 'active'),
      operatingHours: BusinessHours.fromJson(json['operatingHours']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }
}

enum BusinessStatus {
  active,
  inactive,
  suspended;

  String get displayName {
    switch (this) {
      case BusinessStatus.active:
        return 'Usaha Aktif';
      case BusinessStatus.inactive:
        return 'Tidak Aktif';
      case BusinessStatus.suspended:
        return 'Ditangguhkan';
    }
  }
}

class BusinessHours {
  final TimeRange? monday;
  final TimeRange? tuesday;
  final TimeRange? wednesday;
  final TimeRange? thursday;
  final TimeRange? friday;
  final TimeRange? saturday;
  final TimeRange? sunday;

  BusinessHours({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  List<String> get operatingDays {
    final List<String> days = [];
    if (monday != null) days.add('Senin');
    if (tuesday != null) days.add('Selasa');
    if (wednesday != null) days.add('Rabu');
    if (thursday != null) days.add('Kamis');
    if (friday != null) days.add('Jumat');
    if (saturday != null) days.add('Sabtu');
    if (sunday != null) days.add('Minggu');
    return days;
  }

  bool isOpenOn(DateTime date) {
    TimeRange? range;
    switch (date.weekday) {
      case 1: range = monday; break;
      case 2: range = tuesday; break;
      case 3: range = wednesday; break;
      case 4: range = thursday; break;
      case 5: range = friday; break;
      case 6: range = saturday; break;
      case 7: range = sunday; break;
    }
    return range != null;
  }

  Map<String, dynamic> toJson() {
    return {
      'monday': monday?.toJson(),
      'tuesday': tuesday?.toJson(),
      'wednesday': wednesday?.toJson(),
      'thursday': thursday?.toJson(),
      'friday': friday?.toJson(),
      'saturday': saturday?.toJson(),
      'sunday': sunday?.toJson(),
    };
  }

  factory BusinessHours.fromJson(Map<String, dynamic> json) {
    return BusinessHours(
      monday: json['monday'] != null ? TimeRange.fromJson(json['monday']) : null,
      tuesday: json['tuesday'] != null ? TimeRange.fromJson(json['tuesday']) : null,
      wednesday: json['wednesday'] != null ? TimeRange.fromJson(json['wednesday']) : null,
      thursday: json['thursday'] != null ? TimeRange.fromJson(json['thursday']) : null,
      friday: json['friday'] != null ? TimeRange.fromJson(json['friday']) : null,
      saturday: json['saturday'] != null ? TimeRange.fromJson(json['saturday']) : null,
      sunday: json['sunday'] != null ? TimeRange.fromJson(json['sunday']) : null,
    );
  }
}

class TimeRange {
  final String openTime; // Format: "HH:mm"
  final String closeTime; // Format: "HH:mm"

  TimeRange({
    required this.openTime,
    required this.closeTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'openTime': openTime,
      'closeTime': closeTime,
    };
  }

  factory TimeRange.fromJson(Map<String, dynamic> json) {
    return TimeRange(
      openTime: json['openTime'],
      closeTime: json['closeTime'],
    );
  }
}

enum BusinessCategory {
  warungMakan,
  kedaiKopi,
  rumahMakan,
  restoran,
  warungSeafood,
  bakery,
  pedagangKakiLima,
  tokoOlehOleh,
  catering,
  lainnya;

  String get displayName {
    switch (this) {
      case BusinessCategory.warungMakan:
        return 'Warung Makan';
      case BusinessCategory.kedaiKopi:
        return 'Kedai Kopi';
      case BusinessCategory.rumahMakan:
        return 'Rumah Makan';
      case BusinessCategory.restoran:
        return 'Restoran';
      case BusinessCategory.warungSeafood:
        return 'Warung Seafood';
      case BusinessCategory.bakery:
        return 'Toko Roti/Bakery';
      case BusinessCategory.pedagangKakiLima:
        return 'Pedagang Kaki Lima';
      case BusinessCategory.tokoOlehOleh:
        return 'Toko Oleh-oleh';
      case BusinessCategory.catering:
        return 'Catering';
      case BusinessCategory.lainnya:
        return 'Lainnya';
    }
  }

  String get icon {
    switch (this) {
      case BusinessCategory.warungMakan:
        return '🍽️';
      case BusinessCategory.kedaiKopi:
        return '☕';
      case BusinessCategory.rumahMakan:
        return '🏠';
      case BusinessCategory.restoran:
        return '🍴';
      case BusinessCategory.warungSeafood:
        return '🦐';
      case BusinessCategory.bakery:
        return '🍞';
      case BusinessCategory.pedagangKakiLima:
        return '🛒';
      case BusinessCategory.tokoOlehOleh:
        return '🎁';
      case BusinessCategory.catering:
        return '🍱';
      case BusinessCategory.lainnya:
        return '🏪';
    }
  }
}