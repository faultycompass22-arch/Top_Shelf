class MenuItem {
  final String id;
  final String title;
  final String description;
  final int priceCents;
  final String imageUrl;
  final String category;
  final String? coaUrl;
  final int sort;

  const MenuItem({
    required this.id,
    required this.title,
    required this.description,
    required this.priceCents,
    required this.imageUrl,
    required this.category,
    this.coaUrl,
    this.sort = 0,
  });

  factory MenuItem.fromFirestore(String id, Map<String, dynamic> data) {
    return MenuItem(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      priceCents: data['priceCents'] ?? 0,
      imageUrl: data['imageUrl'] ?? '',
      category: data['category'] ?? '',
      coaUrl: data['coaUrl'],
      sort: data['sort'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'priceCents': priceCents,
      'imageUrl': imageUrl,
      'category': category,
      'coaUrl': coaUrl,
      'sort': sort,
    };
  }
}