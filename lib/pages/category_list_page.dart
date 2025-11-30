// lib/pages/category_list_page.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../widgets/product_card.dart';
import 'product_detail_page.dart';

class CategoryListPage extends StatefulWidget {
  final String category;
  const CategoryListPage({super.key, required this.category});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  final api = ApiService();
  List<Product> products = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    api.fetchProducts(category: widget.category).then((data) {
      setState(() {
        products = data;
        loading = false;
      });
    }).catchError((e) {
      setState(() { loading = false; });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text(widget.category), backgroundColor: Colors.white, elevation: 1, foregroundColor: Colors.black),
      body: products.isEmpty
          ? const Center(child: Text('No products in this category'))
          : Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.72, crossAxisSpacing: 12, mainAxisSpacing: 12
                ),
                itemBuilder: (c, i) => ProductCard(
                  product: products[i],
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailPage(product: products[i])));
                  },
                ),
              ),
            ),
    );
  }
}
