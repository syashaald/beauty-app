// lib/services/favorites_service.dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const _key = 'favorites_ids';
  static FavoritesService? _instance;
  final ValueNotifier<List<String>> favorites = ValueNotifier<List<String>>([]);

  FavoritesService._();

  static Future<FavoritesService> getInstance() async {
    if (_instance != null) return _instance!;
    final s = FavoritesService._();
    await s._load();
    _instance = s;
    return s;
  }

  Future<void> _load() async {
    final sp = await SharedPreferences.getInstance();
    favorites.value = sp.getStringList(_key) ?? [];
  }

  Future<void> toggle(String id) async {
    final sp = await SharedPreferences.getInstance();
    final current = List<String>.from(favorites.value);
    if (current.contains(id)) {
      current.remove(id);
    } else {
      current.add(id);
    }
    favorites.value = current;
    await sp.setStringList(_key, current);
  }

  bool isFavorite(String id) {
    return favorites.value.contains(id);
  }
}
