class FinancialRecord {
  final String id;
  final String title;
  final double amount;
  final FinancialType type;
  final String category;
  final DateTime date;
  final String? description;
  final String? reference;

  FinancialRecord({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    this.description,
    this.reference,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'type': type.name,
      'category': category,
      'date': date.toIso8601String(),
      'description': description,
      'reference': reference,
    };
  }

  factory FinancialRecord.fromJson(Map<String, dynamic> json) {
    return FinancialRecord(
      id: json['id'],
      title: json['title'],
      amount: json['amount'].toDouble(),
      type: FinancialType.values.byName(json['type']),
      category: json['category'],
      date: DateTime.parse(json['date']),
      description: json['description'],
      reference: json['reference'],
    );
  }
}

enum FinancialType {
  income,
  expense,
  investment;

  String get displayName {
    switch (this) {
      case FinancialType.income:
        return 'Pendapatan';
      case FinancialType.expense:
        return 'Pengeluaran';
      case FinancialType.investment:
        return 'Investasi';
    }
  }
}

class FinancialSummary {
  final double totalIncome;
  final double totalExpenses;
  final double totalInvestment;
  final double grossProfit;
  final double netProfit;
  final DateTime fromDate;
  final DateTime toDate;

  FinancialSummary({
    required this.totalIncome,
    required this.totalExpenses,
    required this.totalInvestment,
    required this.fromDate,
    required this.toDate,
  })  : grossProfit = totalIncome - totalExpenses,
        netProfit = totalIncome - totalExpenses - totalInvestment;

  double get profitMargin => totalIncome > 0 ? (netProfit / totalIncome) * 100 : 0;
  
  Map<String, dynamic> toJson() {
    return {
      'totalIncome': totalIncome,
      'totalExpenses': totalExpenses,
      'totalInvestment': totalInvestment,
      'grossProfit': grossProfit,
      'netProfit': netProfit,
      'profitMargin': profitMargin,
      'fromDate': fromDate.toIso8601String(),
      'toDate': toDate.toIso8601String(),
    };
  }
}

class ExpenseCategory {
  final String id;
  final String name;
  final String icon;
  final double budgetLimit;
  final double currentAmount;

  ExpenseCategory({
    required this.id,
    required this.name,
    required this.icon,
    this.budgetLimit = 0,
    this.currentAmount = 0,
  });

  double get percentageUsed => budgetLimit > 0 ? (currentAmount / budgetLimit) * 100 : 0;
  bool get isOverBudget => currentAmount > budgetLimit && budgetLimit > 0;

  static List<ExpenseCategory> defaultCategories = [
    ExpenseCategory(id: '1', name: 'Sewa Tempat', icon: '🏠'),
    ExpenseCategory(id: '2', name: 'Pembelian Alat', icon: '🔧'),
    ExpenseCategory(id: '3', name: 'Renovasi', icon: '🔨'),
    ExpenseCategory(id: '4', name: 'Peralatan Dapur', icon: '🍳'),
    ExpenseCategory(id: '5', name: 'Bahan Operasional', icon: '📦'),
    ExpenseCategory(id: '6', name: 'Listrik', icon: '⚡'),
    ExpenseCategory(id: '7', name: 'Air', icon: '💧'),
    ExpenseCategory(id: '8', name: 'Transportasi', icon: '🚗'),
    ExpenseCategory(id: '9', name: 'Gaji Pegawai', icon: '👥'),
    ExpenseCategory(id: '10', name: 'Lainnya', icon: '📋'),
  ];
}