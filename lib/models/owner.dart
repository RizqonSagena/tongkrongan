import 'package:flutter/material.dart';

/// ============================================================================
/// OWNER MODELS - Comprehensive data models untuk Owner/UMKM Management
/// ============================================================================
/// Total: 6 model classes untuk mendukung semua fitur owner
/// - Transaction: Riwayat penjualan per item
/// - Product: Menu/Produk yang dijual
/// - HPP: Harga Pokok Penjualan (Cost of Goods Sold)
/// - Expense: Biaya operasional lainnya
/// - OrderQueue: Antrian pesanan customer (Kitchen Display System)
/// - BusinessStats: Statistik bisnis agregat (Omzet, Pendapatan, Keuntungan)

/// ============================================================================
/// 1. TRANSACTION MODEL
/// ============================================================================
/// Menyimpan setiap transaksi penjualan dengan detail produk
class Transaction {
  String id;
  String productId;
  String productName;
  int quantity;
  double unitPrice;
  double totalPrice;
  DateTime transactionDate;
  String paymentMethod; // cash, card, digital, transfer
  String status; // completed, pending, cancelled
  String? notes;

  Transaction({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.transactionDate,
    required this.paymentMethod,
    required this.status,
    this.notes,
  });

  /// Menghitung profit per transaksi (jika HPP tersedia)
  double calculateProfit(double hpp) {
    return (unitPrice - hpp) * quantity;
  }

  /// Format untuk display
  String get formattedDate => '${transactionDate.day}/${transactionDate.month}/${transactionDate.year}';
  String get formattedPrice => 'Rp${totalPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';
}

/// ============================================================================
/// 2. PRODUCT MODEL
/// ============================================================================
/// Menyimpan data produk/menu yang dijual owner
class Product {
  String id;
  String name;
  String description;
  String category; // Makanan, Minuman, Snack, dll
  String? imageUrl;
  double price;
  double? hpp; // Harga Pokok Penjualan (Cost)
  int stock; // Stok tersedia (opsional)
  bool isAvailable;
  DateTime createdAt;
  DateTime? lastModified;
  int totalSoldCount; // Total pernah terjual

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    this.imageUrl,
    required this.price,
    this.hpp,
    this.stock = 999, // Default unlimited jika tidak diatur
    required this.isAvailable,
    required this.createdAt,
    this.lastModified,
    this.totalSoldCount = 0,
  });

  /// Menghitung profit margin per produk
  double get profitMargin {
    if (hpp == null || hpp == 0) return 0;
    return ((price - hpp!) / price * 100);
  }

  /// Menghitung profit per unit
  double get profitPerUnit {
    if (hpp == null) return 0;
    return price - hpp!;
  }

  /// Status stok
  String get stockStatus {
    if (stock <= 0) return 'Habis';
    if (stock <= 5) return 'Hampir habis';
    return 'Tersedia';
  }
}

/// ============================================================================
/// 3. HPP MODEL (Harga Pokok Penjualan / Cost of Goods Sold)
/// ============================================================================
/// Menyimpan informasi HPP dan bahan baku
class HPP {
  String id;
  String productId;
  String ingredientName; // Nama bahan (Kopi, Gula, Susu, dll)
  double costPerUnit; // Harga per unit
  String unit; // gram, ml, pieces, kg, liter
  double quantityUsedPerProduct; // Jumlah bahan per produk
  double totalCostPerProduct; // Total cost per produk (auto-calculated)
  DateTime createdAt;
  DateTime? lastModified;

  HPP({
    required this.id,
    required this.productId,
    required this.ingredientName,
    required this.costPerUnit,
    required this.unit,
    required this.quantityUsedPerProduct,
    required this.totalCostPerProduct,
    required this.createdAt,
    this.lastModified,
  });

  /// Auto-calculate total cost
  void calculateTotalCost() {
    totalCostPerProduct = costPerUnit * quantityUsedPerProduct;
  }

  /// Format untuk display
  String get formattedCost => 'Rp${totalCostPerProduct.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';
}

/// ============================================================================
/// 4. EXPENSE MODEL
/// ============================================================================
/// Menyimpan biaya operasional lainnya (gaji, listrik, sewa, dll)
class Expense {
  String id;
  String expenseType; // Gaji, Listrik, Sewa, Transportasi, Marketing, Lainnya
  double amount;
  DateTime expenseDate;
  String? description;
  String category; // Variable, Fixed, Semi-variable
  String? receipt; // URL foto struk/bukti
  DateTime createdAt;
  String status; // pending, approved, rejected, completed

