import '../models/business.dart';
import '../models/employee.dart';
import '../models/financial.dart';

class BusinessService {
  static final BusinessService _instance = BusinessService._internal();
  factory BusinessService() => _instance;
  BusinessService._internal();

  // Mock current business data
  Business get currentBusiness => Business(
    id: '1',
    name: 'Warung Makan Pak Budi',
    category: 'Warung Makan',
    description: 'Warung makan tradisional dengan menu khas Jawa Timur. Melayani sejak 1995.',
    address: 'Jl. Raya Malang No. 123, Kota Malang, Jawa Timur',
    phone: '+62 812-3456-7890',
    email: 'pakbudi@example.com',
    status: BusinessStatus.active,
    operatingHours: BusinessHours(
      monday: TimeRange(openTime: '06:00', closeTime: '22:00'),
      tuesday: TimeRange(openTime: '06:00', closeTime: '22:00'),
      wednesday: TimeRange(openTime: '06:00', closeTime: '22:00'),
      thursday: TimeRange(openTime: '06:00', closeTime: '22:00'),
      friday: TimeRange(openTime: '06:00', closeTime: '22:00'),
      saturday: TimeRange(openTime: '06:00', closeTime: '22:00'),
    ),
    createdAt: DateTime.now().subtract(const Duration(days: 365)),
  );

  Future<Business> updateBusiness(Business business) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    return business.copyWith(updatedAt: DateTime.now());
  }

  Future<List<Employee>> getEmployees() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      Employee(
        id: '1',
        name: 'Ahmad Rizki',
        position: 'Koki',
        salary: 2500000,
        bonus: 200000,
        deduction: 0,
        isPaid: true,
      ),
      Employee(
        id: '2',
        name: 'Siti Aminah',
        position: 'Pelayan',
        salary: 2000000,
        bonus: 150000,
        deduction: 50000,
        isPaid: false,
      ),
      Employee(
        id: '3',
        name: 'Budi Santoso',
        position: 'Kasir',
        salary: 2200000,
        bonus: 180000,
        deduction: 0,
        isPaid: false,
      ),
    ];
  }

  Future<Employee> updateEmployee(Employee employee) async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    return employee;
  }

  Future<Employee> payEmployee(String employeeId) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    // Return updated employee with payment status
    final employees = await getEmployees();
    final employee = employees.firstWhere((e) => e.id == employeeId);
    return employee.copyWith(
      isPaid: true,
      paymentDate: DateTime.now(),
    );
  }

  Future<FinancialSummary> getFinancialSummary({
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Mock data based on date range
    final days = toDate.difference(fromDate).inDays;
    
    if (days <= 1) {
      // Daily data
      return FinancialSummary(
        totalIncome: 2450000,
        totalExpenses: 850000,
        totalInvestment: 0,
        fromDate: fromDate,
        toDate: toDate,
      );
    } else if (days <= 7) {
      // Weekly data
      return FinancialSummary(
        totalIncome: 14500000,
        totalExpenses: 4200000,
        totalInvestment: 500000,
        fromDate: fromDate,
        toDate: toDate,
      );
    } else {
      // Monthly data
      return FinancialSummary(
        totalIncome: 78500000,
        totalExpenses: 24500000,
        totalInvestment: 2500000,
        fromDate: fromDate,
        toDate: toDate,
      );
    }
  }

  Future<List<FinancialRecord>> getFinancialRecords({
    required DateTime fromDate,
    required DateTime toDate,
    FinancialType? type,
    String? category,
  }) async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 600));
    
    // Mock financial records
    final records = <FinancialRecord>[
      FinancialRecord(
        id: '1',
        title: 'Penjualan Hari Ini',
        amount: 2450000,
        type: FinancialType.income,
        category: 'Penjualan',
        date: DateTime.now(),
        description: 'Total penjualan dari 87 transaksi',
      ),
      FinancialRecord(
        id: '2',
        title: 'Pembelian Bahan Baku',
        amount: 650000,
        type: FinancialType.expense,
        category: 'Bahan Operasional',
        date: DateTime.now(),
        description: 'Beli sayuran, daging, dan bumbu',
      ),
      FinancialRecord(
        id: '3',
        title: 'Bayar Listrik',
        amount: 200000,
        type: FinancialType.expense,
        category: 'Listrik',
        date: DateTime.now().subtract(const Duration(days: 1)),
        description: 'Tagihan listrik bulan ini',
      ),
    ];

    // Filter by type if specified
    if (type != null) {
      return records.where((r) => r.type == type).toList();
    }

    return records;
  }

  Future<List<ExpenseCategory>> getExpenseCategories() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 300));
    return ExpenseCategory.defaultCategories;
  }

  Future<FinancialRecord> addFinancialRecord(FinancialRecord record) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    return record;
  }

  Future<void> deleteFinancialRecord(String recordId) async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
  }

  // Dashboard KPI calculations
  Future<Map<String, dynamic>> getDashboardKPIs() async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    return {
      'omzet_hari_ini': 2450000,
      'transaksi_hari_ini': 87,
      'customer_hari_ini': 76,
      'produk_terjual': 143,
      'growth_omzet': 25.5, // percentage
      'growth_transaksi': 12.3,
      'growth_customer': 8.7,
      'growth_produk': 15.2,
    };
  }

  // Business insights
  Future<List<String>> getBusinessInsights() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      'Es Kopi Susu adalah produk terlaris hari ini dengan 45 gelas terjual',
      'Penjualan Roti Bakar turun 18% dibanding minggu lalu',
      'Omzet minggu ini meningkat 25% dari target',
      'Biaya operasional bulan ini 12% lebih tinggi dari bulan lalu',
    ];
  }
}