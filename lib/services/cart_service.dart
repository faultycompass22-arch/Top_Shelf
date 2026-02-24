// lib/services/cart_service.dart

import 'package:url_launcher/url_launcher.dart';
import '../state/cart_store.dart';
import '../models/cart_item.dart';

class CartService {
  static const String _phoneNumber = '9842944811'; // no dashes for sms:

  /// Builds the SMS body from cart contents
  static String buildOrderMessage(CartStore cartStore) {
    if (cartStore.items.isEmpty) {
      return 'I would like to place an order.';
    }

    final buffer = StringBuffer();
    buffer.writeln('New Order:');
    buffer.writeln('---------------------');

    for (CartItem item in cartStore.items) {
      final dollars = (item.priceCents / 100).toStringAsFixed(2);

      buffer.writeln(
        '${item.quantity}x ${item.title} (${item.weightKey}) - \$${dollars}',
      );
    }

    final total = (cartStore.totalCents / 100).toStringAsFixed(2);

    buffer.writeln('---------------------');
    buffer.writeln('Total: \$${total}');
    buffer.writeln('');
    buffer.writeln('Please confirm availability.');

    return buffer.toString();
  }

  /// Launch SMS app with prefilled order
  static Future<void> sendTextOrder(CartStore cartStore) async {
    final message = Uri.encodeComponent(buildOrderMessage(cartStore));
    final uri = Uri.parse('sms:$_phoneNumber?body=$message');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  /// Launch phone dialer
  static Future<void> callStore() async {
    final uri = Uri.parse('tel:$_phoneNumber');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}