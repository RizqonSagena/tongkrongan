import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/models/admin.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class AdminAppointmentsScreen extends StatefulWidget {
  const AdminAppointmentsScreen({super.key});

  @override
  State<AdminAppointmentsScreen> createState() =>
      _AdminAppointmentsScreenState();
}

class _AdminAppointmentsScreenState extends State<AdminAppointmentsScreen> {
  late List<Appointment> appointmentList;
  String selectedFilter = 'Semua'; // Semua, Pending, Confirmed, Completed

  @override
  void initState() {
    super.initState();
    appointmentList = AdminMockData.generateMockAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Kelola Janji Temu'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Tabs
            _buildFilterTabs(),
            const SizedBox(height: 16),

            // Statistics
            _buildStatistics(),
            const SizedBox(height: 24),

            // Appointment List
            Text(
              'Daftar Janji Temu',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _buildAppointmentList(),

            const SizedBox(height: 24),

            // Info Banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info, color: Colors.teal, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '📅 Kelola permintaan janji temu dari customer',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ['Semua', 'Menunggu', 'Terkonfirmasi', 'Selesai']
            .map((filter) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filter),
                    selected: selectedFilter == filter,
                    onSelected: (selected) {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildStatistics() {
    int totalAppointments = appointmentList.length;
    int pendingCount =
        appointmentList.where((a) => a.status == 'pending').length;
    int confirmedCount =
        appointmentList.where((a) => a.status == 'confirmed').length;
    int completedCount =
        appointmentList.where((a) => a.status == 'completed').length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Total',
            value: totalAppointments.toString(),
            icon: Icons.calendar_today,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Menunggu',
            value: pendingCount.toString(),
            icon: Icons.hourglass_empty,
            color: Colors.orange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Dikonfirmasi',
            value: confirmedCount.toString(),
            icon: Icons.check_circle,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentList() {
    List<Appointment> filteredAppointments =
        appointmentList.where((appointment) {
      if (selectedFilter == 'Menunggu') {
        return appointment.status == 'pending';
      } else if (selectedFilter == 'Terkonfirmasi') {
        return appointment.status == 'confirmed';
      } else if (selectedFilter == 'Selesai') {
        return appointment.status == 'completed';
      }
      return true;
    }).toList();

    if (filteredAppointments.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              Icon(Icons.calendar_today, size: 48, color: Colors.grey[300]),
              const SizedBox(height: 12),
              Text(
                'Belum ada janji temu',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey[500],
                    ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: filteredAppointments
          .map((appointment) => _buildAppointmentCard(appointment))
          .toList(),
    );
  }

  Widget _buildAppointmentCard(Appointment appointment) {
    Color statusColor = appointment.status == 'pending'
        ? Colors.orange
        : appointment.status == 'confirmed'
            ? Colors.green
            : appointment.status == 'completed'
                ? Colors.blue
                : Colors.grey;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Name & Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.customerName,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      appointment.customerPhone,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  appointment.statusDisplay,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Appointment Details Grid
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailItem(
                        label: 'Tanggal & Jam',
                        value: appointment.formattedDateTime,
                        icon: Icons.calendar_today,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDetailItem(
                        label: 'Jumlah Orang',
                        value: '${appointment.numberOfPeople} orang',
                        icon: Icons.people,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailItem(
                        label: 'Tujuan',
                        value: appointment.purpose,
                        icon: Icons.info,
                      ),
                    ),
                  ],
                ),
                if (appointment.notes != null &&
                    appointment.notes!.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailItem(
                          label: 'Catatan',
                          value: appointment.notes!,
                          icon: Icons.note,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Action Buttons
          if (appointment.status == 'pending') ...[
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        appointment.confirm('ADMIN001');
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Janji temu dikonfirmasi'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.check, size: 16),
                    label: const Text('Terima'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        appointment.reject('ADMIN001');
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Janji temu ditolak'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.close, size: 16),
                    label: const Text('Tolak'),
                  ),
                ),
              ],
            ),
          ] else if (appointment.status == 'confirmed') ...[
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  appointment.complete();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Janji temu ditandai selesai'),
                  ),
                );
              },
              icon: const Icon(Icons.done_all, size: 16),
              label: const Text('Tandai Selesai'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: Colors.grey[600]),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey[600],
                    fontSize: 11,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w600,
              ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
