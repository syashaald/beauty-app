import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product.dart';

class ApiService {
  final supabase = Supabase.instance.client;

  // READ - Fetch all products
  Future<List<Product>> fetchProducts({String? category}) async {
    final query = supabase.from('products').select();

    List<dynamic> data;

    if (category == null || category == "All") {
      data = await query;
    } else {
      data = await query.eq("category", category);
    }

    return data.map((e) => Product.fromJson(e)).toList();
  }

  // READ - Fetch categories
  Future<List<String>> fetchCategories() async {
    final data = await supabase.from('products').select('category');

    final set = data.map((e) => e['category'].toString()).toSet();

    return ["All", ...set];
  }

  // READ - Fetch product detail
  Future<Product> fetchProductDetail(String id) async {
    final data = await supabase.from('products').select().eq("id", id).single();
    return Product.fromJson(data);
  }

  // CREATE - Add new product
  Future<Product> createProduct({
    required String name,
    required String brand,
    required String category,
    required int price,
    required double rating,
    required String image,
    required String short,
    required String description,
  }) async {
    final data = await supabase
        .from('products')
        .insert({
          'name': name,
          'brand': brand,
          'category': category,
          'price': price,
          'rating': rating,
          'image': image,
          'short': short,
          'description': description,
        })
        .select()
        .single();

    return Product.fromJson(data);
  }

  // UPDATE - Update product
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
  }) async {
    final data = await supabase
        .from('products')
        .update({
          'name': name,
          'brand': brand,
          'category': category,
          'price': price,
          'rating': rating,
          'image': image,
          'short': short,
          'description': description,
        })
        .eq('id', id)
        .select()
        .single();

    return Product.fromJson(data);
  }

  // DELETE - Delete product
  Future<void> deleteProduct(String id) async {
    await supabase.from('products').delete().eq('id', id);
  }

  // READ - Get all products for admin (with no filter)
  Future<List<Product>> getAllProductsAdmin() async {
    final data = await supabase.from('products').select();
    return data.map((e) => Product.fromJson(e)).toList();
  }
}
