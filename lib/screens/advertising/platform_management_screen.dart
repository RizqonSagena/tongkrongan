import 'package:flutter/material.dart';
import 'package:tongkrongan_umkm_owner_app/models/advertising.dart';
import 'package:tongkrongan_umkm_owner_app/services/advertising_service.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class PlatformManagementScreen extends StatefulWidget {
  const PlatformManagementScreen({super.key});

  @override
  State<PlatformManagementScreen> createState() => _PlatformManagementScreenState();
}

class _PlatformManagementScreenState extends State<PlatformManagementScreen> {
  @override
  Widget build(BuildContext context) {
    final platforms = AdvertisingService().platformConnections;

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Integrasi Media Sosial', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: AppTheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFDCC6).withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF924700).withValues(alpha: 0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Color(0xFF924700)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Hubungkan akun media sosial bisnis Anda agar promosi otomatis dan kampanye iklan dapat ditayangkan langsung ke target konsumen.',
                      style: TextStyle(fontSize: 12, height: 1.4, color: Color(0xFF311300)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Channel Media Sosial Terdaftar',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ...platforms.map((p) => _buildPlatformCard(p)),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformCard(PlatformConnection p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.surfaceVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(p.icon, style: const TextStyle(fontSize: 32)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.platformName,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      p.isConnected ? 'Terhubung: ${p.accountHandle}' : 'Belum terhubung',
                      style: TextStyle(
                        fontSize: 12,
                        color: p.isConnected ? const Color(0xFF1B6D24) : AppTheme.onSurfaceVariant,
                        fontWeight: p.isConnected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: p.isConnected ? const Color(0xFFA3F69C) : Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  p.isConnected ? 'CONNECTED' : 'DISCONNECTED',
                  style: TextStyle(
                    color: p.isConnected ? const Color(0xFF005312) : Colors.grey[700],
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (p.isConnected && p.lastSync != null) ...[
            const SizedBox(height: 12),
            Text(
              'Sinkronisasi terakhir: ${p.lastSync}',
              style: const TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant),
            ),
          ],
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  p.isConnected = !p.isConnected;
                  if (p.isConnected) {
                    p.accountHandle = '@tongkrongan_${p.platformName.toLowerCase()}';
                    p.lastSync = 'Baru saja';
                  } else {
                    p.accountHandle = null;
                    p.lastSync = null;
                  }
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(p.isConnected ? 'Akun ${p.platformName} berhasil dihubungkan!' : 'Akun ${p.platformName} diputuskan.'),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: p.isConnected ? Colors.red : AppTheme.primary),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                p.isConnected ? 'Putuskan Koneksi' : 'Hubungkan Akun ${p.platformName}',
                style: TextStyle(
                  color: p.isConnected ? Colors.red : AppTheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
