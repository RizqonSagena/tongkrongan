import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/models/culinary.dart';
import 'package:tongkrongan_umkm_owner_app/services/customer_service.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/customer/customer_bottom_navigation.dart';

class FavoritTersimpanScreen extends StatefulWidget {
  const FavoritTersimpanScreen({super.key});

  @override
  State<FavoritTersimpanScreen> createState() => _FavoritTersimpanScreenState();
}

class _FavoritTersimpanScreenState extends State<FavoritTersimpanScreen> {
  @override
  Widget build(BuildContext context) {
    final favorites = CustomerService().getFavorites();

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Tempat Favorit Saya', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: AppTheme.surface,
        elevation: 0,
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: AppTheme.surfaceContainerLow,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_border, size: 48, color: AppTheme.outline),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Belum ada kuliner tersimpan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tandai ikon hati pada warung favorit Anda untuk menyimpannya di sini.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: AppTheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.go('/customer-home'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Jelajahi Kuliner Sekarang'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final item = favorites[index];
                return _buildFavoriteCard(item);
              },
            ),
      bottomNavigationBar: const CustomerBottomNavigation(currentIndex: 2),
    );
  }

  Widget _buildFavoriteCard(CulinaryBusiness business) {
    return InkWell(
      onTap: () => context.go('/business-detail/${business.id}'),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.surfaceVariant),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                business.coverImage,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(width: 90, height: 90, color: AppTheme.surfaceContainer),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          business.name,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.redAccent, size: 20),
                        onPressed: () {
                          setState(() {
                            CustomerService().toggleFavorite(business.id);
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    business.category,
                    style: const TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        business.rating.toString(),
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.location_on, size: 14, color: AppTheme.primary),
                      const SizedBox(width: 4),
                      Text(
                        business.formattedDistance,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
