// lib/features/home/home_page.dart
import 'package:flutter/material.dart';

import '../../services/menu_repository.dart';
import '../../models/product.dart';
import '../../state/cart_store.dart';

import 'widgets/home_header.dart';
import 'widgets/search_bar.dart';
import 'widgets/flower_bar.dart';
import 'widgets/menu_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.cartStore});
  final CartStore cartStore;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _repo = MenuRepository();
  List<Product> _all = const [];
  List<Product> _filtered = const [];
  String _query = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final items = await _repo.fetchMenu();
    if (!mounted) return;
    setState(() {
      _all = items;
      _filtered = items;
    });
  }

  void _applyQuery(String q) {
    setState(() {
      _query = q.trim().toLowerCase();
      if (_query.isEmpty) {
        _filtered = _all;
      } else {
        _filtered = _all.where((p) {
          final t = p.title.toLowerCase();
          final s = p.scent.toLowerCase();
          final ty = p.type.toLowerCase();
          return t.contains(_query) || s.contains(_query) || ty.contains(_query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          const SliverToBoxAdapter(child: HomeHeader()),
          SliverToBoxAdapter(
            child: SearchBarWidget(
              initialValue: _query,
              onChanged: _applyQuery,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          const SliverToBoxAdapter(child: FlowerBar()),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: MenuGrid(
              items: _filtered,
              cartStore: widget.cartStore,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 18)),
        ],
      ),
    );
  }
}