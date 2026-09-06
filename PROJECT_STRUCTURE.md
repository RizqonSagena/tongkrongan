# TONGkrongan - Arsitektur & Struktur Proyek Flutter

Aplikasi mobile-first untuk ekosistem UMKM dan Kuliner Indonesia dengan desain modern berbasis Material 3 (palet terracotta hangat `#AD2C00`, aksen hijau segar `#1B6D24`, background hangat `#FCF9F8`, dan tipografi Plus Jakarta Sans).

---

## 📁 Struktur Direktori Lengkap (`lib/`)

```
lib/
├── main.dart                                    # App entry point & GoRouter terpadu 29 Screen
├── theme/
│   └── app_theme.dart                           # Design Tokens Material 3 (Warna, Font, Spacing)
├── models/
│   ├── business.dart                            # Model Profil Usaha, Jam Operasional, Kategori
│   ├── employee.dart                            # Model Karyawan, Gaji, Bonus, Potongan
│   ├── financial.dart                           # Model Transaksi, Pembukuan, Arus Kas, Laporan
│   ├── culinary.dart                            # Model Warung, Menu/Produk, Kategori, Notifikasi
│   └── advertising.dart                         # Model Kampanye Iklan, Auto Play, Creator, Kalender
├── services/
│   ├── business_service.dart                    # Mock Data & Operasi Bisnis Owner
│   ├── customer_service.dart                    # Mock Data & Pencarian Kuliner Pelanggan
│   └── advertising_service.dart                 # Mock Data & Engine Penjadwalan Smart Ads
├── screens/
│   ├── auth/                                    # Autentikasi & Selektor Peran
│   │   ├── login_screen.dart                    # 1. Login + Role Quick Switcher ✅
│   │   └── customer_onboarding_screen.dart      # 1. Onboarding Pelanggan 3-Slide ✅
│   ├── owner/                                   # PHASE 1: OWNER / UMKM MANAGEMENT (10 Screens)
│   │   ├── owner_dashboard_screen.dart          # 2. Dashboard Pemilik UMKM ✅
│   │   ├── transaction_screen.dart              # 3. Layar Riwayat & Filter Transaksi ✅
│   │   ├── product_management_screen.dart       # 4. Manajemen Produk & Stok ✅
│   │   ├── investment_expenses_screen.dart      # 5. Manajemen Pengeluaran & Investasi ✅
│   │   ├── employee_salary_screen.dart          # 6. Gaji & Staf Pegawai ✅
│   │   ├── bookkeeping_screen.dart              # 7. Pembukuan & Arus Kas ✅
│   │   ├── financial_report_screen.dart         # 8. Laporan Keuangan Bisnis ✅
│   │   ├── notifications_screen.dart            # 9. Notifikasi Cerdas Usaha ✅
│   │   └── profile_settings_screen.dart         # 10. Profil & Pengaturan Usaha ✅
│   ├── customer/                                # PHASE 2: CULINARY DISCOVERY (9 Screens)
│   │   ├── customer_onboarding_screen.dart      # 1. Onboarding Kuliner Lokal ✅
│   │   ├── customer_home_screen.dart            # 2. Beranda Discovery & Radius Filter ✅
│   │   ├── explore_map_screen.dart              # 3. Peta Interaktif & Radius Coverage ✅
│   │   ├── category_results_screen.dart         # 4. Hasil Kategori Kuliner & Filter ✅
│   │   ├── detail_warung_screen.dart            # 5. Detail Profil Warung & Tab Navigasi ✅
│   │   ├── menu_harga_screen.dart               # 6. Buku Menu & Ketersediaan Harga ✅
│   │   ├── favorit_tersimpan_screen.dart        # 7. Tempat Kuliner Favorit Tersimpan ✅
│   │   ├── notifikasi_pelanggan_screen.dart     # 8. Notifikasi Promo & Warung Buka ✅
│   │   └── customer_profile_screen.dart         # 9. Profil Pengguna & Riwayat Pencarian ✅
│   └── advertising/                             # PHASE 3: SMART ADVERTISING (10 Screens)
│       ├── advertising_dashboard_screen.dart    # 1. Dashboard Utama Iklan Multi-Channel ✅
│       ├── my_campaigns_screen.dart             # 2. Daftar & Kontrol Kampanye Iklan ✅
│       ├── create_campaign_screen.dart          # 3. Wizard 10 Langkah Pembuatan Iklan ✅
│       ├── auto_play_campaign_screen.dart       # 4. Otomasi AUTO PLAY Terjadwal 3x/Hari ✅
│       ├── advertising_calendar_screen.dart     # 5. Kalender Jadwal Publikasi Promosi ✅
│       ├── platform_management_screen.dart      # 6. Integrasi Akun IG, TikTok, Facebook ✅
│       ├── creator_marketplace_screen.dart      # 7. Marketplace Food Vlogger & Influencer ✅
│       ├── creator_detail_screen.dart           # 8. Profil Kreator & Paket Promosi ✅
│       ├── advertising_analytics_screen.dart    # 9. Analitik Performa, ROI & Distribusi ✅
│       └── campaign_detail_screen.dart          # 10. Detail Metrik & Edit Kampanye ✅
└── widgets/
    ├── common/
    │   └── role_switcher.dart                   # Modal Bottom Sheet Pemilih Mode Peran
    ├── owner/
    │   ├── bottom_navigation.dart               # Navigasi Bawah Owner (5 Tab)
    │   ├── kpi_card.dart                        # Kartu Metrik Utama
    │   ├── insight_card.dart                    # Kartu Insight Bisnis
    │   ├── period_selector.dart                 # Pemilih Rentang Waktu
    │   └── revenue_chart.dart                   # Grafik Pendapatan
    ├── customer/
    │   ├── customer_bottom_navigation.dart      # Navigasi Bawah Pelanggan (5 Tab)
    │   ├── business_card.dart                   # Kartu Warung & Resto
    │   └── category_chip.dart                   # Chip Kategori Kuliner
    └── advertising/
        └── ads_bottom_navigation.dart           # Navigasi Bawah Smart Ads (5 Tab)
```

---

## 🚀 Fitur Utama

1. **Role Switcher Terpadu**: Pengguna atau penguji dapat berpindah peran kapan saja melalui ikon swap di header atau tombol pintas di halaman login:
   - 🏪 **Mode Pemilik UMKM** (`/owner-dashboard`)
   - 🍜 **Mode Pelanggan Kuliner** (`/customer-home`)
   - 📢 **Mode Smart Advertising** (`/advertising-dashboard`)
2. **Auto Play Campaign Engine**: Fitur promosi otomatis terjadwal (08:00, 14:00, 19:00) ke multi-platform (Instagram, TikTok, Facebook) dengan radius target cerdas.
3. **Food Vlogger & Influencer Marketplace**: Kolaborasi langsung dengan kreator kuliner lokal untuk mempromosikan menu unggulan UMKM.