  Expense({
    required this.id,
    required this.expenseType,
    required this.amount,
    required this.expenseDate,
    this.description,
    required this.category,
    this.receipt,
    required this.createdAt,
    this.status = 'completed',
  });

  /// Format untuk display
  String get formattedAmount => 'Rp${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';
}

/// ============================================================================
/// 5. ORDER QUEUE MODEL (Kitchen Display System / POS Integration)
/// ============================================================================
/// Menyimpan antrian pesanan dari customer (Kitchen Display System concept)
class OrderQueue {
  String id;
  String customerId;
  String customerName;
  List<OrderItem> items; // Daftar produk dalam order
  double totalAmount;
  DateTime orderTime;
  DateTime? completionTime;
  String status; // pending, preparing, ready, completed, cancelled
  String paymentStatus; // unpaid, paid, refunded
  String? notes; // Catatan khusus customer

  OrderQueue({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.items,
    required this.totalAmount,
    required this.orderTime,
    this.completionTime,
    required this.status,
    required this.paymentStatus,
    this.notes,
  });

  /// Durasi persiapan dalam menit
  int get preparationTimeMinutes {
    if (completionTime == null) return 0;
    return completionTime!.difference(orderTime).inMinutes;
  }

  /// Priority berdasarkan waktu tunggu
  int get waitTimeMinutes {
    return DateTime.now().difference(orderTime).inMinutes;
  }

  /// Format untuk display
  String get formattedTime => '${orderTime.hour}:${orderTime.minute.toString().padLeft(2, '0')}';
}

/// Order item di dalam OrderQueue
class OrderItem {
  String productId;
  String productName;
  int quantity;
  double price;
  String? specialRequest;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    this.specialRequest,
  });

  double get subtotal => quantity * price;
}

/// ============================================================================
/// 6. BUSINESS STATS MODEL
/// ============================================================================
/// Menyimpan statistik bisnis agregat untuk dashboard KPI
class BusinessStats {
  String ownerId;
  DateTime periodStart;
  DateTime periodEnd;

  // Penjualan
  double totalRevenue; // Total penjualan kotor
  int totalTransactionCount; // Jumlah transaksi
  int totalItemsSold; // Total item terjual
  double averageTransactionValue; // Rata-rata per transaksi

  // Biaya
  double totalHPP; // Total HPP semua produk terjual
  double totalExpenses; // Total biaya operasional
  double totalCost; // Total HPP + Expense

  // Profit
  double grossProfit; // Revenue - HPP
  double netProfit; // Revenue - (HPP + Expense)
  double profitMargin; // Net Profit / Revenue * 100

  // Trend
  Map<String, double> dailyRevenue; // Revenue per hari
  Map<String, int> topProducts; // Produk terlaris (name -> count)
  double revenueTrend; // % perubahan vs periode sebelumnya
  double expenseTrend; // % perubahan biaya vs periode sebelumnya

  BusinessStats({
    required this.ownerId,
    required this.periodStart,
    required this.periodEnd,
    required this.totalRevenue,
    required this.totalTransactionCount,
    required this.totalItemsSold,
    required this.averageTransactionValue,
    required this.totalHPP,
    required this.totalExpenses,
    required this.totalCost,
    required this.grossProfit,
    required this.netProfit,
    required this.profitMargin,
    required this.dailyRevenue,
    required this.topProducts,
    required this.revenueTrend,
    required this.expenseTrend,
  });

  /// Auto-calculate dari transaksi dan expenses
  void calculateStats(List<Transaction> transactions, List<Expense> expenses) {
    // Revenue
    totalRevenue = transactions.fold(0, (sum, tx) => sum + tx.totalPrice);
    totalTransactionCount = transactions.length;
    totalItemsSold = transactions.fold(0, (sum, tx) => sum + tx.quantity);
    averageTransactionValue = totalTransactionCount > 0 ? totalRevenue / totalTransactionCount : 0;

    // Biaya
    totalExpenses = expenses.fold(0, (sum, exp) => sum + exp.amount);
    totalCost = totalHPP + totalExpenses;

    // Profit
    grossProfit = totalRevenue - totalHPP;
    netProfit = totalRevenue - totalCost;
    profitMargin = totalRevenue > 0 ? (netProfit / totalRevenue * 100) : 0;
  }

