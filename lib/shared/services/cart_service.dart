// lib/shared/services/cart_service.dart
import 'package:flutter/foundation.dart';
import '../models/cart_model.dart';

class CartService extends ChangeNotifier {
  // HAPUS singleton pattern
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void addItem(CartItem item) {
    final exists = _items.any((e) => e.id == item.id);
    if (!exists) {
      _items.add(item);
      notifyListeners();
      debugPrint('Item added: ${item.title}, total: ${_items.length}');
    }
  }

  void removeItem(String id) {
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void toggleSelect(String id) {
    final index = _items.indexWhere((e) => e.id == id);
    if (index != -1) {
      _items[index].isSelected = !_items[index].isSelected;
      notifyListeners();
    }
  }

  int get totalPrice => _items
      .where((e) => e.isSelected)
      .fold(0, (sum, e) => sum + e.price);

  void clear() {
    _items.clear();
    notifyListeners();
  }
}