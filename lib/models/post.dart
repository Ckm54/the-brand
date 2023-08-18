class Post {
  final String id;
  final String title;
  final String slug;
  final String keywords;
  final String categoryId;
  final String? imageDefault;
  final String? imageSmall;
  final String createdAt;
  final String categoryName;
  final String categorySlug;

  const Post(
      {required this.id,
      required this.categoryId,
      required this.title,
      required this.slug,
      required this.keywords,
      required this.categoryName,
      required this.categorySlug,
      required this.createdAt,
      this.imageDefault,
      this.imageSmall});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      title: json["title"],
      slug: json["slug"],
      keywords: json["keywords"],
      categoryId: json["category_id"],
      imageDefault: json["image_default"],
      imageSmall: json["image_small"],
      createdAt: json["created_at"],
      categoryName: json["category_name"],
      categorySlug: json["category_slug"],
    );
  }
}
