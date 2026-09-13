/// Model untuk HPP (Harga Pokok Penjualan)
class HPP {
  final String id;
  final String productId;
  final String productName;
  final double hpp; // Harga Pokok Penjualan
  final double sellingPrice;
  final double profitPerUnit;
  final double profitMargin;
  final DateTime lastUpdated;
  final String? notes;

  HPP({
    required this.id,
    required this.productId,
    required this.productName,
    required this.hpp,
    required this.sellingPrice,
    required this.lastUpdated,
    this.notes,
  })  : profitPerUnit = sellingPrice - hpp,
        profitMargin = hpp > 0 ? ((sellingPrice - hpp) / hpp) * 100 : 0;

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'hpp': hpp,
      'sellingPrice': sellingPrice,
      'profitPerUnit': profitPerUnit,
      'profitMargin': profitMargin,
      'lastUpdated': lastUpdated.toIso8601String(),
      'notes': notes,
    };
  }

  // Create from JSON
  factory HPP.fromJson(Map<String, dynamic> json) {
    return HPP(
      id: json['id'] ?? '',
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      hpp: (json['hpp'] as num?)?.toDouble() ?? 0.0,
      sellingPrice: (json['sellingPrice'] as num?)?.toDouble() ?? 0.0,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : DateTime.now(),
      notes: json['notes'],
    );
  }

  // Copy with
  HPP copyWith({
    String? id,
    String? productId,
    String? productName,
    double? hpp,
    double? sellingPrice,
    DateTime? lastUpdated,
    String? notes,
  }) {
    return HPP(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      hpp: hpp ?? this.hpp,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      notes: notes ?? this.notes,
    );
  }
}

/// Summary HPP untuk Dashboard
class HPPSummary {
  final double totalHPP;
  final double totalRevenue;
  final double totalProfit;
  final double averageProfitMargin;
  final int totalProducts;
  final int lowProfitMarginProducts;

  HPPSummary({
    required this.totalHPP,
    required this.totalRevenue,
    required this.totalProfit,
    required this.averageProfitMargin,
    required this.totalProducts,
    required this.lowProfitMarginProducts,
  });

  double get totalProfitMargin => totalHPP > 0 ? (totalProfit / totalHPP) * 100 : 0;

  Map<String, dynamic> toJson() {
    return {
      'totalHPP': totalHPP,
      'totalRevenue': totalRevenue,
      'totalProfit': totalProfit,
      'averageProfitMargin': averageProfitMargin,
      'totalProfitMargin': totalProfitMargin,
      'totalProducts': totalProducts,
      'lowProfitMarginProducts': lowProfitMarginProducts,
    };
  }
}

/// HPP History untuk tracking perubahan harga
class HPPHistory {
  final String id;
  final String hppId;
  final double previousHPP;
  final double newHPP;
  final double previousPrice;
  final double newPrice;
  final DateTime changedAt;
  final String reason;

  HPPHistory({
    required this.id,
    required this.hppId,
    required this.previousHPP,
    required this.newHPP,
    required this.previousPrice,
    required this.newPrice,
    required this.changedAt,
    required this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hppId': hppId,
      'previousHPP': previousHPP,
      'newHPP': newHPP,
      'previousPrice': previousPrice,
      'newPrice': newPrice,
      'changedAt': changedAt.toIso8601String(),
      'reason': reason,
    };
  }

  factory HPPHistory.fromJson(Map<String, dynamic> json) {
    return HPPHistory(
      id: json['id'] ?? '',
      hppId: json['hppId'] ?? '',
      previousHPP: (json['previousHPP'] as num?)?.toDouble() ?? 0.0,
      newHPP: (json['newHPP'] as num?)?.toDouble() ?? 0.0,
      previousPrice: (json['previousPrice'] as num?)?.toDouble() ?? 0.0,
      newPrice: (json['newPrice'] as num?)?.toDouble() ?? 0.0,
      changedAt: json['changedAt'] != null
          ? DateTime.parse(json['changedAt'])
          : DateTime.now(),
      reason: json['reason'] ?? '',
    );
  }
}
