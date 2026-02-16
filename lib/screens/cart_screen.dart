import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../state/cart_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const Color kEmerald = Color(0xFF0F5C4A);
  static const Color kWarmOffWhite = Color(0xFFF6F1E7);
  static const Color kGold = Color(0xFFD7B46A);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController _cart = CartController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CartScreen.kWarmOffWhite,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _cart,
          builder: (context, _) {
            final cents = _cart.totalCents;
            final total = cents / 100.0;

            return Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: _cart.itemCount == 0
                      ? const _EmptyCartView()
                      : _CartList(cart: _cart),
                ),
                _BagBar(
                  itemCount: _cart.itemCount,
                  total: total,
                  onCheckout: () => context.push('/checkout'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 64,
      width: double.infinity,
      color: CartScreen.kEmerald,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: const Text(
        'Your Bag',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _EmptyCartView extends StatelessWidget {
  const _EmptyCartView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Your bag is empty',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  final CartController cart;
  const _CartList({required this.cart});

  @override
  Widget build(BuildContext context) {
    final lines = cart.lines;

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      itemCount: lines.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final line = lines[i];
        final price = (line.item.priceCents / 100.0).toStringAsFixed(2);

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: CartScreen.kEmerald, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      line.item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '\$$price',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  _QtyButton(
                    icon: Icons.remove,
                    onTap: () => cart.removeItem(line.item.id),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${line.quantity}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  _QtyButton(
                    icon: Icons.add,
                    onTap: () => cart.addItem(line.item),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 18, color: Colors.black87),
      ),
    );
  }
}

class _BagBar extends StatelessWidget {
  final int itemCount;
  final double total;
  final VoidCallback onCheckout;

  const _BagBar({
    required this.itemCount,
    required this.total,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GestureDetector(
        onTap: itemCount == 0 ? null : onCheckout,
        child: Container(
          width: double.infinity,
          height: 64,
          color: CartScreen.kEmerald,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.shopping_bag_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  Positioned(
                    top: 6,
                    right: 2,
                    child: Icon(
                      Icons.remove_red_eye,
                      size: 14,
                      color: CartScreen.kGold,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  '$itemCount item${itemCount == 1 ? '' : 's'} in bag',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}  •  Checkout',
                style: TextStyle(
                  color: itemCount == 0
                      ? Colors.white.withValues(alpha: 0.55)
                      : Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: itemCount == 0
                    ? Colors.white.withValues(alpha: 0.55)
                    : Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}