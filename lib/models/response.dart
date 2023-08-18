import 'package:the_brand_demo/models/post.dart';

class Response {
  final String title;
  final String description;
  final String keywords;
  final String activeCategory;
  final int pageOffset;
  final int perPage;
  final int currentPage;
  final List<Post> posts;

  const Response({
    required this.title,
    required this.description,
    required this.keywords,
    required this.activeCategory,
    required this.pageOffset,
    required this.perPage,
    required this.currentPage,
    required this.posts,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    // parse posts array
    List<dynamic> jsonPosts = json['posts'] ?? [];
    List<Post> posts = jsonPosts.map((post) => Post.fromJson(post)).toList();

    return Response(
      title: json["title"],
      description: json["description"],
      keywords: json["keywords"],
      activeCategory: json["active_category"],
      pageOffset: json["page_offset"],
      perPage: json["per_page"],
      currentPage: json["current_page"],
      posts: posts,
    );
  }
}
