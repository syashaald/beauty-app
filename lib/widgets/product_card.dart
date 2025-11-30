// lib/widgets/product_card.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product.dart';
import '../utils/constants.dart';
import '../services/favorites_service.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  FavoritesService? favService;

  @override
  void initState() {
    super.initState();
    FavoritesService.getInstance().then((s) {
      favService = s;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE + FAVORITE BUTTON
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14),
                    ),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CachedNetworkImage(
                        imageUrl: p.image,
                        fit: BoxFit.cover,
                        placeholder: (_, __) =>
                            Container(color: AppColors.softLilac),
                        errorWidget: (_, __, ___) => Container(
                          color: AppColors.softLilac,
                          child: const Icon(Icons.image_not_supported),
                        ),
                      ),
                    ),
                  ),

                  // FAVORITE BUTTON
                  Positioned(
                    right: 8,
                    top: 8,
                    child: favService == null
                        ? const SizedBox.shrink()
                        : ValueListenableBuilder<List<String>>(
                            valueListenable: favService!.favorites,
                            builder: (_, list, __) {
                              final isFav = list.contains(p.id);
                              return GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () async {
                                  await favService!.toggle(p.id);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        isFav ? AppColors.price : Colors.grey,
                                    size: 20,
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),

              // CONTENT
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${p.brand} • ${p.category}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rp ${p.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
