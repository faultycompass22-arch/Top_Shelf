import 'package:flutter/foundation.dart';
import '../models/menu_item.dart';

class CartController extends ChangeNotifier {
  final Map<String, CartLine> _items = {};

  List<CartLine> get lines => _items.values.toList();

  int get itemCount =>
      _items.values.fold(0, (sum, line) => sum + line.quantity);

  int get totalCents =>
      _items.values.fold(0, (sum, line) => sum + line.totalCents);

  void addItem(MenuItem item) {
    if (_items.containsKey(item.id)) {
      _items[item.id]!.quantity++;
    } else {
      _items[item.id] = CartLine(item: item, quantity: 1);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    if (!_items.containsKey(id)) return;

    final line = _items[id]!;
    if (line.quantity > 1) {
      line.quantity--;
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  void removeLine(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

class CartLine {
  final MenuItem item;
  int quantity;

  CartLine({
    required this.item,
    required this.quantity,
  });

  int get totalCents => item.priceCents * quantity;
}