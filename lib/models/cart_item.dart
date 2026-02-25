import '../menu/menu_item.dart';

/// Represents one line item in the cart.
///
/// - [grams] is the selected weight (1, 3.5, 7, 14, etc) expressed in grams.
/// - [priceCents] is the price for that selected weight.
class CartItem {
  CartItem({
    required this.item,
    required this.grams,
    required this.priceCents,
    this.note,
  });

  final MenuItem item;
  int grams;
  int priceCents;
  String? note;

  // Convenience getters used across UI/services.
  String get title => item.title;

  /// Quantity per line item. This app treats each line item as qty=1
  /// and uses [grams] for the actual amount.
  int get qty => 1;

  String get weightLabel {
    // grams is int here; still keep formatting future-proof.
    final g = grams;
    return '${g.toString()} g';
  }

  int get lineTotalCents => priceCents;

  Map<String, dynamic> toJson() => {
        'id': item.id,
        'title': item.title,
        'grams': grams,
        'priceCents': priceCents,
        'note': note,
      };

  static CartItem fromJson(Map<String, dynamic> json, MenuItem item) {
    return CartItem(
      item: item,
      grams: (json['grams'] as num?)?.toInt() ?? 0,
      priceCents: (json['priceCents'] as num?)?.toInt() ?? 0,
      note: json['note'] as String?,
    );
  }
}
