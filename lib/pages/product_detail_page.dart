// lib/pages/product_detail_page.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product.dart';
import '../services/favorites_service.dart';
import '../services/api_service.dart';
import '../utils/constants.dart';
import 'add_edit_product_page.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final bool isAdmin;
  const ProductDetailPage({
    super.key,
    required this.product,
    this.isAdmin = false,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  FavoritesService? fav;
  final api = ApiService();

  @override
  void initState() {
    super.initState();
    FavoritesService.getInstance().then((s) {
      fav = s;
      setState(() {});
    });
  }

  Future<void> _deleteProduct() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await api.deleteProduct(widget.product.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product deleted successfully!')),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _editProduct() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddEditProductPage(product: widget.product),
      ),
    );

    if (result == true && mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(p.name),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
        actions: widget.isAdmin
            ? [
                IconButton(
                  onPressed: _editProduct,
                  icon: const Icon(Icons.edit),
                  tooltip: 'Edit Product',
                ),
                IconButton(
                  onPressed: _deleteProduct,
                  icon: const Icon(Icons.delete, color: Colors.red),
                  tooltip: 'Delete Product',
                ),
              ]
            : null,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(
              imageUrl: p.image,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: AppColors.softLilac),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        p.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (fav != null && !widget.isAdmin)
                      ValueListenableBuilder<List<String>>(
                        valueListenable: fav!.favorites,
                        builder: (_, list, __) {
                          final sel = list.contains(p.id);
                          return IconButton(
                            onPressed: () => fav!.toggle(p.id),
                            icon: Icon(
                              sel ? Icons.favorite : Icons.favorite_border,
                              color: sel ? AppColors.price : Colors.grey,
                            ),
                            iconSize: 28,
                          );
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${p.brand} • ${p.category}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Text(
                  'Rp ${p.price}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      '${p.rating} Rating',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Text(
                  'Deskripsi',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(p.description),
                const SizedBox(height: 24),
                if (!widget.isAdmin)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Placeholder: Beli Sekarang'),
                      ),
                    ),
                    child: const Text('Beli Sekarang'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
