import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/models/advertising.dart';
import 'package:tongkrongan_umkm_owner_app/services/advertising_service.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class CreateCampaignScreen extends StatefulWidget {
  const CreateCampaignScreen({super.key});

  @override
  State<CreateCampaignScreen> createState() => _CreateCampaignScreenState();
}

class _CreateCampaignScreenState extends State<CreateCampaignScreen> {
  int _currentStep = 0;

  // Form State
  final _nameController = TextEditingController(text: 'Promo Spesial Es Kopi Susu');
  String _selectedProduct = 'Es Kopi Susu Aren';
  final String _mediaUrl = 'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?w=800&q=80';
  final _captionController = TextEditingController(
    text: 'Beli 2 Es Kopi Susu Aren Gratis 1 Roti Bakar! Yuk merapat ke kedai kopi kita sekarang sebelum kehabisan sob! ☕🔥',
  );
  String _targetLocation = 'Tebet, Jakarta Selatan';
  double _radiusKm = 5.0;
  String _targetAudience = 'Mahasiswa & Pekerja (18 - 35 Tahun)';
  final List<String> _selectedPlatforms = ['Instagram', 'TikTok'];
  double _budget = 250000;
  final String _schedule = '08:00, 14:00, 19:00 (3x/hari)';

  final List<String> _availableProducts = [
    'Es Kopi Susu Aren',
    'Roti Bakar Cokelat Keju',
    'Sambal Bakar Ayam Goreng',
    'Paket Nasi Kulit Pedas',
    'Seafood Saus Padang',
  ];

