import 'package:flutter/material.dart';
import 'package:the_brand_demo/models/post.dart';

class Posts extends StatelessWidget {
  const Posts({super.key, required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: posts.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final post = posts[index];
        final imageUrl = posts[index].imageSmall;
        final datePosted = DateTime.parse(posts[index].createdAt);

        // If imageUrl is null, display a local image; otherwise, display the API image
        final imageWidget = imageUrl == null
            ? Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/default.jpg'),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ) // Replace with your local image path
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://www.thebrand.ai/i/$imageUrl'),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              );

        return Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: imageWidget,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.title,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Category",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(post.categoryName),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Posted:"),
                              Text(
                                  "${datePosted.day}-${datePosted.month}-${datePosted.year}")
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}
