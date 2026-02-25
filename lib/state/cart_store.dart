import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../menu/menu_item.dart';

class CartStore extends ChangeNotifier {
  final List<CartItem> _items = [];
  List<CartItem> get items => List.unmodifiable(_items);

  int get totalQty => _items.fold(0, (sum, x) => sum + 1);

  int get totalCents => _items.fold(0, (sum, x) => sum + x.priceCents);

  void add(MenuItem item, {required int grams, required int priceCents, String? note}) {
    _items.add(CartItem(item: item, grams: grams, priceCents: priceCents, note: note));
    notifyListeners();
  }

  void removeAt(int index) {
    if (index < 0 || index >= _items.length) return;
    _items.removeAt(index);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}