import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/models/owner.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class OwnerOrderQueueScreen extends StatefulWidget {
  const OwnerOrderQueueScreen({super.key});

  @override
  State<OwnerOrderQueueScreen> createState() => _OwnerOrderQueueScreenState();
}

class _OwnerOrderQueueScreenState extends State<OwnerOrderQueueScreen> {
  late List<OrderQueue> orders;
  String selectedFilter = 'Aktif'; // Aktif, Pending, Preparing, Ready, Completed

  @override
  void initState() {
    super.initState();
    orders = OwnerMockData.generateMockOrderQueue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Antrian Pesanan'),
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

            // Orders List (KDS View)
            Text(
              'Pesanan ${selectedFilter == 'Aktif' ? '(Live Kitchen Display)' : ''}',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildOrdersList(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    final filters = ['Aktif', 'Pending', 'Preparing', 'Ready', 'Completed'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters
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
                    backgroundColor: Colors.grey.shade200,
                    selectedColor: AppTheme.primary,
                    labelStyle: TextStyle(
                      color: selectedFilter == filter ? Colors.white : Colors.black,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildStatistics() {
    int pending = orders.where((o) => o.status == 'pending').length;
    int preparing = orders.where((o) => o.status == 'preparing').length;
    int ready = orders.where((o) => o.status == 'ready').length;
    int completed = orders.where((o) => o.status == 'completed').length;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: [
        _buildStatCard(
          label: 'Menunggu',
          value: '$pending',
          color: Colors.orange,
          icon: Icons.schedule,
        ),
        _buildStatCard(
          label: 'Sedang Diproses',
          value: '$preparing',
          color: Colors.blue,
          icon: Icons.local_shipping,
        ),
        _buildStatCard(
          label: 'Siap Ambil',
          value: '$ready',
          color: Colors.green,
          icon: Icons.check_circle,
        ),
        _buildStatCard(
          label: 'Selesai',
          value: '$completed',
          color: Colors.grey,
          icon: Icons.done_all,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required Color color,
    required IconData icon,
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
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList() {
    List<OrderQueue> filtered = _getFilteredOrders();

    if (filtered.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(Icons.inbox, size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                'Tidak ada pesanan',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Sort by priority: pending first, then by wait time
    filtered.sort((a, b) {
      if (a.status == 'pending' && b.status != 'pending') return -1;
      if (a.status != 'pending' && b.status == 'pending') return 1;
      return b.waitTimeMinutes.compareTo(a.waitTimeMinutes);
    });

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filtered.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _buildOrderCard(filtered[index], index + 1),
    );
  }

  Widget _buildOrderCard(OrderQueue order, int position) {
    final isPriority = order.status == 'pending';
    final urgency = order.waitTimeMinutes > 10 ? 'Urgent' : '';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPriority ? Colors.orange.shade600 : Colors.grey.shade200,
          width: isPriority ? 2 : 1,
        ),
        boxShadow: isPriority
            ? [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getStatusColor(order.status).withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(order.status),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'ORD #${order.id.substring(0, 5)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            order.customerName,
                            style:
                                Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              size: 14, color: Colors.grey.shade600),
                          const SizedBox(width: 4),
                          Text(
                            order.formattedTime,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.hourglass_bottom,
                              size: 14, color: Colors.grey.shade600),
                          const SizedBox(width: 4),
                          Text(
                            '${order.waitTimeMinutes} min',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: order.waitTimeMinutes > 10
                                  ? Colors.red
                                  : Colors.grey.shade600,
                              fontWeight: order.waitTimeMinutes > 10
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (urgency.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      urgency,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Items
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pesanan:',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Column(
                  children: order.items
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${item.quantity}x ${item.productName}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      if (item.specialRequest != null &&
                                          item.specialRequest!.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 2),
                                          child: Text(
                                            '✓ ${item.specialRequest}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: Colors.blue,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Rp${item.subtotal.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 8),
                Divider(color: Colors.grey.shade300),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rp${order.totalAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    label: _getNextActionLabel(order.status),
                    onPressed: () => _updateOrderStatus(order),
                    color: _getStatusColor(order.status),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildActionButton(
                    label: 'Detail',
                    onPressed: () => _showOrderDetail(order),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 10),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'preparing':
        return Colors.blue;
      case 'ready':
        return Colors.green;
      case 'completed':
        return Colors.grey;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getNextActionLabel(String status) {
    switch (status) {
      case 'pending':
        return 'Mulai Proses';
      case 'preparing':
        return 'Siap Ambil';
      case 'ready':
        return 'Selesaikan';
      case 'completed':
        return 'Selesai';
      default:
        return 'Update';
    }
  }

  void _updateOrderStatus(OrderQueue order) {
    setState(() {
      switch (order.status) {
        case 'pending':
          order.status = 'preparing';
          break;
        case 'preparing':
          order.status = 'ready';
          break;
        case 'ready':
          order.status = 'completed';
          order.completionTime = DateTime.now();
          break;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pesanan ${order.id} diperbarui ke ${order.status}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showOrderDetail(OrderQueue order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Detail Pesanan ${order.id}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _detailRow('Customer', order.customerName),
              _detailRow('Status', order.status.toUpperCase()),
              _detailRow('Waktu Pesanan', order.formattedTime),
              _detailRow('Waktu Tunggu', '${order.waitTimeMinutes} menit'),
              _detailRow('Pembayaran', order.paymentStatus),
              _detailRow('Total', 'Rp${order.totalAmount.toStringAsFixed(0)}'),
              if (order.notes != null && order.notes!.isNotEmpty)
                _detailRow('Catatan', order.notes!),
              const SizedBox(height: 12),
              Text(
                'Item Pesanan:',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...order.items
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          '${item.quantity}x ${item.productName}${item.specialRequest != null ? ' (${item.specialRequest})' : ''}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ))
                  .toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  List<OrderQueue> _getFilteredOrders() {
    switch (selectedFilter) {
      case 'Aktif':
        return orders.where((o) => o.status != 'completed').toList();
      case 'Pending':
        return orders.where((o) => o.status == 'pending').toList();
      case 'Preparing':
        return orders.where((o) => o.status == 'preparing').toList();
      case 'Ready':
        return orders.where((o) => o.status == 'ready').toList();
      case 'Completed':
        return orders.where((o) => o.status == 'completed').toList();
      default:
        return orders;
    }
  }
}
