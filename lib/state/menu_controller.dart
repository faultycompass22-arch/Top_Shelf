import 'package:flutter/foundation.dart';


import '../data/menu_repository.dart';
import '../models/menu_item.dart';


class MenuController extends ChangeNotifier {
  final MenuRepository _repo = MenuRepository();


  bool loading = false;
  List<MenuItem> items = [];


  Future<void> load() async {
    loading = true;
    notifyListeners();
    items = await _repo.fetchMenu();
    loading = false;
    notifyListeners();
  }


  Future<void> updateItem(MenuItem updated) async {
    final idx = items.indexWhere((x) => x.id == updated.id);
    if (idx == -1) return;
    items = [...items]..[idx] = updated;
    notifyListeners();
    await _repo.saveMenuItem(updated);
  }


  MenuItem? byId(String id) {
    try {
      return items.firstWhere((x) => x.id == id);
    } catch (_) {
      return null;
    }
  }
}