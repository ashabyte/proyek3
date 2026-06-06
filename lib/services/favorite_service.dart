import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared/models/user_model.dart';

class FavoriteService extends ChangeNotifier {
  List<ServiceModel> _favorites = [];
  bool _isLoading = false;

  List<ServiceModel> get favorites => _favorites;
  bool get isLoading => _isLoading;

  FavoriteService() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList('favorite_items') ?? [];
    
    _favorites = favList.map((e) => ServiceModel.fromJson(jsonDecode(e))).toList();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavorite(ServiceModel service) async {
    final index = _favorites.indexWhere((e) => e.id == service.id);
    
    if (index != -1) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(service);
    }

    final prefs = await SharedPreferences.getInstance();
    final favList = _favorites.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('favorite_items', favList);
    
    notifyListeners();
  }

  bool isFavorite(String serviceId) {
    return _favorites.any((e) => e.id == serviceId);
  }
}
