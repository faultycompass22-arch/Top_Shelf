// lib/state/cart_store.dart
import 'package:flutter/foundation.dart';

import '../features/menu/menu_item.dart';

class CartLine {
  CartLine({
    required this.item,
    required this.qty,
  });

  final MenuItem item;
  int qty;

  double get lineTotal => item.price * qty;
}

class CartStore extends ChangeNotifier {
  CartStore._();
  static final CartStore instance = CartStore._();

  final List<CartLine> _lines = [];

  List<CartLine> get lines => List.unmodifiable(_lines);

  int get totalQty {
    var sum = 0;
    for (final l in _lines) {
      sum += l.qty;
    }
    return sum;
  }

  double get subtotal {
    var sum = 0.0;
    for (final l in _lines) {
      sum += l.lineTotal;
    }
    return sum;
  }

  int qtyFor(String menuItemId) {
    final idx = _lines.indexWhere((l) => l.item.id == menuItemId);
    if (idx < 0) return 0;
    return _lines[idx].qty;
  }

  void add(MenuItem item, {int qty = 1}) {
    if (qty <= 0) return;

    final idx = _lines.indexWhere((l) => l.item.id == item.id);
    if (idx >= 0) {
      _lines[idx].qty += qty;
    } else {
      _lines.add(CartLine(item: item, qty: qty));
    }
    notifyListeners();
  }

  void setQty(MenuItem item, int qty) {
    final idx = _lines.indexWhere((l) => l.item.id == item.id);
    if (idx < 0) {
      if (qty > 0) {
        _lines.add(CartLine(item: item, qty: qty));
        notifyListeners();
      }
      return;
    }

    if (qty <= 0) {
      _lines.removeAt(idx);
      notifyListeners();
      return;
    }

    _lines[idx].qty = qty;
    notifyListeners();
  }

  void inc(MenuItem item) => setQty(item, qtyFor(item.id) + 1);
  void dec(MenuItem item) => setQty(item, qtyFor(item.id) - 1);

  void remove(String menuItemId) {
    _lines.removeWhere((l) => l.item.id == menuItemId);
    notifyListeners();
  }

  void clear() {
    _lines.clear();
    notifyListeners();
  }

  /// Builds the prefilled SMS body for checkout
  String buildOrderText({String greeting = "Hi, I'd like to order:"}) {
    final buffer = StringBuffer();
    buffer.writeln(greeting);
    buffer.writeln();

    for (final l in _lines) {
      buffer.writeln("- ${l.qty}x ${l.item.name} (${l.item.type})  \$${l.item.price.toStringAsFixed(2)}");
    }

    buffer.writeln();
    buffer.writeln("Subtotal: \$${subtotal.toStringAsFixed(2)}");
    return buffer.toString().trim();
  }
}