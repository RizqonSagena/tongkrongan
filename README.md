# TONGkrongan UMKM Owner App

Aplikasi Flutter untuk pemilik UMKM yang memungkinkan pengelolaan warung dan usaha kuliner dengan mudah.

## Features

### Authentication
- ✅ Login dengan WhatsApp/HP atau Email
- ✅ Customer Onboarding
- 🔄 Google SSO Integration (planned)

### Home & Discovery
- ✅ Customer Home Screen dengan kategori kuliner
- ✅ Search & Filter warung terdekat
- ✅ Kategori kuliner (Kopi, Cafe, Restoran, dll.)
- ✅ Promo banner dan penawaran khusus
- ✅ Warung cards dengan rating dan jarak

### Dashboard & Analytics
- ✅ Dashboard Pembukuan dengan arus kas
- 📊 Dashboard Produk Margin (planned)
- 📊 Dashboard Transaksi Volume (planned)
- 💰 Financial metrics dan reporting

### Management
- 🏪 Auto Play Monitoring (planned)
- 👥 Creator Management (planned)
- 📂 Category Management (planned)
- 📍 Location Management (planned)
- 🏷️ Edit Kategori Taksonomi (planned)

### Warung Details
- 🏪 Detail warung dengan foto dan info lengkap
- 📋 Menu & Harga (planned)
- ⭐ Rating dan review system

### Profile & Settings
- 💖 Favorit Tersimpan (planned)
- 🔔 Notifikasi Pelanggan (planned)

## Architecture

### Project Structure
```
lib/
├── main.dart                 # App entry point
├── theme/                    # Theme & design system
│   └── app_theme.dart       # Material 3 theme with custom colors
├── screens/                  # All app screens organized by feature
│   ├── auth/                # Authentication screens
│   ├── home/                # Home & discovery screens
│   ├── dashboard/           # Analytics & dashboard screens
│   ├── management/          # Business management screens
│   ├── warung/              # Warung detail screens
│   └── profile/             # Profile & settings screens
├── widgets/                 # Reusable UI components
│   ├── category_card.dart
│   ├── warung_card.dart
│   └── promo_banner.dart
├── models/                  # Data models
├── services/               # API services & data layer
└── utils/                  # Utility functions

html_references/            # Original HTML prototypes for reference
├── 1._login_pemilik_umkm/
├── 2._customer_home/
├── dashboard_pembukuan_arus_kas/
├── ... (17 total HTML prototypes)
└── README.md              # HTML to Flutter mapping documentation
```

### Design System
- **Font**: Plus Jakarta Sans
- **Colors**: Material 3 with custom TONGkrongan brand colors
- **Primary**: Warm terracotta orange (#AD2C00)
- **Secondary**: Fresh green (#1B6D24)
- **Surface**: Warm neutral (#FCF9F8)

### State Management
- **Flutter Riverpod** for state management
- **Go Router** for navigation
- **Dio** for HTTP requests

### Navigation Routes
- `/login` - Login screen
- `/onboarding` - Customer onboarding
- `/home` - Main home screen
- `/explore-map` - Map exploration
- `/category-results` - Category search results
- `/warung/:id` - Warung detail page
- `/warung/:id/menu` - Menu & pricing
- `/favorit` - Saved favorites
- `/notifikasi` - Customer notifications
- `/dashboard/pembukuan` - Financial dashboard
- `/dashboard/produk-margin` - Product margin analytics
- `/dashboard/transaksi-volume` - Transaction volume analytics
- `/management/*` - Various management screens

## Getting Started

### Prerequisites
- Flutter 3.1.0 or higher
- Dart 3.1.0 or higher

### Installation
1. Clone this repository
2. Navigate to the project directory:
   ```bash
   cd tongkrongan_umkm_owner_app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

### Building
- **Development**: `flutter run`
- **Production APK**: `flutter build apk --release`
- **Production iOS**: `flutter build ios --release`
- **Web**: `flutter build web`

## Migration from HTML

This Flutter app was migrated from HTML prototypes located in the `html_references/` directory. Each original HTML prototype has been carefully analyzed and converted to Flutter widgets with the following mapping:

| Original HTML Folder | Flutter Screen | Status |
|---------------------|---------------|--------|
| `1._login_pemilik_umkm` | `LoginScreen` | ✅ Complete |
| `1._customer_onboarding` | `CustomerOnboardingScreen` | ✅ Complete |
| `2._customer_home` | `CustomerHomeScreen` | ✅ Complete |
| `3._explore_map` | `ExploreMapScreen` | 📋 Stub |
| `4._category_results` | `CategoryResultsScreen` | 📋 Stub |
| `5._detail_warung` | `DetailWarungScreen` | 📋 Stub |
| `6._menu_harga` | `MenuHargaScreen` | 📋 Stub |
| `7._favorit_tersimpan` | `FavoritTersimpanScreen` | 📋 Stub |
| `8._notifikasi_pelanggan` | `NotifikasiPelangganScreen` | 📋 Stub |
| `dashboard_pembukuan_arus_kas` | `DashboardPembukuanScreen` | ✅ Complete |
| `dashboard_produk_margin_penjualan_cup` | `DashboardProdukMarginScreen` | 📋 Stub |
| `dashboard_transaksi_volume_cup` | `DashboardTransaksiVolumeScreen` | 📋 Stub |
| `*_management_mobile` | Various Management Screens | 📋 Stub |
| `edit_kategori_taksonomi_menu_mobile` | `EditKategoriTaksonomiScreen` | 📋 Stub |

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**TONGkrongan** - Solusi Kelola Warung & Usaha Kuliner Lebih Mudah 🍕☕