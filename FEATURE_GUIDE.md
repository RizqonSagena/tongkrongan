# Panduan Fitur Owner App - TONGKRONGAN UMKM

## 📋 Daftar Fitur

### Phase 1: UMKM Management System

#### 1. **Kelola HPP (Harga Pokok Penjualan)**
Route: `/hpp`

**Deskripsi:**
Tools untuk owner mengelola dan menghitung HPP (Harga Pokok Penjualan) setiap produk mereka. Fitur ini membantu owner memahami keuntungan per produk dan mengoptimalkan pricing strategy.

**Fitur Utama:**
- ✅ Menambah HPP produk baru
- ✅ Edit HPP produk yang sudah ada
- ✅ Hapus data HPP
- ✅ Lihat riwayat perubahan HPP
- ✅ Analisis margin keuntungan
- ✅ Notifikasi produk dengan margin rendah (< 30%)
- ✅ Summary dashboard dengan metriks penting

**Metriks yang Ditampilkan:**
- Total HPP (Harga Pokok Penjualan)
- Total Harga Jual
- Rata-rata Margin Keuntungan
- Jumlah Produk dengan Margin Rendah

**Model Data:**
```dart
HPP {
  id: String,
  productId: String,
  productName: String,
  hpp: double,           // Harga Pokok Penjualan
  sellingPrice: double,  // Harga Jual
  profitPerUnit: double, // Keuntungan per unit (auto-calculate)
  profitMargin: double,  // % Margin (auto-calculate)
  lastUpdated: DateTime,
  notes: String?
}

HPPSummary {
  totalHPP: double,
  totalRevenue: double,
  totalProfit: double,
  averageProfitMargin: double,
  totalProducts: int,
  lowProfitMarginProducts: int
}

HPPHistory {
  id: String,
  hppId: String,
  previousHPP: double,
  newHPP: double,
  previousPrice: double,
  newPrice: double,
  changedAt: DateTime,
  reason: String
}
```

**Cara Menggunakan:**
1. Klik tombol "+" di appbar untuk menambah HPP baru
2. Isi nama produk, HPP, dan harga jual
3. Tambahkan catatan (opsional)
4. Klik "Simpan"
5. Untuk edit: Pilih produk → Klik "Edit"
6. Untuk lihat riwayat: Pilih produk → Klik "Riwayat"

---

#### 2. **Chat dengan Admin**
Routes: 
- `/admin-chat-list` - Daftar percakapan dengan admin
- `/admin-chat` - Percakapan detail dengan admin

**Deskripsi:**
Platform komunikasi langsung antara owner dan admin untuk mendapatkan bantuan, menjawab pertanyaan, dan melaporkan masalah. Hanya owner yang bisa initiate chat dengan admin, bukan dengan customer.

**Fitur Utama:**
- ✅ Daftar percakapan dengan admin
- ✅ Chat real-time dengan admin
- ✅ Kategori support (Bantuan Teknis, Pertanyaan, Bug, etc)
- ✅ Kirim attachments
- ✅ Reply/Quote messages
- ✅ Arsipkan percakapan
- ✅ Hapus percakapan
- ✅ Notifikasi pesan belum dibaca
- ✅ Search percakapan

**Support Categories:**
1. Bantuan Teknis - Masalah dengan fitur atau sistem
2. Pertanyaan Umum - Pertanyaan tentang penggunaan platform
3. Laporan Bug - Melaporkan bug atau error
4. Pengajuan Fitur - Mengajukan ide fitur baru
5. Masalah Pembayaran - Masalah terkait pembayaran/billing
6. Lainnya - Kategori lainnya

**Model Data:**
```dart
AdminChatMessage {
  id: String,
  senderId: String,
  senderName: String,
  senderRole: String,    // 'owner' atau 'admin'
  message: String,
  timestamp: DateTime,
  isRead: bool,
  attachmentUrl: String?,
  attachmentType: String?, // 'image', 'document'
  replyToMessageId: String?,
  replyToContent: String?
}

AdminChatConversation {
  id: String,
  ownerId: String,
  ownerName: String,
  ownerBusinessName: String,
  adminId: String,
  adminName: String,
  messages: List<AdminChatMessage>,
  createdAt: DateTime,
  lastMessageAt: DateTime,
  isActive: bool,
  unreadCount: int
}

SupportCategory {
  id: String,
  name: String,
  description: String,
  icon: String,
  priority: int  // 1 = low, 2 = medium, 3 = high
}
```

