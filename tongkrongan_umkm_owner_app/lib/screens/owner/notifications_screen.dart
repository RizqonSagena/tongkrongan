import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/owner/bottom_navigation.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<BusinessNotification> allNotifications = [
    // Today
    BusinessNotification(
      id: '1',
      title: '🔥 Produk Terlaris Hari Ini',
      message: 'Es Kopi Susu menjadi produk terlaris hari ini dengan 45 gelas terjual.',
      type: NotificationType.trending,
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      isRead: false,
    ),
    BusinessNotification(
      id: '2',
      title: '⚠️ Stok Menipis',
      message: 'Stok Roti Bakar tinggal 8 porsi. Segera lakukan restock.',
      type: NotificationType.warning,
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      isRead: false,
    ),
    BusinessNotification(
      id: '3',
      title: '📈 Peningkatan Omzet',
      message: 'Omzet hari ini meningkat 25% dibanding kemarin (Rp 2.450.000).',
      type: NotificationType.growth,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: true,
    ),
    
    // This Week
    BusinessNotification(
      id: '4',
      title: '💰 Target Mingguan Tercapai',
      message: 'Selamat! Target omzet mingguan Rp 14.000.000 telah tercapai.',
      type: NotificationType.achievement,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
    BusinessNotification(
      id: '5',
      title: '⚠️ Biaya Operasional Tinggi',
      message: 'Biaya operasional minggu ini meningkat 12% dari minggu lalu.',
      type: NotificationType.warning,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isRead: false,
    ),
    BusinessNotification(
      id: '6',
      title: '👥 Pelanggan Baru',
      message: '23 pelanggan baru bergabung minggu ini. Total 412 pelanggan aktif.',
      type: NotificationType.customer,
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      isRead: true,
    ),
    
    // This Month
    BusinessNotification(
      id: '7',
      title: '🎯 Kinerja Bulanan Excellent',
      message: 'Laba bersih bulan ini mencapai Rp 38.200.000, naik 8% dari bulan lalu.',
      type: NotificationType.achievement,
      timestamp: DateTime.now().subtract(const Duration(days: 7)),
      isRead: true,
    ),
    BusinessNotification(
      id: '8',
      title: '📊 Analisis Produk',
      message: 'Menu minuman mendominasi 68% dari total penjualan bulan ini.',
      type: NotificationType.insight,
      timestamp: DateTime.now().subtract(const Duration(days: 10)),
      isRead: true,
    ),
    BusinessNotification(
      id: '9',
      title: '🔔 Reminder: Gaji Pegawai',
      message: 'Jangan lupa bayar gaji 3 pegawai. Total: Rp 6.500.000.',
      type: NotificationType.reminder,
      timestamp: DateTime.now().subtract(const Duration(days: 14)),
      isRead: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<BusinessNotification> get unreadNotifications => 
      allNotifications.where((n) => !n.isRead).toList();

  List<BusinessNotification> get readNotifications => 
      allNotifications.where((n) => n.isRead).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notifikasi Bisnis',
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
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black87),
            onPressed: () => _showNotificationSettings(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue[800],
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: Colors.blue[800],
          tabs: [
            Tab(text: 'Semua (${allNotifications.length})'),
            Tab(text: 'Belum Dibaca (${unreadNotifications.length})'),
            Tab(text: 'Sudah Dibaca (${readNotifications.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationList(allNotifications),
          _buildNotificationList(unreadNotifications),
          _buildNotificationList(readNotifications),
        ],
      ),
      bottomNavigationBar: const OwnerBottomNavigation(currentIndex: 4),
      floatingActionButton: unreadNotifications.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: _markAllAsRead,
              backgroundColor: Colors.blue[600],
              icon: const Icon(Icons.done_all, color: Colors.white),
              label: const Text(
                'Tandai Semua Dibaca',
                style: TextStyle(color: Colors.white),
              ),
            )
          : null,
    );
  }

  Widget _buildNotificationList(List<BusinessNotification> notifications) {
    if (notifications.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return _buildNotificationCard(notifications[index]);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak ada notifikasi',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(BusinessNotification notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: notification.isRead ? Colors.white : Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: notification.isRead 
              ? Colors.grey[200]! 
              : Colors.blue[200]!,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _markAsRead(notification),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getNotificationTypeColor(notification.type).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getNotificationTypeIcon(notification.type),
                    color: _getNotificationTypeColor(notification.type),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: notification.isRead 
                                    ? FontWeight.w600 
                                    : FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          if (!notification.isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notification.message,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatTimestamp(notification.timestamp),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[500],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getNotificationTypeColor(notification.type).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              _getNotificationTypeText(notification.type),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _getNotificationTypeColor(notification.type),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getNotificationTypeColor(NotificationType type) {
    switch (type) {
      case NotificationType.trending:
        return Colors.orange;
      case NotificationType.warning:
        return Colors.red;
      case NotificationType.growth:
        return Colors.green;
      case NotificationType.achievement:
        return Colors.purple;
      case NotificationType.customer:
        return Colors.blue;
      case NotificationType.insight:
        return Colors.teal;
      case NotificationType.reminder:
        return Colors.amber;
    }
  }

  IconData _getNotificationTypeIcon(NotificationType type) {
    switch (type) {
      case NotificationType.trending:
        return Icons.local_fire_department;
      case NotificationType.warning:
        return Icons.warning;
      case NotificationType.growth:
        return Icons.trending_up;
      case NotificationType.achievement:
        return Icons.emoji_events;
      case NotificationType.customer:
        return Icons.people;
      case NotificationType.insight:
        return Icons.lightbulb;
      case NotificationType.reminder:
        return Icons.notifications;
    }
  }

  String _getNotificationTypeText(NotificationType type) {
    switch (type) {
      case NotificationType.trending:
        return 'TRENDING';
      case NotificationType.warning:
        return 'PERINGATAN';
      case NotificationType.growth:
        return 'PERTUMBUHAN';
      case NotificationType.achievement:
        return 'PENCAPAIAN';
      case NotificationType.customer:
        return 'PELANGGAN';
      case NotificationType.insight:
        return 'INSIGHT';
      case NotificationType.reminder:
        return 'PENGINGAT';
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari lalu';
    } else {
      return '${difference.inDays ~/ 7} minggu lalu';
    }
  }

  void _markAsRead(BusinessNotification notification) {
    if (!notification.isRead) {
      setState(() {
        notification.isRead = true;
      });
    }
    
    // Show notification detail
    _showNotificationDetail(notification);
  }

  void _markAllAsRead() {
    setState(() {
      for (final notification in allNotifications) {
        notification.isRead = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Semua notifikasi telah ditandai sebagai dibaca'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showNotificationDetail(BusinessNotification notification) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(notification.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.message),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getNotificationTypeColor(notification.type).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _getNotificationTypeText(notification.type),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: _getNotificationTypeColor(notification.type),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  _formatTimestamp(notification.timestamp),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          if (notification.type == NotificationType.reminder ||
              notification.type == NotificationType.warning)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _handleNotificationAction(notification);
              },
              child: const Text('Tindak Lanjut'),
            ),
        ],
      ),
    );
  }

  void _handleNotificationAction(BusinessNotification notification) {
    if (notification.id == '2') {
      // Navigate to product management
      Navigator.pushNamed(context, '/products');
    } else if (notification.id == '9') {
      // Navigate to employee salary
      Navigator.pushNamed(context, '/employee-salary');
    }
  }

  void _showNotificationSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pengaturan Notifikasi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text('Notifikasi Penjualan'),
              subtitle: const Text('Trending produk, pencapaian target'),
              value: true,
              onChanged: (value) {},
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text('Peringatan Stok'),
              subtitle: const Text('Stok menipis, kehabisan produk'),
              value: true,
              onChanged: (value) {},
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text('Insight Bisnis'),
              subtitle: const Text('Analisis dan rekomendasi'),
              value: true,
              onChanged: (value) {},
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text('Pengingat'),
              subtitle: const Text('Gaji pegawai, pembayaran'),
              value: true,
              onChanged: (value) {},
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pengaturan notifikasi disimpan'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}

enum NotificationType {
  trending,
  warning,
  growth,
  achievement,
  customer,
  insight,
  reminder,
}

class BusinessNotification {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  bool isRead;

  BusinessNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    required this.isRead,
  });
}