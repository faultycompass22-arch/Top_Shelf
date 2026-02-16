import 'dart:async';
import 'package:flutter/foundation.dart';

import '../data/menu_repository.dart';
import '../models/menu_item.dart';

class MenuController extends ChangeNotifier {
  final MenuRepository _repo = MenuRepository();

  bool loading = false;
  List<MenuItem> items = [];

  StreamSubscription<List<MenuItem>>? _sub;

  Future<void> load() async {
    loading = true;
    notifyListeners();

    items = await _repo.fetchMenu();

    loading = false;
    notifyListeners();

    _sub?.cancel();
    _sub = _repo.watchMenu().listen((data) {
      items = data;
      notifyListeners();
    });
  }

  Future<void> updateItem(MenuItem updated) async {
    await _repo.saveMenuItem(updated);
  }

  MenuItem? byId(String id) {
    try {
      return items.firstWhere((x) => x.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}