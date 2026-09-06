---
name: Warung Modern
colors:
  surface: '#fcf9f8'
  surface-dim: '#dcd9d9'
  surface-bright: '#fcf9f8'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f6f3f2'
  surface-container: '#f0eded'
  surface-container-high: '#eae7e7'
  surface-container-highest: '#e5e2e1'
  on-surface: '#1b1c1c'
  on-surface-variant: '#5a413a'
  inverse-surface: '#303030'
  inverse-on-surface: '#f3f0ef'
  outline: '#8f7068'
  outline-variant: '#e3beb5'
  surface-tint: '#b12d00'
  primary: '#ad2c00'
  on-primary: '#ffffff'
  primary-container: '#d34011'
  on-primary-container: '#fffbff'
  inverse-primary: '#ffb5a0'
  secondary: '#1b6d24'
  on-secondary: '#ffffff'
  secondary-container: '#a0f399'
  on-secondary-container: '#217128'
  tertiary: '#924700'
  on-tertiary: '#ffffff'
  tertiary-container: '#b75b00'
  on-tertiary-container: '#fffbff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffdbd1'
  primary-fixed-dim: '#ffb5a0'
  on-primary-fixed: '#3b0900'
  on-primary-fixed-variant: '#872000'
  secondary-fixed: '#a3f69c'
  secondary-fixed-dim: '#88d982'
  on-secondary-fixed: '#002204'
  on-secondary-fixed-variant: '#005312'
  tertiary-fixed: '#ffdcc6'
  tertiary-fixed-dim: '#ffb786'
  on-tertiary-fixed: '#311300'
  on-tertiary-fixed-variant: '#723600'
  background: '#fcf9f8'
  on-background: '#1b1c1c'
  surface-variant: '#e5e2e1'
typography:
  display-currency:
    fontFamily: plusJakartaSans
    fontSize: 32px
    fontWeight: '800'
    lineHeight: 40px
    letterSpacing: -0.02em
  display-currency-mobile:
    fontFamily: plusJakartaSans
    fontSize: 26px
    fontWeight: '800'
    lineHeight: 34px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: plusJakartaSans
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 32px
  headline-md:
    fontFamily: plusJakartaSans
    fontSize: 20px
    fontWeight: '700'
    lineHeight: 28px
  headline-sm:
    fontFamily: plusJakartaSans
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  body-lg:
    fontFamily: plusJakartaSans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: plusJakartaSans
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  body-sm:
    fontFamily: plusJakartaSans
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
  label-lg:
    fontFamily: plusJakartaSans
    fontSize: 16px
    fontWeight: '700'
    lineHeight: 20px
  label-md:
    fontFamily: plusJakartaSans
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 18px
  label-sm:
    fontFamily: plusJakartaSans
    fontSize: 11px
    fontWeight: '600'
    lineHeight: 14px
    letterSpacing: 0.04em
  numeral-stat:
    fontFamily: plusJakartaSans
    fontSize: 20px
    fontWeight: '700'
    lineHeight: 26px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  space-xxs: 0.25rem
  space-xs: 0.5rem
  space-sm: 0.75rem
  space-md: 1rem
  space-lg: 1.25rem
  space-xl: 1.5rem
  space-2xl: 2rem
  space-3xl: 3rem
  margin-mobile: 1rem
  gutter-mobile: 0.75rem
  touch-target-min: 3rem
---

## Brand & Style
The design system delivers an approachable, tactile, and empowering digital workspace built specifically for Indonesian culinary micro, small, and medium enterprises (UMKM)—from warung makan, kedai kopi, to street food vendors. 

The emotional tone balances pragmatic enterprise utility with genuine hospitality (*ramah*, *terpercaya*, *ringkas*). It eliminates cognitive friction for non-tech-savvy and multigenerational operators through tactile affordances, generous tap targets, high contrast ratios, and clear visual feedback. 

Stylistically, the aesthetic blends modern Southeast Asian startup clarity with warm physical textures: clean container cards, soft ambient warm shadows, pill-shaped interactions, and prominent financial typography designed for outdoor glare and fast-paced operational environments.

## Colors
The palette evokes traditional clay cookware, freshly roasted robusta, and bustling culinary spaces while retaining strict financial-grade legibility.

- **Primary (`#D84315` - Terracotta Bakar):** Used for primary conversion points, order confirmation, active state triggers, and brand touchpoints.
- **Secondary (`#2E7D32` - Hijau Cuan):** Represents positive cash flow, net profit, successful transaction statuses, and open store indicators.
- **Tertiary (`#F57C00` - Kunyit Hangat):** Serves as a utility accent for pending kitchen tickets, alerts, and promotional highlights.
- **Neutral Core (`#212121` - Arang):** Deep charcoal for primary text, ensuring strict AA/AAA accessibility against light surfaces.
- **Backgrounds & Surfaces:**
  - Base Background (`#FBF8F5` - Krem Beras): Soft off-white preventing screen fatigue during long cashier shifts.
  - Surface Raised / Card Surface (`#FFFFFF`): Pure white to elevate cards above the cream canvas.
  - Surface Subtle (`#F4ECE1` - Santan Gurih): Warm low-contrast background for chips, inactive inputs, and segmented table cells.
- **System States:**
  - Error/Batal: `#C62828`
  - Warning/Menunggu: `#EF6C00`
  - Info: `#0277BD`

## Typography
Typography is configured using `plusJakartaSans` throughout all tiers to maintain contemporary Indonesian typographic character, exceptional x-height, and optimal numeric legibility.

