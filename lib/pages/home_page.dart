import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/product_card.dart';
import '../models/product.dart';
import 'product_detail_page.dart'; // pastikan ini ada

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final api = ApiService();
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    final data = await api.fetchProducts();
    setState(() => products = data);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            _buildBanner(),

            const SizedBox(height: 25),

            const Text(
              "Best Picks For You",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 18),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (_, i) {
                final p = products[i];
                return ProductCard(
                  product: p,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(product: p),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        image: const DecorationImage(
          image: AssetImage("assets/images/banner.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(20),
      child: const Text(
        "Discover Your\nSkincare Routine",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          shadows: [
            Shadow(
              offset: Offset(0, 1.5),
              blurRadius: 6,
              color: Colors.black54,
            )
          ],
        ),
      ),
    );
  }
}
