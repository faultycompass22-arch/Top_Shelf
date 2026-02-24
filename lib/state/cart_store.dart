// lib/state/cart_store.dart

import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartStore extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalItems =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  int get totalCents =>
      _items.fold(0, (sum, item) => sum + (item.priceCents * item.quantity));

  void addItem(CartItem item) {
    final index = _items.indexWhere(
          (e) =>
      e.id == item.id &&
          e.weightKey == item.weightKey,
    );

    if (index != -1) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + item.quantity,
      );
    } else {
      _items.add(item);
    }

    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.removeWhere(
          (e) =>
      e.id == item.id &&
          e.weightKey == item.weightKey,
    );
    notifyListeners();
  }

  void updateQuantity(CartItem item, int quantity) {
    final index = _items.indexWhere(
          (e) =>
      e.id == item.id &&
          e.weightKey == item.weightKey,
    );

    if (index != -1) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = _items[index].copyWith(quantity: quantity);
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}