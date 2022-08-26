import 'package:flutter/material.dart';
import 'package:flutterd/screens/create_post_screen.dart';
import 'package:flutterd/widgets/single_Post.dart';
import 'package:provider/provider.dart';
import '../state/post_state.dart';

class CategoryScreens extends StatefulWidget {
  static const routeName = '/category-screens';
  @override
  _CategoryScreensState createState() => _CategoryScreensState();
}

class _CategoryScreensState extends State<CategoryScreens> {
  // send to the create post page
  void _createPostScreen() {
    Navigator.of(context).pushReplacementNamed(CreatePostScreens.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final posts = Provider.of<PostState>(context).categoryposts(id);

    return posts.length == 0
        ? Scaffold(
            appBar: AppBar(
              title: Text("No post for This Category"),
            ),
            body: Center(
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _createPostScreen();
                    },
                    child: Text("Create a post"),
                  ),
                  Text("There is no post in this community"),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("All Post for ${posts[0].category.title} "),
              centerTitle: true,
            ),
            body: Center(
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _createPostScreen();
                    },
                    child: Text("Create a post"),
                  ),
                  ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (ctx, i) => SinglePost(posts[i]),
                  ),
                ],
              ),
            ),
          );
  }
}
