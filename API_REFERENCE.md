# 📚 API Service Reference

## Complete ApiService Documentation

---

## 📖 Overview

`ApiService` adalah service class yang handle semua komunikasi dengan Supabase database untuk operasi CRUD produk.

**Location**: `lib/services/api_service.dart`

---

## 🔧 All Available Methods

### 1️⃣ CREATE Operations

#### ✨ `createProduct()`
**Fungsi**: Membuat produk baru di database

```dart
Future<Product> createProduct({
  required String name,
  required String brand,
  required String category,
  required int price,
  required double rating,
  required String image,
  required String short,
  required String description,
}) async
```

**Parameters**:
| Param | Type | Required | Example |
|-------|------|----------|---------|
| name | String | ✅ | "Face Cleanser" |
| brand | String | ✅ | "Luxury Beauty" |
| category | String | ✅ | "Face Care" |
| price | int | ✅ | 50000 |
| rating | double | ✅ | 4.5 |
| image | String | ✅ | "https://example.com/image.jpg" |
| short | String | ✅ | "Best cleanser ever" |
| description | String | ✅ | "Gentle face cleanser for..." |

**Returns**: `Future<Product>` - Product yang baru dibuat

**Usage Example**:
```dart
final api = ApiService();

final newProduct = await api.createProduct(
  name: 'Moisturizer Cream',
  brand: 'Skincare Plus',
  category: 'Face Care',
  price: 75000,
  rating: 4.8,
  image: 'https://example.com/moisturizer.jpg',
  short: 'Hydrating cream',
  description: 'Deep moisturizing cream for dry skin',
);

print('Created: ${newProduct.name}');
```

**Error Handling**:
```dart
try {
  await api.createProduct(...);
} catch (e) {
  print('Error creating product: $e');
  // Handle error
}
```

---

### 2️⃣ READ Operations

#### 📖 `fetchProducts()`
**Fungsi**: Ambil daftar produk dengan optional filtering by category

```dart
Future<List<Product>> fetchProducts({String? category}) async
```

**Parameters**:
| Param | Type | Required | Default | Example |
|-------|------|----------|---------|---------|
| category | String? | ❌ | null (all) | "Face Care" |

**Returns**: `Future<List<Product>>` - List produk

**Usage Examples**:
```dart
// Ambil semua produk
List<Product> allProducts = await api.fetchProducts();

// Ambil produk berdasarkan kategori
List<Product> faceProducts = await api.fetchProducts(category: 'Face Care');

// Ambil kategori "All" (sama seperti null)
List<Product> allAgain = await api.fetchProducts(category: 'All');
```

---

#### 📖 `fetchProductDetail()`
**Fungsi**: Ambil detail single product by ID

```dart
Future<Product> fetchProductDetail(String id) async
```

**Parameters**:
| Param | Type | Required | Example |
|-------|------|----------|---------|
| id | String | ✅ | "123abc" |

**Returns**: `Future<Product>` - Single product

**Usage Example**:
```dart
try {
  Product product = await api.fetchProductDetail('123abc');
  print('Product: ${product.name}');
} catch (e) {
  print('Product not found');
}
```

---

#### 📖 `fetchCategories()`
**Fungsi**: Ambil daftar kategori unik dari semua produk

```dart
Future<List<String>> fetchCategories() async
```

**Parameters**: None

**Returns**: `Future<List<String>>` - List kategori (include "All")

**Usage Example**:
```dart
List<String> categories = await api.fetchCategories();
// Result: ['All', 'Face Care', 'Body Care', 'Hair Care', ...]

for (String cat in categories) {
  print(cat);
}
```

---

#### 📖 `getAllProductsAdmin()`
**Fungsi**: Ambil ALL produk tanpa filter (untuk admin panel)

```dart
Future<List<Product>> getAllProductsAdmin() async
```

**Parameters**: None

**Returns**: `Future<List<Product>>` - All products

**Difference from fetchProducts()**: 
- `fetchProducts()` - Hanya ambil produk di kategori selected
- `getAllProductsAdmin()` - Ambil SEMUA produk tanpa filter

**Usage Example**:
```dart
List<Product> adminProducts = await api.getAllProductsAdmin();
print('Total products: ${adminProducts.length}');
```

---

### 3️⃣ UPDATE Operations

#### ✏️ `updateProduct()`
**Fungsi**: Update produk existing

