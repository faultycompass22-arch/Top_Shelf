// lib/services/cart_service.dart
import '../state/cart_store.dart';
import '../components/utils/launchers.dart';
import '../core/constants/app_constants.dart';

class CartService {
  static Future<void> sendTextOrder(CartStore cartStore) async {
    final body = buildOrderMessage(cartStore);
    await launchTextOrder(body: body);
  }

  static Future<void> callStore() async {
    await launchCallOrder();
  }

  static String buildOrderMessage(CartStore cartStore) {
    final items = cartStore.items;
    if (items.isEmpty) {
      return "${AppConstants.smsGreeting} from ${AppConstants.storeName}.";
    }

    final b = StringBuffer();
    b.writeln("${AppConstants.smsGreeting} from ${AppConstants.storeName}.");
    b.writeln("");
    b.writeln("Order:");
    for (final i in items) {
      b.writeln("- ${i.title} • ${i.weightLabel} • Qty ${i.qty} • \$${(i.priceCents / 100).toStringAsFixed(2)}");
    }
    b.writeln("");
    b.writeln("Subtotal: \$${(cartStore.totalCents / 100).toStringAsFixed(2)}");
    b.writeln("");
    b.writeln("Name: ${AppConstants.ownerName}");

    return b.toString().trim();
  }
}