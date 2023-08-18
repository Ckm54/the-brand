import 'package:flutter/material.dart';
import 'package:the_brand_demo/models/post.dart';

class Posts extends StatelessWidget {
  const Posts({super.key, required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Container(
          color: Colors.grey.shade400,
          width: double.maxFinite,
          child: Column(
            children: [
              // Expanded(flex: 3, child: Text(post.title)),
              Text(post.title)
            ],
          ),
        );
      },
    );
  }
}
