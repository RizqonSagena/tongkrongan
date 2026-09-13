# Quick Start Guide - HPP & Chat Admin Features

## 🚀 Mulai Cepat

### Step 1: Run Aplikasi
```bash
cd flutter/tongkrongan_umkm_owner_app
flutter pub get
flutter run
```

### Step 2: Login ke Owner
1. Buka aplikasi
2. Login dengan akun Owner (atau skip jika sudah auto-login)
3. Anda akan masuk ke Owner Dashboard

---

## 📊 Fitur 1: Kelola HPP

### Cara Akses
1. Dari **Owner Dashboard** → Klik tab **HPP** di bottom navigation
2. Atau langsung ke route: `/hpp`

### Quick Actions

#### ➕ Tambah HPP Baru
```
1. Klik tombol (+) di kanan atas
2. Isi form:
   - Nama Produk: "Es Kopi Susu"
   - HPP: 5000
   - Harga Jual: 15000
   - Catatan (opsional): "Bahan berkualitas"
3. Klik "Simpan"
```

#### ✏️ Edit HPP
```
1. Klik product card
2. Klik menu 3 dots
3. Pilih "Edit"
4. Ubah data
5. Klik "Perbarui"
```

#### 🗑️ Hapus HPP
```
1. Klik product card
2. Klik menu 3 dots
3. Pilih "Hapus"
4. Konfirmasi "Hapus"
```

#### 📜 Lihat Riwayat
```
1. Klik product card
2. Klik menu 3 dots
3. Pilih "Riwayat"
4. Lihat history perubahan harga
```

### Dashboard Summary
Anda akan melihat 4 kartu ringkasan:
- **Total HPP**: Jumlah HPP semua produk
- **Total Harga**: Jumlah total harga jual
- **Rata-rata Margin**: % keuntungan rata-rata
- **Margin Rendah**: Berapa produk dengan margin < 30%

### Filter & Sort
- **Search**: Ketik nama produk di search bar
- **Sort**: Klik "Nama Produk", "HPP", atau "Margin" untuk sort
- **Ascending/Descending**: Klik tombol sort lagi untuk reverse

### Visual Indicators
- 🟢 **Hijau**: Margin bagus (> 30%)
- 🟠 **Orange**: Margin rendah (20-30%), perhatian!
- 🔴 **Merah**: Margin kritis (< 20%), gunakan alert!

---

## 💬 Fitur 2: Chat dengan Admin

### Cara Akses
1. Dari **Owner Dashboard** → Klik tab **Chat** di bottom navigation
2. Atau langsung ke route: `/admin-chat-list`

### Quick Actions

#### 🆕 Mulai Percakapan Baru
```
1. Klik tombol FAB (+) atau "Mulai Percakapan"
2. Pilih kategori masalah:
   - Bantuan Teknis
   - Pertanyaan Umum
   - Laporan Bug
   - Pengajuan Fitur
   - Masalah Pembayaran
   - Lainnya
3. Ketik deskripsi pertanyaan/masalah
4. Klik "Mulai Percakapan"
5. Admin akan notifikasi dan merespon
```

#### 💬 Balas Pesan
```
1. Klik percakapan untuk membuka
2. Ketik pesan di input field bawah
3. Klik tombol kirim (ikon pesawat)
4. Pesan akan terkirim ke admin
```

#### 📎 Kirim Attachment
```
1. Di chat screen, klik tombol 📎 (attachment)
2. Pilih file/gambar
3. File akan di-upload (auto-compress)
```

#### 😊 Tambah Emoji
```
1. Di input field, klik tombol 😊
2. Pilih emoji yang diinginkan
```

#### 🗂️ Aksi pada Percakapan
Dari chat list, **long press** percakapan untuk:
- **Buka**: Buka chat
- **Arsipkan**: Pindahkan ke arsip (hanya untuk aktif)
- **Restore**: Kembalikan dari arsip
- **Hapus**: Hapus permanen

Atau klik **3 dots** di chat screen untuk:
- **Info**: Lihat detail percakapan
- **Arsipkan**: Arsipkan (aktif)
- **Hapus**: Hapus permanen

#### 🔍 Search & Filter
```
Search:
- Ketik nama admin atau konten pesan di search bar

Filter:
- Semua: Tampilkan semua percakapan
- Aktif: Hanya percakapan yang masih berjalan
- Arsip: Hanya percakapan yang diarsipkan
```

