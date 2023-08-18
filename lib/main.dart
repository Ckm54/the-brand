import 'package:flutter/material.dart';
import 'package:the_brand_demo/data/app_images.dart';
import 'package:the_brand_demo/data/thebrandapi.dart';
import 'package:the_brand_demo/models/response.dart';
import 'package:the_brand_demo/widgets/posts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Response> apiResponseData;
  late Image coverImage;
  late Image defaultImage;

  @override
  void initState() {
    super.initState();
    coverImage = Image.asset(AppImages.coverImage);
    defaultImage = Image.asset(AppImages.defaultImage);
    apiResponseData = TheBrandApi().fetchResponseData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(coverImage.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
      future: apiResponseData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // show a spinner while waiting
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          final responseData = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(responseData.title),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage(
                                'assets/images/cover.jpg',
                              ),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.darken),
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                color: Colors.white60,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 6.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: FittedBox(
                                    child: Text(
                                      "🔥 New posts update",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            alignment: Alignment.center,
                            height: 250,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 16.0,
                              ),
                              child: Text(
                                responseData.description,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              'Recent Posts (${responseData.posts.length})',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: Colors.blue[400],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          // posts from api
                          Posts(posts: responseData.posts),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return const Text("No data available");
        }
      },
    );
  }
}
