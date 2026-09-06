import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/owner/bottom_navigation.dart';

class EmployeeSalaryScreen extends StatefulWidget {
  const EmployeeSalaryScreen({super.key});

  @override
  State<EmployeeSalaryScreen> createState() => _EmployeeSalaryScreenState();
}

class _EmployeeSalaryScreenState extends State<EmployeeSalaryScreen> {
  final List<Employee> employees = [
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
    Employee(
      id: '4',
      name: 'Dewi Sartika',
      position: 'Cleaning Service',
      salary: 1800000,
      bonus: 100000,
      deduction: 0,
      isPaid: true,
    ),
  ];

  int get totalUnpaidEmployees => employees.where((e) => !e.isPaid).length;
  double get totalUnpaidAmount => employees
      .where((e) => !e.isPaid)
      .fold(0, (sum, e) => sum + e.totalPayment);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Gaji Pegawai',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    'Total Pegawai',
                    employees.length.toString(),
                    Icons.people,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    'Belum Dibayar',
                    totalUnpaidEmployees.toString(),
                    Icons.schedule,
                    Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildSummaryCard(
              'Total Gaji Belum Dibayar',
              'Rp ${_formatNumber(totalUnpaidAmount.toInt())}',
              Icons.payments,
              Colors.red,
              isWide: true,
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showAddEmployeeDialog(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Tambah Pegawai'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: totalUnpaidEmployees > 0 
                        ? () => _showPayAllDialog(context) 
                        : null,
                    icon: const Icon(Icons.payment),
                    label: const Text('Bayar Semua'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Employee List
            const Text(
              'Daftar Pegawai',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            
            ...employees.map((employee) => _buildEmployeeCard(employee)),
          ],
        ),
      ),
      bottomNavigationBar: const OwnerBottomNavigation(currentIndex: 4),
    );
  }

  Widget _buildSummaryCard(
    String title, 
    String value, 
    IconData icon, 
    Color color, 
    {bool isWide = false}
  ) {
    return Container(
      width: isWide ? double.infinity : null,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: isWide ? 20 : 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeCard(Employee employee) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: Text(
                  employee.name.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      employee.position,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: employee.isPaid 
                      ? Colors.green[100] 
                      : Colors.orange[100],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  employee.isPaid ? 'SUDAH DIBAYAR' : 'BELUM DIBAYAR',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: employee.isPaid 
                        ? Colors.green[800] 
                        : Colors.orange[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Salary Details
          Row(
            children: [
              Expanded(
                child: _buildSalaryDetail('Gaji Pokok', employee.salary),
              ),
              Expanded(
                child: _buildSalaryDetail('Bonus', employee.bonus),
              ),
              Expanded(
                child: _buildSalaryDetail('Potongan', employee.deduction),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Gaji:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Rp ${_formatNumber(employee.totalPayment.toInt())}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          
          if (!employee.isPaid) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _payEmployee(employee),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Bayar Gaji',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSalaryDetail(String label, double amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Rp ${_formatNumber(amount.toInt())}',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  void _payEmployee(Employee employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Pembayaran'),
        content: Text(
          'Apakah Anda yakin ingin membayar gaji ${employee.name} sebesar Rp ${_formatNumber(employee.totalPayment.toInt())}?'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                employee.isPaid = true;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Gaji ${employee.name} berhasil dibayar'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Bayar'),
          ),
        ],
      ),
    );
  }

  void _showPayAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bayar Semua Gaji'),
        content: Text(
          'Apakah Anda yakin ingin membayar semua gaji yang belum dibayar?\n\nTotal: Rp ${_formatNumber(totalUnpaidAmount.toInt())}'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                for (final employee in employees) {
                  if (!employee.isPaid) {
                    employee.isPaid = true;
                  }
                }
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Semua gaji berhasil dibayar'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Bayar Semua'),
          ),
        ],
      ),
    );
  }

  void _showAddEmployeeDialog(BuildContext context) {
    final nameController = TextEditingController();
    final positionController = TextEditingController();
    final salaryController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Pegawai'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Pegawai',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: positionController,
              decoration: const InputDecoration(
                labelText: 'Posisi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: salaryController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Gaji Pokok',
                border: OutlineInputBorder(),
                prefixText: 'Rp ',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  positionController.text.isNotEmpty &&
                  salaryController.text.isNotEmpty) {
                setState(() {
                  employees.add(Employee(
                    id: (employees.length + 1).toString(),
                    name: nameController.text,
                    position: positionController.text,
                    salary: double.parse(salaryController.text),
                    bonus: 0,
                    deduction: 0,
                    isPaid: false,
                  ));
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pegawai berhasil ditambahkan'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]}.',
    );
  }
}

class Employee {
  final String id;
  final String name;
  final String position;
  final double salary;
  final double bonus;
  final double deduction;
  bool isPaid;

  Employee({
    required this.id,
    required this.name,
    required this.position,
    required this.salary,
    required this.bonus,
    required this.deduction,
    required this.isPaid,
  });

  double get totalPayment => salary + bonus - deduction;
}