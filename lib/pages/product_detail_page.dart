// lib/pages/product_detail_page.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product.dart';
import '../services/favorites_service.dart';
import '../utils/constants.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  FavoritesService? fav;

  @override
  void initState() {
    super.initState();
    FavoritesService.getInstance().then((s) {
      fav = s;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return Scaffold(
      appBar: AppBar(title: Text(p.name), backgroundColor: Colors.white, elevation: 1, foregroundColor: Colors.black),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(imageUrl: p.image, fit: BoxFit.cover, placeholder: (_,__) => Container(color: AppColors.softLilac)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Expanded(child: Text(p.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                  if (fav != null)
                    ValueListenableBuilder<List<String>>(
                      valueListenable: fav!.favorites,
                      builder: (_, list, __) {
                        final sel = list.contains(p.id);
                        return IconButton(
                          onPressed: () => fav!.toggle(p.id),
                          icon: Icon(sel ? Icons.favorite : Icons.favorite_border, color: sel ? AppColors.price : Colors.grey),
                          iconSize: 28,
                        );
                      },
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text('${p.brand} • ${p.category}', style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 12),
              Text('Rp ${p.price}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
              const SizedBox(height: 18),
              const Text('Deskripsi', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(p.description),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 14)),
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Placeholder: Beli Sekarang'))),
                child: const Text('Beli Sekarang'),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