  final List<String> _availableAudiens = [
    'Mahasiswa & Pekerja (18 - 35 Tahun)',
    'Keluarga & Pecinta Kuliner (Semua Usia)',
    'Pekerja Kantoran Makan Siang (22 - 45 Tahun)',
    'Komunitas Anak Muda & Nongkrong (17 - 28 Tahun)',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  void _submitCampaign() {
    final newCamp = AdCampaign(
      id: 'camp-${DateTime.now().millisecondsSinceEpoch}',
      name: _nameController.text.trim(),
      productName: _selectedProduct,
      mediaUrl: _mediaUrl,
      caption: _captionController.text.trim(),
      targetLocation: _targetLocation,
      radiusKm: _radiusKm,
      targetAudience: _targetAudience,
      platforms: _selectedPlatforms,
      budget: _budget,
      schedule: _schedule,
      status: CampaignStatus.active,
      reach: 12000,
      impressions: 24000,
      engagementRate: 5.2,
      clicks: 840,
      estimatedCustomers: 160,
      spending: 0,
    );

    AdvertisingService().addCampaign(newCamp);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppTheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: AppTheme.secondary, size: 40),
            ),
            const SizedBox(height: 16),
            const Text(
              'Kampanye Aktif!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Iklan Anda berhasil didistribusikan ke ${_selectedPlatforms.join(", ")} dengan target radius ${_radiusKm.toInt()} KM.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: AppTheme.onSurfaceVariant),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.go('/my-campaigns');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Buka Daftar Kampanye'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Buat Iklan Multi-Platform', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: AppTheme.surface,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Step Progress Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppTheme.surfaceContainerLow,
            child: Row(
              children: [
                Text(
                  'Langkah ${_currentStep + 1} dari 10',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (_currentStep + 1) / 10,
                      backgroundColor: AppTheme.surfaceVariant,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primary),
                      minHeight: 6,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Step Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: _buildStepContent(),
            ),
          ),

          // Bottom Controls
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppTheme.surface,
              border: Border(top: BorderSide(color: AppTheme.surfaceVariant)),
            ),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => _currentStep--),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Kembali'),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentStep < 9) {
                        setState(() => _currentStep++);
                      } else {
                        _submitCampaign();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentStep == 9 ? const Color(0xFF1B6D24) : AppTheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: Text(
                      _currentStep == 9 ? '🚀 Aktifkan Iklan Sekarang' : 'Lanjut',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStepCard(
          stepNumber: 1,
          title: 'Beri Nama Kampanye Iklan',
          subtitle: 'Gunakan nama yang mudah diingat untuk mengidentifikasi promo ini.',
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nama Kampanye',
              filled: true,
              fillColor: AppTheme.surfaceContainerLow,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        );
      case 1:
        return _buildStepCard(
          stepNumber: 2,
          title: 'Pilih Produk / Menu yang Dipromosikan',
          subtitle: 'Iklankan menu terlaris atau menu baru untuk menarik minat pelanggan.',
          content: Column(
            children: _availableProducts.map((prod) {
              final isSelected = _selectedProduct == prod;
              return RadioListTile<String>(
                title: Text(prod, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                value: prod,
                groupValue: _selectedProduct,
                activeColor: AppTheme.primary,
                onChanged: (val) => setState(() => _selectedProduct = val!),
              );
            }).toList(),
          ),
        );
      case 2:
        return _buildStepCard(
          stepNumber: 3,
          title: 'Unggah Foto atau Video Menu',
          subtitle: 'Pilih foto makanan/minuman yang menggugah selera.',
          content: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(_mediaUrl, height: 180, width: double.infinity, fit: BoxFit.cover),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Foto produk telah dipilih dari galeri.')),
                  );
                },
                icon: const Icon(Icons.photo_library),
                label: const Text('Ganti Foto dari Galeri'),
              ),
            ],
          ),
        );
      case 3:
        return _buildStepCard(
          stepNumber: 4,
          title: 'Tulis Caption Iklan',
          subtitle: 'Gunakan kata-kata ajakan menarik dengan emoji dan hashtag lokal.',
          content: TextField(
            controller: _captionController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Tulis caption promosi...',
              filled: true,
              fillColor: AppTheme.surfaceContainerLow,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        );
      case 4:
        return _buildStepCard(
          stepNumber: 5,
          title: 'Pilih Lokasi Sasaran',
          subtitle: 'Tentukan area pusat penyiaran iklan digital warung Anda.',
          content: TextField(
            onChanged: (val) => _targetLocation = val,
            controller: TextEditingController(text: _targetLocation),
            decoration: InputDecoration(
              labelText: 'Pusat Area / Lokasi Warung',
              prefixIcon: const Icon(Icons.location_on, color: AppTheme.primary),
              filled: true,
              fillColor: AppTheme.surfaceContainerLow,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        );
      case 5:
        return _buildStepCard(
          stepNumber: 6,
          title: 'Pilih Radius Jangkauan',
          subtitle: 'Pelanggan kuliner umumnya datang dari radius 1 - 10 KM.',
          content: Column(
            children: [
              Text(
                '${_radiusKm.toInt()} KM dari Warung',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.primary),
              ),
              Slider(
                value: _radiusKm,
                min: 1.0,
                max: 10.0,
                divisions: 9,
                activeColor: AppTheme.primary,
                label: '${_radiusKm.toInt()} KM',
                onChanged: (val) => setState(() => _radiusKm = val),
              ),
              const Text('Iklan hanya akan muncul ke pengguna ponsel dalam radius ini.', style: TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant)),
            ],
          ),
        );
      case 6:
        return _buildStepCard(
          stepNumber: 7,
          title: 'Pilih Target Audiens',
          subtitle: 'Sesuaikan dengan profil pembeli usaha kuliner Anda.',
          content: Column(
            children: _availableAudiens.map((aud) {
              return RadioListTile<String>(
                title: Text(aud, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                value: aud,
                groupValue: _targetAudience,
                activeColor: AppTheme.primary,
                onChanged: (val) => setState(() => _targetAudience = val!),
              );
            }).toList(),
          ),
        );
      case 7:
        return _buildStepCard(
          stepNumber: 8,
          title: 'Pilih Platform Iklan',
          subtitle: 'Iklan akan otomatis didistribusikan ke media sosial terpilih.',
          content: Column(
            children: [
              _buildPlatformCheckbox('Instagram', '📸', 'Feeds & Stories'),
              _buildPlatformCheckbox('TikTok', '🎵', 'Video FYP Lokal'),
              _buildPlatformCheckbox('Facebook', '📘', 'Komunitas Kuliner & Feeds'),
            ],
          ),
        );
      case 8:
        return _buildStepCard(
          stepNumber: 9,
          title: 'Tentukan Anggaran Promosi',
          subtitle: 'Mulai dari budget terjangkau untuk UMKM.',
          content: Column(
            children: [
              Text(
                'Rp${_budget.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1B6D24)),
              ),
              Slider(
                value: _budget,
                min: 50000,
                max: 1000000,
                divisions: 19,
                activeColor: const Color(0xFF1B6D24),
                label: 'Rp${_budget.toInt()}',
                onChanged: (val) => setState(() => _budget = val),
              ),
              const Text('Estimasi jangkauan: 10.000 - 30.000 orang di sekitar Anda', style: TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant)),
            ],
          ),
        );
      case 9:
        return _buildLivePreview();
      default:
        return const SizedBox();
    }
  }

  Widget _buildStepCard({
    required int stepNumber,
    required String title,
    required String subtitle,
    required Widget content,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.surfaceVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: AppTheme.primaryFixed,
                child: Text('$stepNumber', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.onPrimaryFixed)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.onSurface),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant)),
          const SizedBox(height: 20),
          content,
        ],
      ),
    );
  }

  Widget _buildPlatformCheckbox(String name, String icon, String subtitle) {
    final isChecked = _selectedPlatforms.contains(name);
    return CheckboxListTile(
      value: isChecked,
      activeColor: AppTheme.primary,
      secondary: Text(icon, style: const TextStyle(fontSize: 22)),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant)),
      onChanged: (val) {
        setState(() {
          if (val == true) {
            _selectedPlatforms.add(name);
          } else if (_selectedPlatforms.length > 1) {
            _selectedPlatforms.remove(name);
          }
        });
      },
    );
  }

  Widget _buildLivePreview() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.primary, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.preview, color: AppTheme.primary, size: 22),
              SizedBox(width: 8),
              Text('Pratinjau Iklan (Live Preview)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(_mediaUrl, height: 160, width: double.infinity, fit: BoxFit.cover),
          ),
          const SizedBox(height: 12),
          Text(_nameController.text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(_captionController.text, style: const TextStyle(fontSize: 13, color: AppTheme.onSurfaceVariant, height: 1.4)),
          const SizedBox(height: 12),
          const Divider(),
          _buildPreviewRow('Platform', _selectedPlatforms.join(' • ')),
          _buildPreviewRow('Radius', '${_radiusKm.toInt()} KM dari $_targetLocation'),
          _buildPreviewRow('Target', _targetAudience),
          _buildPreviewRow('Jadwal Tayang', _schedule),
          _buildPreviewRow('Budget', 'Rp${_budget.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}'),
        ],
      ),
    );
  }

  Widget _buildPreviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.onSurface),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