  /// Format untuk display
  String get formattedRevenue =>
      'Rp${totalRevenue.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';
  String get formattedProfit =>
      'Rp${netProfit.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';
  String get formattedExpenses =>
      'Rp${totalExpenses.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';
}

/// ============================================================================
/// HELPER: Mock Data Generator untuk testing
/// ============================================================================
class OwnerMockData {
  /// Generate mock transactions
  static List<Transaction> generateMockTransactions() {
    return [
      Transaction(
        id: 'TRX001',
        productId: 'PRD001',
        productName: 'Kopi Susu',
        quantity: 5,
        unitPrice: 15000,
        totalPrice: 75000,
        transactionDate: DateTime.now().subtract(Duration(days: 2)),
        paymentMethod: 'cash',
        status: 'completed',
      ),
      Transaction(
        id: 'TRX002',
        productId: 'PRD002',
        productName: 'Americano',
        quantity: 3,
        unitPrice: 12000,
        totalPrice: 36000,
        transactionDate: DateTime.now().subtract(Duration(days: 1)),
        paymentMethod: 'card',
        status: 'completed',
      ),
      Transaction(
        id: 'TRX003',
        productId: 'PRD001',
        productName: 'Kopi Susu',
        quantity: 8,
        unitPrice: 15000,
        totalPrice: 120000,
        transactionDate: DateTime.now(),
        paymentMethod: 'digital',
        status: 'completed',
      ),
      Transaction(
        id: 'TRX004',
        productId: 'PRD003',
        productName: 'Matcha Latte',
        quantity: 4,
        unitPrice: 18000,
        totalPrice: 72000,
        transactionDate: DateTime.now(),
        paymentMethod: 'cash',
        status: 'completed',
      ),
      Transaction(
        id: 'TRX005',
        productId: 'PRD004',
        productName: 'Sandwich',
        quantity: 6,
        unitPrice: 25000,
        totalPrice: 150000,
        transactionDate: DateTime.now(),
        paymentMethod: 'transfer',
        status: 'completed',
      ),
    ];
  }

  /// Generate mock products
  static List<Product> generateMockProducts() {
    return [
      Product(
        id: 'PRD001',
        name: 'Kopi Susu',
        description: 'Kopi premium dengan susu segar',
        category: 'Minuman',
        price: 15000,
        hpp: 6000,
        createdAt: DateTime.now().subtract(Duration(days: 30)),
        isAvailable: true,
        totalSoldCount: 150,
      ),
      Product(
        id: 'PRD002',
        name: 'Americano',
        description: 'Kopi hitam kental',
        category: 'Minuman',
        price: 12000,
        hpp: 5000,
        createdAt: DateTime.now().subtract(Duration(days: 30)),
        isAvailable: true,
        totalSoldCount: 98,
      ),
      Product(
        id: 'PRD003',
        name: 'Matcha Latte',
        description: 'Matcha premium dari Jepang',
        category: 'Minuman',
        price: 18000,
        hpp: 8000,
        createdAt: DateTime.now().subtract(Duration(days: 20)),
        isAvailable: true,
        totalSoldCount: 62,
      ),
      Product(
        id: 'PRD004',
        name: 'Sandwich',
        description: 'Sandwich roti gandum dengan isi pilihan',
        category: 'Makanan',
        price: 25000,
        hpp: 12000,
        createdAt: DateTime.now().subtract(Duration(days: 15)),
        isAvailable: true,
        totalSoldCount: 45,
      ),
      Product(
        id: 'PRD005',
        name: 'Croissant',
        description: 'Pastry mentega renyah',
        category: 'Makanan',
        price: 20000,
        hpp: 9000,
        createdAt: DateTime.now().subtract(Duration(days: 10)),
        isAvailable: true,
        totalSoldCount: 87,
      ),
      Product(
        id: 'PRD006',
        name: 'Teh Es Lemon',
        description: 'Teh segar dengan lemon dan es',
        category: 'Minuman',
        price: 10000,
        hpp: 3000,
        createdAt: DateTime.now().subtract(Duration(days: 5)),
        isAvailable: true,
        totalSoldCount: 203,
      ),
    ];
  }

