import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tongkrongan_umkm_owner_app/models/customer.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class CustomerReservationScreen extends StatefulWidget {
  final String kedaiId;

  const CustomerReservationScreen({
    super.key,
    required this.kedaiId,
  });

  @override
  State<CustomerReservationScreen> createState() => _CustomerReservationScreenState();
}

class _CustomerReservationScreenState extends State<CustomerReservationScreen> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  String _selectedPurpose = 'Reservasi';
  int? _numberOfPeople;
  final TextEditingController _notesController = TextEditingController();

  late Kedai _kedai;

  final List<String> _purposes = [
    'Reservasi Meja',
    'Rayakan Acara',
    'Meeting/Diskusi',
    'Kunjungan Biasa',
    'Lainnya',
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    _initializeMockData();
  }

  void _initializeMockData() {
    _kedai = Kedai(
      id: widget.kedaiId,
      name: 'Nasi Kuning Pak Hendra',
      description: 'Nasi kuning tradisional dengan lauk pauk pilihan',
      category: 'Nasi Kuning',
      imageUrl: 'https://via.placeholder.com/300x200?text=Nasi+Kuning',
      address: 'Jl. Raya Bogor No. 123',
      latitude: -6.2088,
      longitude: 106.8456,
      phoneNumber: '08123456789',
      rating: 4.8,
      totalRatings: 156,
      isOpen: true,
      openingHours: '08:00 - 22:00',
      distanceFromCustomer: 1.2,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Buat Reservasi'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kedai Info
            _buildKedaiInfo(),
            const SizedBox(height: 24),

            // Tanggal Reservasi
            _buildSectionTitle('Tanggal Reservasi'),
            const SizedBox(height: 8),
            _buildDatePicker(),
            const SizedBox(height: 24),

            // Jam Reservasi
            _buildSectionTitle('Jam Reservasi'),
            const SizedBox(height: 8),
            _buildTimePicker(),
            const SizedBox(height: 24),

            // Tujuan Reservasi
            _buildSectionTitle('Tujuan Reservasi'),
            const SizedBox(height: 8),
            _buildPurposeDropdown(),
            const SizedBox(height: 24),

            // Jumlah Orang
            _buildSectionTitle('Jumlah Orang'),
            const SizedBox(height: 8),
            _buildNumberOfPeopleInput(),
            const SizedBox(height: 24),

            // Catatan
            _buildSectionTitle('Catatan (Opsional)'),
            const SizedBox(height: 8),
            _buildNotesInput(),
            const SizedBox(height: 24),

            // Info Box
            _buildInfoBox(),
            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _numberOfPeople != null && _numberOfPeople! > 0
                    ? _submitReservation
                    : null,
                icon: const Icon(Icons.calendar_today),
                label: const Text('Ajukan Reservasi'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Cancel Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.pop(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Batal'),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildKedaiInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              _kedai.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _kedai.name,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        _kedai.address,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      '${_kedai.rating} (${_kedai.totalRatings})',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 90)),
        );
        if (picked != null) {
          setState(() {
            _selectedDate = picked;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(_selectedDate),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Icon(Icons.calendar_today, color: AppTheme.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return GestureDetector(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: _selectedTime,
        );
        if (picked != null) {
          setState(() {
            _selectedTime = picked;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedTime.format(context),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Icon(Icons.access_time, color: AppTheme.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildPurposeDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: _selectedPurpose,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _selectedPurpose = value;
            });
          }
        },
        items: _purposes
            .map((purpose) => DropdownMenuItem(
              value: purpose,
              child: Text(purpose),
            ))
            .toList(),
      ),
    );
  }

  Widget _buildNumberOfPeopleInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: _numberOfPeople != null && _numberOfPeople! > 1
                ? () {
                    setState(() {
                      _numberOfPeople = _numberOfPeople! - 1;
                    });
                  }
                : null,
            icon: const Icon(Icons.remove),
          ),
          Expanded(
            child: TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Jumlah orang',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              initialValue: _numberOfPeople?.toString(),
              onChanged: (value) {
                final number = int.tryParse(value);
                if (number != null && number > 0) {
                  setState(() {
                    _numberOfPeople = number;
                  });
                }
              },
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _numberOfPeople = (_numberOfPeople ?? 0) + 1;
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesInput() {
    return TextField(
      controller: _notesController,
      decoration: InputDecoration(
        hintText: 'Contoh: Kami ingin meja dekat jendela, atau ada acara khusus, dll',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      maxLines: 3,
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info, color: Colors.blue, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Informasi Penting',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '• Reservasi Anda akan diajukan ke pengelola Tongkrongan\n'
            '• Pengelola akan mengkomunikasikan dengan pemilik kedai\n'
            '• Anda akan menerima konfirmasi via chat atau notifikasi\n'
            '• Jam operasional kedai: ${_kedai.openingHours}',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.blue.shade700,
            ),
          ),
        ],
      ),
    );
  }

  void _submitReservation() {
    if (_numberOfPeople == null || _numberOfPeople! <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap masukkan jumlah orang'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Create reservation object
    final reservation = Reservation(
      id: 'res-${DateTime.now().millisecondsSinceEpoch}',
      customerId: 'cust-123',
      customerName: 'Budi Santoso',
      kedaiId: widget.kedaiId,
      kedaiName: _kedai.name,
      reservationDate: _selectedDate,
      reservationTime: '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
      purpose: _selectedPurpose,
      numberOfPeople: _numberOfPeople,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
      status: ReservationStatus.pending,
      createdAt: DateTime.now(),
    );

    // Show success dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
          title: const Text('Reservasi Berhasil Diajukan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nomor Reservasi: ${reservation.id}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Pengelola akan segera mengkonfirmasi reservasi Anda melalui chat atau notifikasi. Silakan tunggu beberapa saat.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                context.pop(); // Pop reservation screen
              },
              child: const Text('Kembali'),
            ),
            ElevatedButton(
              onPressed: () {
                context.pop(); // Pop dialog
                context.push('/management-chat/${widget.kedaiId}');
              },
              child: const Text('Chat dengan Pengelola'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}
