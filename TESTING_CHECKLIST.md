# ✅ CRUD Testing Checklist

## Pre-Testing Setup
- [ ] App sudah build & run dengan baik
- [ ] Supabase connection OK (data produk terlihat)
- [ ] Internet connection stabil
- [ ] Database accessible
- [ ] No build errors di console

---

## 🎯 CREATE Testing

### Add Product - Form Validation
- [ ] Buka Admin Panel (Home → Admin button)
- [ ] Klik tombol "+" untuk add produk baru
- [ ] Form halaman terbuka dengan semua field kosong
- [ ] Coba klik "Add Product" tanpa fill form → validation error tampil
- [ ] Fill semua field dengan data valid:
  - Name: "Test Product"
  - Brand: "Test Brand"
  - Category: "Face Care"
  - Price: "50000"
  - Rating: "4.5"
  - Image: "https://via.placeholder.com/300"
  - Short: "Test short description"
  - Description: "Test full description"
- [ ] Klik "Add Product" → Loading indicator tampil
- [ ] Success notification "Product created successfully!"
- [ ] Return ke Admin Panel
- [ ] Produk baru tampil di list

### Add Product - Data Validation
- [ ] Verify data di Supabase (check database)
- [ ] Produk juga tampil di Home page "Best Picks"
- [ ] Produk tampil di Categories page (kategori sesuai)
- [ ] Rating dan price ditampilkan correctly

### Add Product - Edge Cases
- [ ] Add produk dengan nama panjang (100+ chars) → truncate dengan ellipsis
- [ ] Add produk dengan category baru → kategori baru muncul
- [ ] Add produk dengan image URL invalid → placeholder muncul
- [ ] Add produk dengan rating 0 dan 5 → extremes work
- [ ] Add produk dengan price 0 dan 9999999 → extremes work

---

## 📖 READ Testing

### View 1: Home Page Display
- [ ] Buka Home page
- [ ] "Best Picks For You" section tampil
- [ ] Semua produk ditampilkan dalam grid (2 kolom)
- [ ] Product cards menampilkan: image, name, brand, category, rating
- [ ] Scroll down → semua produk visible
- [ ] Loading indicator tampil saat first load
- [ ] No loading setelah initial load

### View 2: Categories Page
- [ ] Navigasi ke Categories tab
- [ ] Semua kategori tampil dalam list
- [ ] "All" category tersedia
- [ ] Klik kategori → CategoryListPage opens
- [ ] Product cards filtered by kategori
- [ ] Empty state jika no products di kategori

### View 3: Admin Panel
- [ ] Home → Admin button → Product Management page opens
- [ ] Semua produk tampil dalam list view
- [ ] Setiap product menampilkan:
  - Thumbnail image
  - Product name (bold)
  - Brand • Category
  - Price • Rating
- [ ] Product count matches actual count
- [ ] Scroll → load more products (lazy loading if many)
- [ ] Pull to refresh → data refresh

### View 4: Product Detail Page
- [ ] Klik produk dari Home → Detail page opens
- [ ] Large product image tampil (full width)
- [ ] Product info: name, brand, category, price, rating dengan star icon
- [ ] Full description tampil lengkap
- [ ] "Beli Sekarang" button visible
- [ ] Favorite button tersedia (not in admin mode)

---

## ✏️ UPDATE Testing

### Edit Product - Via Detail Page
- [ ] Open any product detail
- [ ] Click edit button (✏️) di top right
- [ ] Add/Edit Product page opens dengan prefilled data
- [ ] Verify semua field filled dengan correct data
- [ ] Edit satu field (e.g., change price dari 50000 → 75000)
- [ ] Click "Update Product"
- [ ] Loading indicator tampil
- [ ] Success notification tampil
- [ ] Auto return ke Admin Panel
- [ ] List updated dengan harga baru

### Edit Product - Via Admin Panel
- [ ] Go to Admin Panel
- [ ] Click menu (⋮) on any product
- [ ] Click "Edit"
- [ ] Edit form opens
- [ ] Edit multiple fields (name, brand, description)
- [ ] Click "Update Product"
- [ ] Admin list updated immediately
- [ ] Verify changes di Home page also

### Edit Product - Data Persistence
- [ ] Edit rating dari 4.5 → 5.0 → verify di detail page
- [ ] Edit category → verify tampil di categories page
- [ ] Edit image URL → verify image updated (atau placeholder jika invalid)
- [ ] Edit long text → verify tidak cut off

### Edit Product - Edge Cases
- [ ] Edit dengan exact same data → success (no-op)
- [ ] Edit dengan empty field → validation error
- [ ] Edit price ke 0 → allowed
- [ ] Edit rating ke invalid value → validation error
- [ ] Navigate away during edit → data not saved

---

## 🗑️ DELETE Testing

### Delete Product - Via Detail Page
- [ ] Open product detail
- [ ] Click delete button (🗑️) di top right
- [ ] Confirmation dialog appears with warning
- [ ] Click "Cancel" → dialog closes, product still exists
- [ ] Click delete button again
- [ ] Click "Delete" in dialog → loading tampil
- [ ] Success notification "Product deleted successfully!"
- [ ] Auto return ke appropriate page
- [ ] Verify produk hilang dari Admin list
- [ ] Verify produk hilang dari Home page
- [ ] Verify produk hilang dari Categories

