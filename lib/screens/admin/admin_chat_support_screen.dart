import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/models/admin.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class AdminChatSupportScreen extends StatefulWidget {
  const AdminChatSupportScreen({super.key});

  @override
  State<AdminChatSupportScreen> createState() =>
      _AdminChatSupportScreenState();
}

class _AdminChatSupportScreenState extends State<AdminChatSupportScreen> {
  late List<ChatTicket> ticketList;
  String selectedFilter = 'Semua'; // Semua, Open, Pending, Resolved
  String? selectedTicketId;

  @override
  void initState() {
    super.initState();
    ticketList = AdminMockData.generateMockChatTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Kelola Chat Support'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Row(
        children: [
          // Ticket List
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFilterTabs(),
                        const SizedBox(height: 16),
                        _buildStatistics(),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      'Tiket Terbuka',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  _buildTicketList(),
                ],
              ),
            ),
          ),
          // Chat View
          if (selectedTicketId != null)
            Expanded(
              flex: 2,
              child: _buildChatView(),
            )
          else
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat, size: 48, color: Colors.grey[300]),
                    const SizedBox(height: 12),
                    Text(
                      'Pilih tiket untuk memulai chat',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey[500],
                          ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ['Semua', 'Terbuka', 'Pending', 'Selesai']
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
    int totalTickets = ticketList.length;
    int openCount = ticketList.where((t) => t.status == 'open').length;
    int pendingCount = ticketList.where((t) => t.status == 'pending').length;
    int resolvedCount = ticketList.where((t) => t.status == 'resolved').length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Total',
            value: totalTickets.toString(),
            icon: Icons.all_inbox,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            title: 'Terbuka',
            value: openCount.toString(),
            icon: Icons.mail_outline,
            color: Colors.red,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            title: 'Selesai',
            value: resolvedCount.toString(),
            icon: Icons.done_all,
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey[600],
                  fontSize: 10,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketList() {
    List<ChatTicket> filteredTickets = ticketList.where((ticket) {
      if (selectedFilter == 'Terbuka') {
        return ticket.status == 'open';
      } else if (selectedFilter == 'Pending') {
        return ticket.status == 'pending';
      } else if (selectedFilter == 'Selesai') {
        return ticket.status == 'resolved';
      }
      return true;
    }).toList();

    if (filteredTickets.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.inbox, size: 48, color: Colors.grey[300]),
              const SizedBox(height: 12),
              Text(
                'Tidak ada tiket',
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
      children: filteredTickets
          .map((ticket) => _buildTicketCard(ticket))
          .toList(),
    );
  }

  Widget _buildTicketCard(ChatTicket ticket) {
    bool isSelected = selectedTicketId == ticket.id;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTicketId = ticket.id;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? ticket.statusColor.withOpacity(0.2) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? ticket.statusColor : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    ticket.customerName,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: ticket.priorityLevel >= 3
                        ? Colors.red.withOpacity(0.1)
                        : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    ticket.priorityDisplay,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ticket.priorityLevel >= 3
                              ? Colors.red
                              : Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              ticket.subject,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey[700],
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatView() {
    ChatTicket? selectedTicket;
    try {
      selectedTicket = ticketList.firstWhere((t) => t.id == selectedTicketId);
    } catch (e) {
      return Center(child: const Text('Tiket tidak ditemukan'));
    }

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey[200]!),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedTicket.subject,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Dari: ${selectedTicket.customerName}',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: selectedTicket.statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      selectedTicket.status.toUpperCase(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: selectedTicket.statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Messages
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: selectedTicket.messages.length,
            itemBuilder: (context, index) {
              ChatMessage msg = selectedTicket!.messages[index];
              bool isAdmin = msg.senderType == 'admin';

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: isAdmin
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth:
                            MediaQuery.of(context).size.width * 0.4,
                      ),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isAdmin ? Colors.blue : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            msg.senderName,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isAdmin ? Colors.white : Colors.black,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            msg.message,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color: isAdmin ? Colors.white : Colors.black,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${msg.timestamp.hour}:${msg.timestamp.minute.toString().padLeft(2, '0')}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  fontSize: 10,
                                  color: isAdmin
                                      ? Colors.white70
                                      : Colors.grey[600],
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // Input & Actions
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey[200]!),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quick Actions
              if (selectedTicket.status != 'resolved') ...[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (selectedTicket.status == 'open')
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                selectedTicket!.assign('ADMIN001');
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Tiket ditugaskan ke Anda'),
                                ),
                              );
                            },
                            icon: const Icon(Icons.person, size: 16),
                            label: const Text('Terima'),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: OutlinedButton.icon(
                          onPressed: () {
                            setState(() {
                              selectedTicket!.resolve();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Tiket ditandai selesai'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.done, size: 16),
                          label: const Text('Selesai'),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            selectedTicket!.close();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Tiket ditutup'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.close, size: 16),
                        label: const Text('Tutup'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
              // Message Input
              if (selectedTicket.status != 'closed')
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Ketik pesan...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                        maxLines: null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Pesan terkirim'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.send, size: 16),
                      label: const Text('Kirim'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
