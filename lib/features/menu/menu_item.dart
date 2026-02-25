class MenuItem {
  MenuItem({
    required this.id,
    required this.title,
    required this.strain,
    required this.smell,
    required this.description,
    required this.category,
    required this.active,
    required this.sort,
    required this.coaUrl,
  });

  final String id;
  final String title;
  final String strain;
  final String smell;
  final String description;
  final String category;
  final bool active;
  final int sort;
  final String coaUrl;

  factory MenuItem.fromFirestore(String id, Map<String, dynamic> data) {
    return MenuItem(
      id: id,
      title: (data['title'] ?? '').toString(),
      strain: (data['strain'] ?? '').toString(),
      smell: (data['smell'] ?? '').toString(),
      description: (data['description'] ?? '').toString(),
      category: (data['category'] ?? '').toString(),
      active: (data['active'] ?? false) == true,
      sort: (data['sort'] ?? 999999) is int ? data['sort'] as int : 999999,
      coaUrl: (data['coaUrl'] ?? '').toString(),
    );
  }
}