### Delete Product - Via Admin Panel
- [ ] Go to Admin Panel
- [ ] Click menu (⋮) on any product
- [ ] Click "Delete"
- [ ] Confirmation dialog appears
- [ ] Click "Delete"
- [ ] Product removed dari list immediately
- [ ] Verify di Home/Categories juga hilang

### Delete Product - Edge Cases
- [ ] Delete last product → empty state tampil di Admin
- [ ] Delete produk with long name → confirmation works
- [ ] Delete then try to view deleted product → error handled
- [ ] Delete multiple products sequentially → all deleted

---

## 🔍 SEARCH & FILTER Testing

### Search Functionality
- [ ] Go to Admin Panel
- [ ] Search bar visible di top
- [ ] Type product name → filtered results
- [ ] Clear search → all products back
- [ ] Search by brand → filtered correctly
- [ ] Search by category → filtered correctly
- [ ] Search case-insensitive (test with caps)
- [ ] Partial search works (type "face" → all face products)
- [ ] Search with special characters (test handling)
- [ ] Search non-existent → empty state "No products match"

### Filter Behavior
- [ ] Search filters in real-time (as typing)
- [ ] Multiple products with same keyword filter correctly
- [ ] Clear search → refresh full list
- [ ] Refresh (pull-to-refresh) → search maintains

---

## 🎨 UI/UX Testing

### Visual Elements
- [ ] All buttons styled correctly dengan primary color
- [ ] Icons displaying correctly (edit, delete, admin, etc)
- [ ] Product images loading and caching properly
- [ ] Placeholder showing for invalid images
- [ ] Text not overflowing, using ellipsis for long text
- [ ] Spacing/padding consistent across pages

### Loading States
- [ ] Loading spinner appears during operations
- [ ] Loading spinner disappears when complete
- [ ] Multiple operations don't show overlapping spinners
- [ ] Disabled state for buttons during loading

### Navigation
- [ ] All navigation flows working correctly
- [ ] Back button returns to appropriate page
- [ ] Data maintained during navigation
- [ ] No memory leaks (test with repeated navigation)

### Notifications
- [ ] Success messages appear for CREATE/UPDATE/DELETE
- [ ] Error messages appear when operations fail
- [ ] SnackBars not overlapping
- [ ] Messages auto-dismiss after 3-4 seconds

---

## ⚠️ ERROR HANDLING Testing

### Network Errors
- [ ] Disconnect internet → error message
- [ ] Reconnect → retry works
- [ ] Slow connection → timeout handled gracefully
- [ ] Invalid Supabase URL → error shown

### Validation Errors
- [ ] Empty fields → validation error message
- [ ] Invalid price format → error
- [ ] Invalid rating (>5 or <0) → error
- [ ] Invalid image URL → placeholder shown (not error)

### Edge Cases
- [ ] Product with empty image → shows placeholder
- [ ] Product with very long name → displays with truncation
- [ ] Product with special characters → displays correctly
- [ ] Delete while offline → error handled

---

## 📊 Data Consistency Testing

### Add → Read → Update → Delete Cycle
- [ ] Create new product
- [ ] Verify in Home, Categories, Admin, Detail
- [ ] Update product
- [ ] Verify updated in all views
- [ ] Delete product
- [ ] Verify removed from all views

### Multiple Tab Testing (if applicable)
- [ ] Add product in one tab → visible in other tabs
- [ ] Edit in one place → reflected everywhere
- [ ] Delete immediately removes from all views

### Database Verification
- [ ] Check Supabase dashboard
- [ ] Verify product data saved correctly
- [ ] Verify timestamps/metadata (if applicable)
- [ ] No duplicate products created

---

## 🚀 Performance Testing

### Loading Performance
- [ ] Home page loads quickly (<2s)
- [ ] Admin panel loads with many products (100+)
- [ ] Search responsive with instant filtering
- [ ] Images load and cache properly

### Memory Usage
- [ ] No noticeable lag when adding products
- [ ] Smooth scrolling through long lists
- [ ] No crashes with rapid operations
- [ ] No memory leaks on repeated navigation

---

## 🎯 Final Verification

### Functionality Checklist
- [ ] ✅ CREATE: Add new products with all fields
- [ ] ✅ READ: View products in all views (Home, Categories, Admin, Detail)
- [ ] ✅ UPDATE: Edit products from detail page and admin panel
- [ ] ✅ DELETE: Remove products with confirmation
- [ ] ✅ SEARCH: Filter products by name/brand/category

### Quality Checklist
- [ ] ✅ No console errors or warnings
- [ ] ✅ All UI elements properly styled
- [ ] ✅ Responsive design on different screen sizes
- [ ] ✅ Proper error handling and user feedback
- [ ] ✅ Data consistency across all views

### Documentation Checklist
- [ ] ✅ CRUD_GUIDE.md written
- [ ] ✅ QUICK_REFERENCE.md created
- [ ] ✅ Code comments added
- [ ] ✅ IMPLEMENTATION_SUMMARY.md complete

---

## 🎉 Sign Off

When ALL items are checked:
- [ ] Testing completed successfully
- [ ] No critical bugs found
- [ ] App ready for production
- [ ] All CRUD operations working perfectly

**Tested By**: ________________
**Date**: ________________
**Notes**: 

---

**Ready to deploy! 🚀**