### Unread Messages
- Pesan belum dibaca ditampilkan dengan **angka merah** di chat list
- Juga akan muncul di **bottom navigation** sebagai badge

---

## 🎯 Use Cases

### Use Case 1: Owner ingin tahu margin produk
```
1. Buka HPP management
2. Lihat dashboard summary untuk ringkasan
3. Klik product card untuk detail
4. Margin dihitung otomatis: (Harga - HPP) / HPP * 100%
5. Adjust harga jika margin terlalu rendah
```

### Use Case 2: Owner punya pertanyaan teknis
```
1. Buka Chat dengan Admin
2. Klik "Mulai Percakapan"
3. Pilih "Bantuan Teknis"
4. Jelaskan masalahnya
5. Tunggu admin merespon
6. Bisa kirim screenshot/bukti dengan attachment
```

### Use Case 3: Owner ingin track perubahan harga
```
1. Buka HPP management
2. Klik product card
3. Klik 3 dots → "Riwayat"
4. Lihat semua perubahan harga & kapan
5. Lihat alasan perubahan di catatan
```

### Use Case 4: Owner butuh arsipkan percakapan lama
```
1. Buka Chat dengan Admin
2. Long press percakapan lama
3. Klik "Arsipkan"
4. Percakapan pindah ke tab "Arsip"
5. Bisa di-restore kapan saja
```

---

## ⚙️ Settings & Preferences

### Dark Mode
- Aplikasi mengikuti system theme (iOS/Android)
- Atau bisa diatur manual di profile

### Notification
- Notifikasi otomatis saat ada pesan baru dari admin
- Bisa diatur di phone notification settings

### Language
- Semua teks dalam Bahasa Indonesia
- Tanggal & currency format sesuai locale ID

---

## 🐛 Troubleshooting

### HPP tidak muncul setelah ditambah?
```
✓ Refresh screen dengan pull-to-refresh
✓ Kembali ke dashboard, terus kembali ke HPP
✓ Restart aplikasi
```

### Chat tidak bisa terkirim?
```
✓ Pastikan koneksi internet aktif
✓ Cek input tidak kosong
✓ Coba kirim ulang
✓ Kembali ke chat list, terus buka lagi
```

### Admin tidak bisa diberi tahu?
```
✓ Pastikan kategori dipilih dengan benar
✓ Deskripsi cukup jelas & detail
✓ Admin mungkin sedang offline, tunggu beberapa saat
✓ Cek notifikasi settings di phone
```

### Currency format salah?
```
✓ Format seharusnya "Rp X.XXX"
✓ Jika tidak sesuai, check locale settings
✓ Clear app cache dan restart
```

---

## 📈 Best Practices

### HPP Management
✅ Update HPP secara berkala saat harga bahan berubah
✅ Monitor produk dengan margin rendah
✅ Catat alasan perubahan harga di notes
✅ Gunakan data HPP untuk financial planning

### Chat dengan Admin
✅ Jelaskan masalah sedetail mungkin
✅ Sertakan screenshot jika ada error
✅ Gunakan kategori yang tepat
✅ Tunggu respons admin sebelum close chat
✅ Arsipkan percakapan yang sudah selesai

---

## 🔗 Related Routes

```
Owner Dashboard: /owner-dashboard
Kelola HPP: /hpp
Chat List: /admin-chat-list
Chat Detail: /admin-chat
Transaksi: /transactions
Produk: /products
Pembukuan: /bookkeeping
Profile: /profile
```

---

## 💡 Tips & Tricks

### HPP Management Tips
- Gunakan filter untuk fokus pada produk tertentu
- Sort berdasarkan margin untuk cek produk kurang untung
- Lihat riwayat untuk track trend harga
- Update notes saat ada perubahan harga penting

### Chat Tips
- Simpan chat penting di arsip untuk referensi
- Gunakan emoji untuk membuat chat lebih friendly
- Upload dokumen/bukti untuk masalah yang kompleks
- Follow-up jika admin tidak respon dalam 24 jam

---

## 📞 Need Help?

Jika ada pertanyaan atau masalah:
1. **Buka Chat dengan Admin** (dalam aplikasi)
2. Pilih kategori sesuai masalah
3. Jelaskan detail permasalahan
4. Kirim dan tunggu respons admin

Admin team siap membantu 24/7!

---

**Version**: 1.0
**Last Updated**: September 2026
**Status**: Production Ready ✅
