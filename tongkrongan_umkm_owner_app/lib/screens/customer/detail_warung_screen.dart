import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/models/culinary.dart';
import 'package:tongkrongan_umkm_owner_app/services/customer_service.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class DetailWarungScreen extends StatefulWidget {
  final String warungId;

  const DetailWarungScreen({
    required this.warungId, super.key,
  });

  @override
  State<DetailWarungScreen> createState() => _DetailWarungScreenState();
}

class _DetailWarungScreenState extends State<DetailWarungScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late CulinaryBusiness business;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    final found = CustomerService().getBusinessById(widget.warungId);
    business = found ?? CustomerService().businesses.first;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 250,
              pinned: true,
              backgroundColor: AppTheme.primary,
              leading: CircleAvatar(
                backgroundColor: Colors.black.withValues(alpha: 0.5),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).canPop() ? Navigator.of(context).pop() : context.go('/customer-home'),
                ),
              ),
              actions: [
                CircleAvatar(
                  backgroundColor: Colors.black.withValues(alpha: 0.5),
                  child: IconButton(
                    icon: Icon(
                      business.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: business.isFavorite ? Colors.redAccent : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        CustomerService().toggleFavorite(business.id);
                        business.isFavorite = !business.isFavorite;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(business.isFavorite ? 'Disimpan ke tempat favorit!' : 'Dihapus dari favorit'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.black.withValues(alpha: 0.5),
                  child: IconButton(
                    icon: const Icon(Icons.share, color: Colors.white),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Tautan profil warung disalin!')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      business.coverImage,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppTheme.primary,
                        child: const Icon(Icons.restaurant, size: 64, color: Colors.white),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.5),
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.7),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: business.isOpen ? AppTheme.secondary : Colors.grey,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  business.isOpen ? 'BUKA SEKARANG' : 'TUTUP',
                                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.6),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  business.category,
                                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            business.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              shadows: [Shadow(color: Colors.black87, blurRadius: 4)],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rating & Info Bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          business.rating.toString(),
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${business.reviewCount} ulasan)',
                          style: const TextStyle(fontSize: 13, color: AppTheme.onSurfaceVariant),
                        ),
                        const Spacer(),
                        const Icon(Icons.location_on, size: 16, color: AppTheme.primary),
                        const SizedBox(width: 4),
                        Text(
                          business.formattedDistance,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.primary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Quick Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Membuka Google Maps menuju lokasi...')),
                              );
                            },
                            icon: const Icon(Icons.directions, size: 18),
                            label: const Text('PETUNJUK ARAH', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Menghubungi ${business.phone}...')),
                              );
                            },
                            icon: const Icon(Icons.phone, size: 18, color: AppTheme.secondary),
                            label: const Text('TELEPON', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.secondary)),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              side: const BorderSide(color: AppTheme.secondary),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filledTonal(
                          onPressed: () {
                            setState(() {
                              CustomerService().toggleFavorite(business.id);
                              business.isFavorite = !business.isFavorite;
                            });
                          },
                          icon: Icon(
                            business.isFavorite ? Icons.bookmark : Icons.bookmark_border,
                            color: AppTheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Tab Navigation
              Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppTheme.surfaceVariant)),
                ),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: AppTheme.primary,
                  unselectedLabelColor: AppTheme.onSurfaceVariant,
                  indicatorColor: AppTheme.primary,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  tabs: const [
                    Tab(text: 'Tentang'),
                    Tab(text: 'Menu'),
                    Tab(text: 'Promo'),
                    Tab(text: 'Foto'),
                    Tab(text: 'Lokasi'),
                  ],
                ),
              ),

              // Tab Views
              SizedBox(
                height: 480,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildAboutTab(),
                    _buildMenuTab(),
                    _buildPromoTab(),
                    _buildPhotosTab(),
                    _buildLocationTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Deskripsi Usaha', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(business.description, style: const TextStyle(fontSize: 13, height: 1.5, color: AppTheme.onSurfaceVariant)),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.access_time, 'Jam Operasional', business.openingHours),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.payments_outlined, 'Kisaran Harga', business.priceRange),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.call, 'Nomor Kontak', business.phone),
        ],
      ),
    );
  }

  Widget _buildMenuTab() {
    final items = business.menuItems;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${items.length} Menu Tersedia', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              TextButton(
                onPressed: () => context.go('/menu-harga/${business.id}'),
                child: const Text('Buka Buku Menu Penuh >', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
        ),
        Expanded(
          child: items.isEmpty
              ? const Center(child: Text('Belum ada menu yang diunggah.'))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final menu = items[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              menu.imageUrl,
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(width: 64, height: 64, color: Colors.grey[300]),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(menu.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                const SizedBox(height: 2),
                                Text(menu.description, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant)),
                                const SizedBox(height: 4),
                                Text(menu.formattedPrice, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primary, fontSize: 13)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildPromoTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.secondaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                Icon(Icons.discount, color: AppTheme.secondary, size: 28),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Promo Beli 2 Gratis 1 🎁', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.onSecondaryContainer, fontSize: 14)),
                      SizedBox(height: 2),
                      Text('Khusus pemesanan menu kopi hari ini!', style: TextStyle(fontSize: 12, color: AppTheme.onSecondaryContainer)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotosTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const dynamicDelegate(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemCount: business.photos.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(business.photos[index], fit: BoxFit.cover),
        );
      },
    );
  }

  Widget _buildLocationTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Alamat Lengkap', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 6),
          Text(business.address, style: const TextStyle(fontSize: 13, color: AppTheme.onSurfaceVariant)),
          const SizedBox(height: 16),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.map, size: 40, color: AppTheme.primary),
                  const SizedBox(height: 8),
                  Text('Peta Lokasi (${business.formattedDistance})', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => context.go('/explore-map'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, foregroundColor: Colors.white),
                    child: const Text('Buka di Explore Map', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppTheme.primary),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant)),
            Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.onSurface)),
          ],
        ),
      ],
    );
  }
}

class dynamicDelegate extends SliverGridDelegateWithFixedCrossAxisCount {
  const dynamicDelegate({
    required super.crossAxisCount,
    super.mainAxisSpacing,
    super.crossAxisSpacing,
  });
}
