import 'package:flutter/material.dart';

import 'state/cart_store.dart';
import 'widgets/bottom_nav.dart';

import 'features/home/home_page.dart';
import 'features/coa/coa_page.dart';
import 'features/cart/cart_page.dart';
import 'features/account/account_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.cartStore});
  final CartStore cartStore;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(cartStore: widget.cartStore),
      CoaPage(cartStore: widget.cartStore),
      CartPage(cartStore: widget.cartStore),
      const AccountPage(),
    ];

    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNav(
        index: _index,
        cartCount: widget.cartStore.totalQty,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}