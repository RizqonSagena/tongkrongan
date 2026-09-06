class Employee {
  final String id;
  final String name;
  final String position;
  final double salary;
  final double bonus;
  final double deduction;
  bool isPaid;
  final DateTime? paymentDate;

  Employee({
    required this.id,
    required this.name,
    required this.position,
    required this.salary,
    this.bonus = 0,
    this.deduction = 0,
    this.isPaid = false,
    this.paymentDate,
  });

  double get totalPayment => salary + bonus - deduction;

  Employee copyWith({
    String? id,
    String? name,
    String? position,
    double? salary,
    double? bonus,
    double? deduction,
    bool? isPaid,
    DateTime? paymentDate,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      salary: salary ?? this.salary,
      bonus: bonus ?? this.bonus,
      deduction: deduction ?? this.deduction,
      isPaid: isPaid ?? this.isPaid,
      paymentDate: paymentDate ?? this.paymentDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'salary': salary,
      'bonus': bonus,
      'deduction': deduction,
      'isPaid': isPaid,
      'paymentDate': paymentDate?.toIso8601String(),
    };
  }

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      salary: json['salary'].toDouble(),
      bonus: (json['bonus'] ?? 0).toDouble(),
      deduction: (json['deduction'] ?? 0).toDouble(),
      isPaid: json['isPaid'] ?? false,
      paymentDate: json['paymentDate'] != null 
          ? DateTime.parse(json['paymentDate'])
          : null,
    );
  }
}

enum EmployeePosition {
  koki,
  pelayan,
  kasir,
  cleaning,
  security,
  manager,
  other;

  String get displayName {
    switch (this) {
      case EmployeePosition.koki:
        return 'Koki';
      case EmployeePosition.pelayan:
        return 'Pelayan';
      case EmployeePosition.kasir:
        return 'Kasir';
      case EmployeePosition.cleaning:
        return 'Cleaning Service';
      case EmployeePosition.security:
        return 'Security';
      case EmployeePosition.manager:
        return 'Manager';
      case EmployeePosition.other:
        return 'Lainnya';
    }
  }
}