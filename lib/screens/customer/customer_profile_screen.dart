import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  bool _isEditMode = false;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  // Mock user data
  final String _userName = 'Ahmad Rizki';
  final String _userEmail = 'ahmad.rizki@email.com';
  final String _userPhone = '+62 812-3456-7890';
  final String _memberSince = '15 Mei 2024';
  final int _totalReservations = 12;
  final int _totalReviews = 8;
  final int _favoriteKedai = 5;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _userName);
    _emailController = TextEditingController(text: _userEmail);
    _phoneController = TextEditingController(text: _userPhone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Profil Saya'),
        centerTitle: true,
        elevation: 0,
        actions: [
          if (!_isEditMode)
            Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _isEditMode = true;
                  });
                },
                icon: const Icon(Icons.edit),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Profile Header
            _buildProfileHeader(),

            const SizedBox(height: 32),

            // Profile Information
            _buildProfileInfo(),

            const SizedBox(height: 32),

            // Statistics
            _buildStatistics(),

            const SizedBox(height: 32),

            // Menu Items
            _buildMenuItems(),

            const SizedBox(height: 32),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _logout,
                icon: const Icon(Icons.logout),
                label: const Text('Keluar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: AppTheme.primary.withOpacity(0.2),
                child: Text(
                  _userName[0],
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _userName,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Member sejak $_memberSince',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informasi Akun',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildInfoField(
          label: 'Nama Lengkap',
          value: _userName,
          controller: _nameController,
        ),
        const SizedBox(height: 12),
        _buildInfoField(
          label: 'Email',
          value: _userEmail,
          controller: _emailController,
        ),
        const SizedBox(height: 12),
        _buildInfoField(
          label: 'Nomor Telepon',
          value: _userPhone,
          controller: _phoneController,
        ),
        if (_isEditMode) ...[
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _isEditMode = false;
                      _nameController.text = _userName;
                      _emailController.text = _userEmail;
                      _phoneController.text = _userPhone;
                    });
                  },
                  child: const Text('Batal'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildInfoField({
    required String label,
    required String value,
    required TextEditingController controller,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          if (_isEditMode)
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            )
          else
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Statistik',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.bookmark,
                label: 'Favorit',
                value: '$_favoriteKedai',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.calendar_today,
                label: 'Reservasi',
                value: '$_totalReservations',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.star,
                label: 'Ulasan',
                value: '$_totalReviews',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primary.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppTheme.primary,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    final menuItems = [
      {
        'icon': Icons.bookmark,
        'label': 'Kedai Favorit',
        'route': '/customer-favorites',
      },
      {
        'icon': Icons.calendar_today,
        'label': 'Riwayat Reservasi',
        'route': '/customer-reservations-history',
      },
      {
        'icon': Icons.star,
        'label': 'Ulasan Saya',
        'route': '/customer-reviews',
      },
      {
        'icon': Icons.message,
        'label': 'Chat dengan Pengelola',
        'route': '/management-chat',
      },
      {
        'icon': Icons.settings,
        'label': 'Pengaturan',
        'route': '/customer-settings',
      },
      {
        'icon': Icons.info,
        'label': 'Tentang TONGkrongan',
        'route': '/customer-about',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Menu Lainnya',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: menuItems.length,
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey.shade200,
            height: 1,
          ),
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return ListTile(
              leading: Icon(
                item['icon'] as IconData,
                color: AppTheme.primary,
              ),
              title: Text(item['label'] as String),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                if (item['route'] == '/customer-reservations-history' ||
                    item['route'] == '/customer-reviews' ||
                    item['route'] == '/customer-settings' ||
                    item['route'] == '/customer-about') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item['label']} - coming soon'),
                    ),
                  );
                } else {
                  context.go(item['route'] as String);
                }
              },
            );
          },
        ),
      ],
    );
  }

  void _saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil berhasil diperbarui'),
        backgroundColor: Colors.green,
      ),
    );

    setState(() {
      _isEditMode = false;
    });
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar dari Akun?'),
        content: const Text(
          'Apakah Anda yakin ingin keluar dari akun ini?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Anda telah keluar'),
                  backgroundColor: Colors.green,
                ),
              );
              // Navigate to login
              Future.delayed(const Duration(milliseconds: 500), () {
                context.go('/customer-login');
              });
            },
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
