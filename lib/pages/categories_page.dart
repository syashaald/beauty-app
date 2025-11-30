// lib/pages/categories_page.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'category_list_page.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final api = ApiService();
  List<String> categories = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    api.fetchCategories().then((c) {
      setState(() {
        categories = c;
        loading = false;
      });
    }).catchError((e) {
      setState(() { loading = false; });
      // optionally show error
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: const Text('Categories'), backgroundColor: Colors.white, elevation: 1, foregroundColor: Colors.black),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (c, i) {
          final name = categories[i];
          return ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            tileColor: Colors.white,
            title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryListPage(category: name)));
            },
          );
        },
      ),
    );
  }
}
