# HTML References

This directory contains the original HTML prototypes that were migrated to Flutter screens. These files serve as design references and documentation for the Flutter implementation.

## Structure

Each folder contains:
- `code.html` - Original HTML prototype with inline CSS and JavaScript
- `screen.png` - Screenshot of the HTML prototype

## HTML to Flutter Mapping

| HTML Folder | Flutter Screen | Status | Notes |
|-------------|---------------|--------|--------|
| `1._customer_onboarding/` | `lib/screens/auth/customer_onboarding_screen.dart` | ✅ Complete | Multi-page onboarding flow |
| `1._login_pemilik_umkm/` | `lib/screens/auth/login_screen.dart` | ✅ Complete | Login with phone/email toggle |
| `2._customer_home/` | `lib/screens/home/customer_home_screen.dart` | ✅ Complete | Main home screen with categories |
| `3._explore_map/` | `lib/screens/home/explore_map_screen.dart` | 📋 Stub | Map exploration view |
| `4._category_results/` | `lib/screens/home/category_results_screen.dart` | 📋 Stub | Category search results |
| `5._detail_warung/` | `lib/screens/warung/detail_warung_screen.dart` | 📋 Stub | Restaurant detail page |
| `6._menu_harga/` | `lib/screens/warung/menu_harga_screen.dart` | 📋 Stub | Menu and pricing |
| `7._favorit_tersimpan/` | `lib/screens/profile/favorit_tersimpan_screen.dart` | 📋 Stub | Saved favorites |
| `7._auto_play_monitoring_mobile/` | `lib/screens/management/auto_play_monitoring_screen.dart` | 📋 Stub | Monitoring dashboard |
| `8._creator_management_mobile/` | `lib/screens/management/creator_management_screen.dart` | 📋 Stub | Creator management tools |
| `8._notifikasi_pelanggan/` | `lib/screens/profile/notifikasi_pelanggan_screen.dart` | 📋 Stub | Customer notifications |
| `9._category_management_mobile/` | `lib/screens/management/category_management_screen.dart` | 📋 Stub | Category administration |
| `10._location_management_mobile/` | `lib/screens/management/location_management_screen.dart` | 📋 Stub | Location settings |
| `dashboard_pembukuan_arus_kas/` | `lib/screens/dashboard/dashboard_pembukuan_screen.dart` | ✅ Complete | Financial dashboard |
| `dashboard_produk_margin_penjualan_cup/` | `lib/screens/dashboard/dashboard_produk_margin_screen.dart` | 📋 Stub | Product margin analytics |
| `dashboard_transaksi_volume_cup/` | `lib/screens/dashboard/dashboard_transaksi_volume_screen.dart` | 📋 Stub | Transaction volume analytics |
| `edit_kategori_taksonomi_menu_mobile/` | `lib/screens/management/edit_kategori_taksonomi_screen.dart` | 📋 Stub | Category taxonomy editor |
| `warung_modern/` | *Not mapped* | ❌ N/A | Additional design reference |

## Design System Extracted

The following design tokens were extracted from the HTML prototypes and implemented in `lib/theme/app_theme.dart`:

### Colors
- **Primary**: `#AD2C00` (Warm terracotta orange)
- **Secondary**: `#1B6D24` (Fresh green)
- **Surface**: `#FCF9F8` (Warm neutral)
- **Full Material 3 color palette** with semantic color mapping

### Typography
- **Font Family**: Plus Jakarta Sans
- **Text Styles**: Headline, Body, Label variants matching HTML designs
- **Font Weights**: 400, 500, 600, 700, 800

### Spacing
- **Grid System**: 8px base unit
- **Spacing Scale**: xxs(4px), xs(8px), sm(12px), md(16px), lg(20px), xl(24px), 2xl(32px), 3xl(48px)
- **Touch Targets**: Minimum 48px for interactive elements

### Border Radius
- **Small**: 4px
- **Medium**: 8px
- **Large**: 12px
- **Full**: 9999px (pill shape)

## Key UI Components Migrated

### Widgets Created
1. **CategoryCard** (`lib/widgets/category_card.dart`)
   - Food category browsing cards with emoji icons
   - Hover effects and navigation

2. **WarungCard** (`lib/widgets/warung_card.dart`)
   - Restaurant listing cards with images, ratings, distance
   - Status badges (Open/Closed)
   - Price information and CTA buttons

3. **PromoBanner** (`lib/widgets/promo_banner.dart`)
   - Promotional content with background gradients
   - QR code integration for in-store promotions

### Common UI Patterns
- **Material 3 Design Language**
- **Floating Action Buttons**
- **Bottom Navigation**
- **Search Bars with voice input**
- **Filter chips and toggles**
- **Cards with elevation and shadows**
- **Status indicators and badges**

## How to Use These References

1. **For Implementation**: When implementing stub screens, refer to the corresponding HTML file for:
   - Layout structure and component hierarchy
   - Specific text content and copy
   - Interactive behavior and state management
   - Visual design details

2. **For Design Consistency**: Use these prototypes to ensure:
   - Color usage matches the original designs
   - Spacing and typography are consistent
   - Component behavior matches user expectations

3. **For Testing**: Compare Flutter implementation with:
   - Screenshot reference (`screen.png`)
   - Interactive behavior in the HTML prototype
   - Content accuracy and completeness

## Migration Notes

- All HTML files use **TailwindCSS** with custom design tokens
- **Material Design Icons** are used throughout
- **Mobile-first responsive design** approach
- **Custom CSS animations** for enhanced UX
- **JavaScript interactivity** for form handling and UI state

## Development Workflow

When implementing a stub screen:

1. Open the corresponding HTML file in a browser
2. Review the `screen.png` for visual reference
3. Extract any missing components or patterns
4. Implement the Flutter screen following the established architecture
5. Test against the HTML reference for accuracy
6. Update this documentation when complete

---

*These HTML references preserve the original design intent and serve as the source of truth for Flutter implementation.*