  /// Generate mock expenses
  static List<Expense> generateMockExpenses() {
    return [
      Expense(
        id: 'EXP001',
        expenseType: 'Gaji',
        amount: 2000000,
        expenseDate: DateTime.now(),
        description: 'Gaji karyawan bulan ini',
        category: 'Fixed',
        createdAt: DateTime.now(),
        status: 'completed',
      ),
      Expense(
        id: 'EXP002',
        expenseType: 'Listrik',
        amount: 300000,
        expenseDate: DateTime.now(),
        description: 'Tagihan listrik bulanan',
        category: 'Fixed',
        createdAt: DateTime.now(),
        status: 'completed',
      ),
      Expense(
        id: 'EXP003',
        expenseType: 'Sewa Tempat',
        amount: 1500000,
        expenseDate: DateTime.now(),
        description: 'Sewa ruko',
        category: 'Fixed',
        createdAt: DateTime.now(),
        status: 'completed',
      ),
      Expense(
        id: 'EXP004',
        expenseType: 'Marketing',
        amount: 200000,
        expenseDate: DateTime.now(),
        description: 'Promo media sosial',
        category: 'Variable',
        createdAt: DateTime.now(),
        status: 'completed',
      ),
      Expense(
        id: 'EXP005',
        expenseType: 'Transportasi',
        amount: 150000,
        expenseDate: DateTime.now(),
        description: 'Bahan baku delivery',
        category: 'Variable',
        createdAt: DateTime.now(),
        status: 'completed',
      ),
    ];
  }

  /// Generate mock order queue
  static List<OrderQueue> generateMockOrderQueue() {
    return [
      OrderQueue(
        id: 'ORD001',
        customerId: 'CUST001',
        customerName: 'Ahmad',
        items: [
          OrderItem(
            productId: 'PRD001',
            productName: 'Kopi Susu',
            quantity: 2,
            price: 15000,
          ),
          OrderItem(
            productId: 'PRD004',
            productName: 'Sandwich',
            quantity: 1,
            price: 25000,
          ),
        ],
        totalAmount: 55000,
        orderTime: DateTime.now().subtract(Duration(minutes: 15)),
        status: 'ready',
        paymentStatus: 'paid',
      ),
      OrderQueue(
        id: 'ORD002',
        customerId: 'CUST002',
        customerName: 'Siti',
        items: [
          OrderItem(
            productId: 'PRD002',
            productName: 'Americano',
            quantity: 1,
            price: 12000,
          ),
          OrderItem(
            productId: 'PRD005',
            productName: 'Croissant',
            quantity: 2,
            price: 20000,
          ),
        ],
        totalAmount: 52000,
        orderTime: DateTime.now().subtract(Duration(minutes: 8)),
        status: 'preparing',
        paymentStatus: 'paid',
      ),
      OrderQueue(
        id: 'ORD003',
        customerId: 'CUST003',
        customerName: 'Budi',
        items: [
          OrderItem(
            productId: 'PRD003',
            productName: 'Matcha Latte',
            quantity: 1,
            price: 18000,
            specialRequest: 'Extra hot',
          ),
        ],
        totalAmount: 18000,
        orderTime: DateTime.now().subtract(Duration(minutes: 2)),
        status: 'pending',
        paymentStatus: 'unpaid',
      ),
    ];
  }

  /// Generate mock business stats
  static BusinessStats generateMockBusinessStats() {
    return BusinessStats(
      ownerId: 'OWNER001',
      periodStart: DateTime.now().subtract(Duration(days: 30)),
      periodEnd: DateTime.now(),
      totalRevenue: 4525000,
      totalTransactionCount: 142,
      totalItemsSold: 453,
      averageTransactionValue: 31873,
      totalHPP: 1850000,
      totalExpenses: 4150000,
      totalCost: 6000000,
      grossProfit: 2675000,
      netProfit: -1475000, // Contoh: rugi karena biaya tinggi
      profitMargin: -32.56,
      dailyRevenue: {
        '2024-05-20': 250000,
        '2024-05-21': 320000,
        '2024-05-22': 280000,
        '2024-05-23': 410000,
        '2024-05-24': 380000,
        '2024-05-25': 450000,
      },
      topProducts: {
        'Teh Es Lemon': 203,
        'Kopi Susu': 150,
        'Croissant': 87,
      },
      revenueTrend: 12.5, // 12.5% increase
      expenseTrend: -5.2, // 5.2% decrease
    );
  }
}
