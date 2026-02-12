import '../models/menu_item.dart';

class MenuRepository {
  Future<List<MenuItem>> fetchMenu() async {
    // TEMP inline data to unblock build (no sample_menu.dart)
    await Future.delayed(const Duration(milliseconds: 300));

    return const [
      MenuItem(
        id: '1',
        title: 'Sample Item',
        category: 'General',
        description: 'Temporary sample item',
        imageUrl: '',
        priceCents: 999,
      ),
    ];
  }

  Future<void> saveMenuItem(MenuItem item) async {
    // Later: Firestore write
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
