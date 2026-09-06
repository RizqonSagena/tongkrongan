import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/models/advertising.dart';
import 'package:tongkrongan_umkm_owner_app/services/advertising_service.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';
import 'package:tongkrongan_umkm_owner_app/widgets/advertising/ads_bottom_navigation.dart';

class CreatorMarketplaceScreen extends StatefulWidget {
  const CreatorMarketplaceScreen({super.key});

  @override
  State<CreatorMarketplaceScreen> createState() => _CreatorMarketplaceScreenState();
}

class _CreatorMarketplaceScreenState extends State<CreatorMarketplaceScreen> {
  String _selectedCategory = 'Semua';
  final List<String> _categories = ['Semua', 'Food Vlogger', 'Content Creator', 'Local Influencer'];

  @override
  Widget build(BuildContext context) {
    final allCreators = AdvertisingService().creators;
    var creators = allCreators;
    if (_selectedCategory != 'Semua') {
      creators = allCreators.where((c) => c.category == _selectedCategory).toList();
    }

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Food Vlogger & Creators', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Promosikan menu Anda lewat kreator lokal', style: TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant)),
          ],
        ),
        backgroundColor: AppTheme.surface,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Category Choice Chips
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    selectedColor: const Color(0xFFFFDCC6),
                    labelStyle: TextStyle(
                      color: isSelected ? const Color(0xFF924700) : AppTheme.onSurfaceVariant,
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (val) {
                      if (val) setState(() => _selectedCategory = cat);
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // Creators List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: creators.length,
              itemBuilder: (context, index) {
                final creator = creators[index];
                return _buildCreatorCard(creator);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AdsBottomNavigation(currentIndex: 3),
    );
  }

  Widget _buildCreatorCard(ContentCreator creator) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.surfaceVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  creator.avatarUrl,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(width: 64, height: 64, color: AppTheme.surfaceContainer),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      creator.name,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.onSurface),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFDCC6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            creator.category,
                            style: const TextStyle(color: Color(0xFF924700), fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          creator.rating.toString(),
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      creator.location,
                      style: const TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            creator.bio,
            style: const TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant, height: 1.3),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 14),

          // Stats Bar
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Followers', creator.followers),
                _buildStatItem('Engagement', creator.engagementRate),
                _buildStatItem('Mulai Dari', creator.formattedPrice),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.go('/creator-detail/${creator.id}'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF924700),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text('Lihat Portofolio & Ajukan Promosi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String val) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.onSurfaceVariant)),
        const SizedBox(height: 2),
        Text(val, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.onSurface)),
      ],
    );
  }
}
