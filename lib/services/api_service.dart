import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product.dart';

class ApiService {
  final supabase = Supabase.instance.client;

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

  Future<List<String>> fetchCategories() async {
    final data = await supabase.from('products').select('category');

    final set = data.map((e) => e['category'].toString()).toSet();

    return ["All", ...set];
  }

  Future<Product> fetchProductDetail(String id) async {
    final data = await supabase.from('products').select().eq("id", id).single();
    return Product.fromJson(data);
  }
}
