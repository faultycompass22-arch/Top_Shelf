class MenuItem {
  final String id;
  final String title;
  final String description;
  final int priceCents;
  final String imageUrl;
  final String category;

  const MenuItem({
    required this.id,
    required this.title,
    required this.description,
    required this.priceCents,
    required this.imageUrl,
    required this.category,
  });
}
