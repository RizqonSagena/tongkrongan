import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/models/admin.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  late Admin currentAdmin;
  late List<KedaiManagement> kedaiList;
  late List<Appointment> appointmentList;
  late List<ChatTicket> ticketList;

  @override
  void initState() {
    super.initState();
    currentAdmin = AdminMockData.generateMockAdmin();
    kedaiList = AdminMockData.generateMockKedaiManagement();
    appointmentList = AdminMockData.generateMockAppointments();
    ticketList = AdminMockData.generateMockChatTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pengaturan (Coming Soon)')),
                );
              },
              icon: const Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            _buildWelcomeCard(),

            const SizedBox(height: 24),

            // Task Overview (NO FINANSIAL)
            Text(
              'Tugas Hari Ini',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildTaskOverview(),

            const SizedBox(height: 28),

            // Quick Stats (Operational only, NO business data)
            Text(
              'Status Operasional',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildOperationalStats(),

            const SizedBox(height: 28),

            // Pending Appointments
            Text(
              'Janji Temu Menunggu',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildPendingAppointments(),

            const SizedBox(height: 28),

            // Urgent Tickets
            Text(
              'Tiket Urgent',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildUrgentTickets(),

            const SizedBox(height: 28),

            // Main Navigation
            Text(
              'Menu Utama',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildMainMenu(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primary, AppTheme.primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang, ${currentAdmin.name}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Role: ${currentAdmin.roleDisplayName}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text(
                  '⚙️',
                  style: TextStyle(fontSize: 28),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '✓ Operator Input Terbatas - NO Akses Finansial',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskOverview() {
    int pendingAppointments = appointmentList.where((a) => a.status == 'pending').length;
    int urgentTickets = ticketList.where((t) => t.priorityLevel >= 3).length;
    int inactiveKedai = kedaiList.where((k) => !k.isActive).length;

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.2,
      children: [
        _buildTaskCard(
          icon: Icons.calendar_today,
          label: 'Janji Temu',
          value: '$pendingAppointments',
          color: Colors.blue,
          subtitle: 'Menunggu',
        ),
        _buildTaskCard(
          icon: Icons.priority_high,
          label: 'Urgent',
          value: '$urgentTickets',
          color: Colors.red,
          subtitle: 'Tiket',
        ),
        _buildTaskCard(
          icon: Icons.store_mall_directory,
          label: 'Nonaktif',
          value: '$inactiveKedai',
          color: Colors.orange,
          subtitle: 'Kedai',
        ),
      ],
    );
  }

  Widget _buildTaskCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Colors.grey.shade500,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationalStats() {
    int activeKedai = kedaiList.where((k) => k.isActive).length;
    int totalKedai = kedaiList.length;
    int openAppointments = appointmentList.where((a) => a.status != 'completed' && a.status != 'cancelled').length;
    int openTickets = ticketList.where((t) => t.status == 'open' || t.status == 'pending').length;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(
          title: 'Kedai Aktif',
          value: '$activeKedai/$totalKedai',
          icon: Icons.store,
          color: Colors.green,
        ),
        _buildStatCard(
          title: 'Janji Terbuka',
          value: '$openAppointments',
          icon: Icons.calendar_month,
          color: Colors.blue,
        ),
        _buildStatCard(
          title: 'Tiket Terbuka',
          value: '$openTickets',
          icon: Icons.support_agent,
          color: Colors.orange,
        ),
        _buildStatCard(
          title: 'Konten Upload',
          value: '${AdminMockData.generateMockContent().length}',
          icon: Icons.image,
          color: Colors.purple,
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPendingAppointments() {
    final pending = appointmentList.where((a) => a.status == 'pending').toList();

    if (pending.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Tidak ada janji temu yang menunggu',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pending.take(3).length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final apt = pending[index];
        return GestureDetector(
          onTap: () => context.push('/admin-appointments'),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        apt.customerName,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        apt.formattedDateTime,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    apt.statusDisplay,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUrgentTickets() {
    final urgent = ticketList.where((t) => t.priorityLevel >= 3).toList();

    if (urgent.isEmpty) {
      return Text(
        'Tidak ada tiket urgent',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Colors.grey.shade600,
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: urgent.take(3).length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final ticket = urgent[index];
        return GestureDetector(
          onTap: () => context.push('/admin-chat-support'),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ticket.statusColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ticket.statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(ticket.priorityDisplay),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ticket.subject,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        ticket.customerName,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey.shade400),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainMenu() {
    final menuItems = [
      {
        'icon': Icons.store_mall_directory,
        'label': 'Kelola Kedai',
        'route': '/admin-kedai',
        'color': Colors.blue,
      },
      {
        'icon': Icons.shopping_bag,
        'label': 'Kelola Produk',
        'route': '/admin-products',
        'color': Colors.green,
      },
      {
        'icon': Icons.image,
        'label': 'Upload Konten',
        'route': '/admin-content',
        'color': Colors.purple,
      },
      {
        'icon': Icons.campaign,
        'label': 'Promo & Event',
        'route': '/admin-promo',
        'color': Colors.orange,
      },
      {
        'icon': Icons.calendar_today,
        'label': 'Janji Temu',
        'route': '/admin-appointments',
        'color': Colors.red,
      },
      {
        'icon': Icons.support_agent,
        'label': 'Chat Support',
        'route': '/admin-chat-support',
        'color': Colors.teal,
      },
      {
        'icon': Icons.schedule_send,
        'label': 'Social Media',
        'route': '/admin-social-media',
        'color': Colors.indigo,
      },
      {
        'icon': Icons.logout,
        'label': 'Logout',
        'route': '/admin-login',
        'color': Colors.grey,
      },
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: menuItems
          .map((item) => GestureDetector(
                onTap: () => context.push(item['route'] as String),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: (item['color'] as Color).withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        color: item['color'] as Color,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['label'] as String,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: (item['color'] as Color),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