**Cara Menggunakan:**

**Memulai Percakapan Baru:**
1. Buka menu "Chat dengan Admin" (`/admin-chat-list`)
2. Klik tombol FAB "+" atau tombol "Mulai Percakapan"
3. Pilih kategori masalah
4. Ketik deskripsi masalah/pertanyaan
5. Klik "Mulai Percakapan"
6. Admin akan menerima notifikasi dan merespon

**Dalam Percakapan:**
1. Ketik pesan di input field
2. Klik tombol kirim (ikon pesawat)
3. Gunakan tombol attachment untuk mengirim file/gambar (opsional)
4. Gunakan emoji picker untuk menambah emoji (opsional)

**Filter & Sort:**
- Semua: Tampilkan semua percakapan
- Aktif: Hanya percakapan yang masih aktif
- Arsip: Hanya percakapan yang diarsipkan

**Aksi pada Percakapan:**
- **Buka**: Klik percakapan untuk membuka chat
- **Arsipkan**: Long press → Arsipkan (untuk percakapan aktif)
- **Restore**: Long press → Restore (untuk percakapan arsip)
- **Hapus**: Long press → Hapus (permanen)
- **Info**: Klik 3 dots → Info untuk melihat detail

---

## 🔄 Integrasi dengan Fitur Lain

### Kelola HPP + Dashboard Owner
- HPP data bisa ditampilkan di Dashboard sebagai insight
- Analisis keuntungan dapat membantu financial planning

### Chat Admin + Notifications
- Setiap pesan baru dari admin akan trigger notifikasi
- Unread count ditampilkan di bottom navigation

---

## 📱 UI/UX Guidelines

### Colors & Theme
- **Primary Color**: AppTheme.primary (untuk button, selected state)
- **Error/Warning**: Colors.red (margin rendah), Colors.orange (critical)
- **Success**: Colors.green

### Layout
- **Bottom Navigation**: Menampilkan 5 menu utama:
  1. Dashboard
  2. Transaksi
  3. Produk
  4. HPP (NEW)
  5. Chat (NEW)

### Responsive Design
- Semua screen dioptimalkan untuk berbagai ukuran device
- Support landscape dan portrait mode

---

## 🗂️ File Structure

```
lib/
├── models/
│   ├── hpp.dart                          # Model HPP
│   └── admin_chat.dart                   # Model Chat Admin
├── screens/
│   └── owner/
│       ├── hpp_management_screen.dart     # HPP Management UI
│       ├── admin_chat_list_screen.dart    # Chat List UI
│       └── admin_chat_screen.dart         # Chat Detail UI
└── widgets/
    └── owner/
        └── bottom_navigation.dart         # Updated dengan HPP & Chat
```

---

## 🚀 Integrasi dengan Backend

### Endpoints yang Diperlukan (untuk implementasi real):

**HPP Management:**
```
GET    /api/hpp                    # Get all HPP
POST   /api/hpp                    # Create new HPP
PUT    /api/hpp/:id                # Update HPP
DELETE /api/hpp/:id                # Delete HPP
GET    /api/hpp/:id/history        # Get HPP history
```

**Chat Admin:**
```
GET    /api/chat/conversations     # Get all conversations
POST   /api/chat/conversations     # Create new conversation
GET    /api/chat/conversations/:id # Get conversation detail
POST   /api/chat/conversations/:id/messages  # Send message
PUT    /api/chat/conversations/:id # Archive/restore
DELETE /api/chat/conversations/:id # Delete conversation
```

---

## 📝 Notes untuk Developer

### State Management
- Saat ini menggunakan StatefulWidget
- Untuk production, gunakan Riverpod/Bloc untuk state management
- Implementasi pagination untuk chat messages yang panjang

### Performance Optimization
- Lazy load messages di chat (infinite scroll)
- Cache HPP data untuk mengurangi API calls
- Compress attachments sebelum upload

### Future Enhancements
- [ ] Voice message support di chat
- [ ] Video call dengan admin
- [ ] Bulk HPP import dari CSV/Excel
- [ ] HPP analytics & reporting
- [ ] Automated margin alerts
- [ ] Chat scheduling/booking with admin
- [ ] Admin dashboard untuk manage conversations

---

## 📞 Support

Untuk bantuan atau pertanyaan lebih lanjut, gunakan fitur Chat dengan Admin di aplikasi.