```dart
Future<Product> updateProduct({
  required String id,
  required String name,
  required String brand,
  required String category,
  required int price,
  required double rating,
  required String image,
  required String short,
  required String description,
}) async
```

**Parameters**:
| Param | Type | Required | Example |
|-------|------|----------|---------|
| id | String | ✅ | "123abc" |
| name | String | ✅ | "New Name" |
| brand | String | ✅ | "New Brand" |
| category | String | ✅ | "Face Care" |
| price | int | ✅ | 60000 |
| rating | double | ✅ | 4.7 |
| image | String | ✅ | "https://..." |
| short | String | ✅ | "New short" |
| description | String | ✅ | "New description" |

**Returns**: `Future<Product>` - Updated product

**Usage Example**:
```dart
final updatedProduct = await api.updateProduct(
  id: '123abc',
  name: 'Premium Cleanser',
  brand: 'Luxury Beauty',
  category: 'Face Care',
  price: 65000,
  rating: 4.9,
  image: 'https://example.com/new-image.jpg',
  short: 'Premium facial cleanser',
  description: 'Ultra-luxury cleanser with organic ingredients',
);

print('Updated: ${updatedProduct.name}');
```

**Important Notes**:
- Semua field harus diberikan (tidak ada partial update)
- ID harus valid (produk harus exist)
- Biasanya prefill form dengan data existing

---

### 4️⃣ DELETE Operations

#### 🗑️ `deleteProduct()`
**Fungsi**: Hapus produk dari database

```dart
Future<void> deleteProduct(String id) async
```

**Parameters**:
| Param | Type | Required | Example |
|-------|------|----------|---------|
| id | String | ✅ | "123abc" |

**Returns**: `Future<void>` - No return value

**Usage Example**:
```dart
try {
  await api.deleteProduct('123abc');
  print('Product deleted successfully');
} catch (e) {
  print('Error deleting: $e');
}
```

**Important Notes**:
- Delete adalah PERMANENT - tidak bisa undo
- Sebelum delete, biasanya tampilkan confirmation dialog
- After delete, refresh UI untuk reflect changes

---

## 🎯 Common Usage Patterns

### Pattern 1: Load & Display Products
```dart
final api = ApiService();
List<Product> products = [];

// Load all products
void loadProducts() async {
  products = await api.fetchProducts();
  setState(() {}); // Trigger UI update
}

// Load by category
void loadByCategory(String category) async {
  products = await api.fetchProducts(category: category);
  setState(() {});
}
```

### Pattern 2: Create New Product
```dart
await api.createProduct(
  name: formData['name'],
  brand: formData['brand'],
  category: formData['category'],
  price: int.parse(formData['price']),
  rating: double.parse(formData['rating']),
  image: formData['image'],
  short: formData['short'],
  description: formData['description'],
);

// Then refresh list
loadProducts();
```

### Pattern 3: Edit & Save
```dart
// Load existing data
Product existing = await api.fetchProductDetail(productId);

// User edits form...

// Save changes
await api.updateProduct(
  id: existing.id,
  name: editedName,
  brand: editedBrand,
  // ... other fields
);

// Refresh & navigate back
loadProducts();
Navigator.pop(context);
```

### Pattern 4: Delete with Confirmation
```dart
bool? confirmed = await showDialog<bool>(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Delete ${product.name}?'),
    content: Text('Are you sure?'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, false),
        child: Text('Cancel'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, true),
        child: Text('Delete', style: TextStyle(color: Colors.red)),
      ),
    ],
  ),
);

if (confirmed == true) {
  await api.deleteProduct(product.id);
  loadProducts();
}
```

### Pattern 5: Search/Filter (Client-side)
```dart
List<Product> filteredProducts = products.where((p) =>
  p.name.toLowerCase().contains(query.toLowerCase()) ||
  p.brand.toLowerCase().contains(query.toLowerCase()) ||
  p.category.toLowerCase().contains(query.toLowerCase())
).toList();
```

---

## 🔄 Data Flow Diagrams

### CREATE Flow
```
Form Input
   ↓
Validation
   ↓
api.createProduct()
   ↓
Supabase INSERT
   ↓
Product returned
   ↓
Success Notification
   ↓
Refresh list
```

### UPDATE Flow
```
Get existing product
   ↓
Show in form (prefilled)
   ↓
User edits
   ↓
Validation
   ↓
api.updateProduct()
   ↓
Supabase UPDATE
   ↓
Product returned
   ↓
Success Notification
   ↓
Refresh list
```