- **Financial Readout Priority:** Indonesian Rupiah amounts (`Rp 1.250.000`) use tabular figures via OpenType settings (`tnum`) across `display-currency` and `numeral-stat` to prevent layout jumping when metrics recalculate.
- **Clarity for Senior Merchants:** Minimum body size for critical merchant operational flows (order lists, cash inputs) is restricted to `body-md` (14px) and above. Secondary metadata never drops below 11px.
- **Copy Tone & Language:** All copy is written in natural, straightforward Bahasa Indonesia (e.g., *Catat Penjualan*, *Kas Masuk*, *Sisa Stok*, *Lunas*, *Meja 04*).

## Layout & Spacing
The layout follows a mobile-first paradigm optimized for handheld point-of-sale operations and one-handed thumb reach.

- **Grid Framework:**
  - **Mobile (<640px):** Single-column fluid layout with a fixed horizontal page margin of `16px` (`1rem`) and `12px` (`0.75rem`) card gutters.
  - **Tablet (640px - 1024px - Landscape POS):** 2-column or master-detail split (Left: Order Catalog / Right: Active Bill & Payment) with `24px` outer margins.
  - **Desktop (>1024px - Backoffice):** Centered max-width container (`1200px`) using an 8-column layout.
- **Touch Target Integrity:** Every clickable element (buttons, table selector cards, quick-add modifier badges) maintains a minimum height of `48px` (`touch-target-min`) to prevent mis-taps during rush hours.
- **Thumb Zone:** Primary transactional actions (e.g., *Bayar Sekarang*, *Tambah Pesanan*) are locked to persistent bottom floating sheets with safe-area padding.

## Elevation & Depth
Depth is created through ambient warmth rather than harsh synthetic drops. Shadows carry a subtle warm umber tint derived from the terracotta brand foundation.

- **Level 0 (Flat Canvas):** `#FBF8F5` base background.
- **Level 1 (Card & Content Containers):** `#FFFFFF` surface with `box-shadow: 0 2px 8px -2px rgba(84, 42, 10, 0.06), 0 1px 4px -1px rgba(84, 42, 10, 0.04)`.
- **Level 2 (Interactive Floating Elements, Dropdowns, Segmented Controls):** `#FFFFFF` surface with `box-shadow: 0 8px 16px -4px rgba(84, 42, 10, 0.08), 0 2px 6px -1px rgba(84, 42, 10, 0.05)`.
- **Level 3 (Modals, Bottom Checkout Sheets, Drawer Menus):** Pure white container resting over a `rgba(30, 20, 15, 0.45)` dimmed scrim, styled with `box-shadow: 0 -8px 24px -4px rgba(84, 42, 10, 0.12)`.
- **Dividers & Strokes:** Low-contrast `1px` borders using `#EDE3D5` on flat surfaces to define card boundaries without visual clutter.

## Shapes
The shape system prioritizes rounded, approachable corners that reflect the warmth of traditional Indonesian warung culture.

- **Default Geometry:** Standard cards, inputs, and container tiles utilize `rounded-2xl` (`16px` / `1rem`) radii to give a soft, friendly appearance.
- **Compact Interactive Elements:** Minor chips, badging, and quantity steppers utilize `rounded-xl` (`12px` / `0.75rem`).
- **Pills:** All primary action buttons, status pills (*Lunas*, *Proses*, *Tutup*), and quick search pills utilize full rounded borders (`rounded-full`).

## Components

### Buttons
- **Primary Button:** Height `48px` or `54px`, full-width on mobile. Background `#D84315`, text `#FFFFFF`, font weight `700`, shape `rounded-full`. Includes tactile active press scaling (`transform: scale(0.98)`).
- **Secondary / Ghost Button:** Transparent background, `1.5px` border `#D84315`, text `#D84315`, shape `rounded-full`.
- **Positive Action Button (Quick Pay / Lunas):** Background `#2E7D32`, text `#FFFFFF`, shape `rounded-full`.

### Cards (Kartu Ringkasan & Menu)
- Pure white background, `rounded-2xl` border radius, `1px` border `#EDE3D5`, padded by `16px`.
- Metric cards showcase Rupiah totals in bold `display-currency-mobile` with supporting trend badges in `#2E7D32` (profit) or `#C62828` (expenses).

### Chips & Filters
- Inactive: Background `#F4ECE1`, text `#212121`, `rounded-full`, padding `8px 16px`.
- Active: Background `#D84315`, text `#FFFFFF`, font weight `600`.

### Input Fields (Input Transaksi & Stok)
- Minimum height `48px`. Background `#FFFFFF`, border `1.5px solid #EDE3D5`, `rounded-xl`.
- Focus state: Border `#D84315` with an outer soft terracotta ring `rgba(216, 67, 21, 0.15)`.
- Numerical fields (Harga Jual, Modal) feature fixed prefix `Rp` in bold arang neutral.

### Lists (Daftar Menu & Riwayat Transaksi)
- Clean rows separated by hairline border `#F4ECE1`.
- Items feature thumbnail avatars (`rounded-xl`), item title in `label-md`, subtitle (varian/catatan) in `body-sm`, and price right-aligned in `label-lg`.

### Stepper & Quantity Selector
- Pill-shaped container (`rounded-full`), background `#F4ECE1`, containing a minus button, numerical input, and plus button. Each button has a minimum hit area of `40x40px`.

### Badges & Status Indicators
- **Lunas / Selesai:** Background `rgba(46, 125, 50, 0.12)`, text `#2E7D32`, `rounded-full`.
- **Menunggu Pembayaran:** Background `rgba(245, 124, 0, 0.12)`, text `#E65100`, `rounded-full`.
- **Habis / Batal:** Background `rgba(198, 40, 40, 0.12)`, text `#C62828`, `rounded-full`.