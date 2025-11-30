import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../services/api_service.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final api = ApiService();
  FavoritesService? favService;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    initFav();
  }

  Future<void> initFav() async {
    favService = await FavoritesService.getInstance();
    favService!.favorites.addListener(load);
    load();
  }

  Future<void> load() async {
    final all = await api.fetchProducts();
    final favIds = favService!.favorites.value;
    setState(() {
      products = all.where((p) => favIds.contains(p.id)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.favorite_border, size: 60, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("No favorites yet",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (_, i) => ProductCard(
                product: products[i],
                onTap: () {},
              ),
            ),
    );
  }
}