### DELETE Flow
```
Show product
   ↓
User clicks delete
   ↓
Confirmation dialog
   ↓ (if yes)
api.deleteProduct()
   ↓
Supabase DELETE
   ↓
Success Notification
   ↓
Refresh list
```

---

## ⚠️ Error Handling

### Common Errors & Handling
```dart
try {
  await api.createProduct(...);
} catch (e) {
  if (e.toString().contains('connection')) {
    print('Network error');
    // Show offline message
  } else if (e.toString().contains('auth')) {
    print('Authentication error');
    // Show auth error
  } else {
    print('Unknown error: $e');
    // Show generic error
  }
}
```

### Best Practices
1. **Always use try-catch** dengan API calls
2. **Show user feedback** saat loading
3. **Display error messages** yang user-friendly
4. **Retry logic** untuk network errors
5. **Validation** sebelum submit

---

## 🚀 Performance Tips

1. **Caching**
   ```dart
   // Cache hasil untuk avoid repeated queries
   List<String>? _categoriesCache;
   
   Future<List<String>> getCategories() async {
     if (_categoriesCache != null) return _categoriesCache;
     _categoriesCache = await api.fetchCategories();
     return _categoriesCache!;
   }
   ```

2. **Pagination** (untuk production)
   ```dart
   // Implement untuk handle large datasets
   Future<List<Product>> fetchProductsPaginated(int page, int limit)
   ```

3. **Lazy Loading** (images)
   ```dart
   // Already implemented dengan cached_network_image
   CachedNetworkImage(imageUrl: product.image)
   ```

---

## 📊 Method Summary Table

| Method | CRUD | Input | Output | Purpose |
|--------|------|-------|--------|---------|
| createProduct() | C | Product data | Product | Buat produk baru |
| fetchProducts() | R | Category? | List<Product> | Ambil produk |
| fetchProductDetail() | R | Product ID | Product | Ambil 1 produk |
| fetchCategories() | R | - | List<String> | Ambil kategori |
| getAllProductsAdmin() | R | - | List<Product> | Ambil semua |
| updateProduct() | U | Product data + ID | Product | Edit produk |
| deleteProduct() | D | Product ID | void | Hapus produk |

---

## 🔗 Related Files

- **Model**: `lib/models/product.dart` - Product class
- **Pages**: `lib/pages/` - Pages yang gunakan API
- **Main**: `lib/main.dart` - Supabase initialization

---

## ✅ Checklist for Using ApiService

- [ ] Import ApiService: `import '../services/api_service.dart';`
- [ ] Create instance: `final api = ApiService();`
- [ ] Wrap calls in try-catch
- [ ] Show loading indicator
- [ ] Handle errors
- [ ] Show success notification
- [ ] Refresh UI after changes
- [ ] Update cached data if needed

---

## 📞 Examples for Each Operation

### CREATE Example
```dart
try {
  final product = await ApiService().createProduct(
    name: 'Lip Balm',
    brand: 'Natural Beauty',
    category: 'Lips',
    price: 25000,
    rating: 4.3,
    image: 'https://example.com/lip.jpg',
    short: 'Moisturizing lip balm',
    description: 'Natural lip balm with organic ingredients',
  );
  print('Created: ${product.name}');
} catch (e) {
  print('Error: $e');
}
```

### READ Example
```dart
try {
  // Get all
  List<Product> all = await ApiService().fetchProducts();
  
  // Get by category
  List<Product> faceProducts = 
    await ApiService().fetchProducts(category: 'Face Care');
  
  // Get detail
  Product detail = 
    await ApiService().fetchProductDetail('123');
} catch (e) {
  print('Error: $e');
}
```

### UPDATE Example
```dart
try {
  final updated = await ApiService().updateProduct(
    id: '123',
    name: 'New Name',
    brand: 'New Brand',
    category: 'Face Care',
    price: 80000,
    rating: 4.9,
    image: 'https://example.com/new.jpg',
    short: 'New short desc',
    description: 'New full description',
  );
  print('Updated: ${updated.name}');
} catch (e) {
  print('Error: $e');
}
```

### DELETE Example
```dart
try {
  await ApiService().deleteProduct('123');
  print('Deleted successfully');
} catch (e) {
  print('Error: $e');
}
```

---

**API Reference Complete!** ✅

*For more info, check CRUD_GUIDE.md or see pages/ directory for usage examples.*
