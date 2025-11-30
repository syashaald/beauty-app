# 🚀 Quick Start - CRUD Operations

## Akses Admin Panel
```
Home Page → Tombol "Admin" (Kanan Atas) → Admin Panel
```

---

## 1️⃣ CREATE - Tambah Produk Baru

### Lokasi 1: Dari Admin Panel
```
Admin Panel → Tombol "+" → Isi Form → Klik "Add Product"
```

### Lokasi 2: Dari Floating Button
```
Admin Panel → Floating Button "+" → Isi Form → Klik "Add Product"
```

**Field Wajib Diisi:**
- Product Name: Nama produk
- Brand: Merek produk
- Category: Kategori (e.g., Face Care, Body Care)
- Price: Harga (angka)
- Rating: Rating 0-5
- Image URL: Link gambar
- Short Description: Deskripsi singkat
- Full Description: Deskripsi lengkap

✅ Produk langsung tersimpan dan tampil di Home/Categories

---

## 2️⃣ READ - Lihat Produk

### View 1: Home Page
```
Buka App → Lihat semua produk di "Best Picks For You"
```

### View 2: Categories
```
Navigasi ke "Categories" tab → Pilih kategori → Lihat produk kategori itu
```

### View 3: Admin Panel
```
Home → Admin → Lihat semua produk dalam bentuk list dengan detail
```

### View 4: Detail Product
```
Klik produk apapun → Lihat detail lengkap (nama, brand, harga, rating, deskripsi)
```

---

## 3️⃣ UPDATE - Edit Produk

### Cara 1: Dari Product Detail Page
```
1. Klik produk di Home/Categories
2. Detail page terbuka
3. Klik tombol ✏️ Edit di kanan atas
4. Form terbuka dengan data produk
5. Ubah yang ingin diubah
6. Klik "Update Product"
```

### Cara 2: Dari Admin Panel
```
1. Home → Admin → Admin Panel
2. Temukan produk yang mau diedit
3. Klik menu ⋮ (tiga titik) di sebelah kanan
4. Pilih "Edit"
5. Form terbuka
6. Ubah data → Klik "Update Product"
```

✅ Perubahan langsung tersimpan dan terlihat di semua view

---

## 4️⃣ DELETE - Hapus Produk

### Cara 1: Dari Product Detail Page
```
1. Buka detail produk
2. Klik tombol 🗑️ Delete di kanan atas
3. Konfirmasi "Delete"
4. Produk terhapus selamanya
```

### Cara 2: Dari Admin Panel
```
1. Home → Admin
2. Cari produk di search bar (optional)
3. Klik menu ⋮ pada produk
4. Pilih "Delete"
5. Konfirmasi
6. Produk dihapus
```

⚠️ **Perhatian**: Penghapusan tidak bisa dibatalkan!

---

## 🔍 SEARCH & FILTER

### Di Admin Panel
```
Admin Panel → Search Bar (Di atas list)
→ Ketik nama produk / brand / kategori
→ Hasil otomatis di-filter
```

**Cari berdasarkan:**
- Nama produk
- Brand name
- Kategori

---

## 💡 Tips Penting

### ✅ DO:
- ✅ Gunakan URL gambar yang valid (HTTPS)
- ✅ Pastikan rating antara 0-5
- ✅ Isi semua field yang wajib
- ✅ Gunakan kategori yang konsisten
- ✅ Refresh jika tidak lihat perubahan

### ❌ DON'T:
- ❌ Jangan delete produk yang sedang dilihat user
- ❌ Jangan gunakan image URL yang invalid
- ❌ Jangan copy exact sama dengan product lain
- ❌ Jangan lupa save setelah edit

---

## 🎨 UI Elements

| Fitur | Icon | Lokasi |
|-------|------|--------|
| Admin | 👤 | Home (Kanan Atas) |
| Add | ➕ | Admin Panel (Bawah Kanan) |
| Edit | ✏️ | Detail Page (Kanan Atas) |
| Delete | 🗑️ | Detail Page (Kanan Atas) |
| Menu | ⋮ | Admin List (Kanan) |
| Search | 🔍 | Admin Panel (Atas) |

---

## ⚡ Keyboard Shortcuts

| Aksi | Shortcut |
|------|----------|
| Add Product | Admin → + |
| Edit Product | Detail → ✏️ |
| Delete Product | Detail → 🗑️ |
| Search | Admin → Search Bar |
| Refresh | Pull Down di Admin |

---

## 🐛 Troubleshooting

| Problem | Solution |
|---------|----------|
| Produk tidak muncul | Refresh page / Check internet |
| Edit tidak tersimpan | Check validation errors |
| Gambar tidak muncul | Verify URL is valid & HTTPS |
| Admin button hilang | Scroll ke atas di home |
| Search tidak bekerja | Clear search & coba lagi |

---

## 📊 Data Struktur

```json
{
  "id": "unique_id",
  "name": "Product Name",
  "brand": "Brand Name",
  "category": "Category",
  "price": 99000,
  "rating": 4.5,
  "image": "https://...",
  "short": "Short description",
  "description": "Full description"
}
```

---

## 🔗 Navigation Map

```
Home Page
  ├─ Admin Button → Product Management
  │   ├─ Search & Filter
  │   ├─ Add Product (+)
  │   ├─ Edit Product (⋮→Edit)
  │   └─ Delete Product (⋮→Delete)
  └─ Product Card → Product Detail
      ├─ Edit (✏️)
      └─ Delete (🗑️)

Categories Page
  └─ Category → Product List → Product Detail (Edit/Delete)

Favorites Page
  └─ Favorited Products
```

---

**Siap pakai! Semua fitur CRUD sudah berfungsi dengan baik.** 🎉
