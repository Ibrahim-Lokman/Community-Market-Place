import 'package:flutter/material.dart';
import 'package:flutterd/screens/login_screens.dart';
import 'package:flutterd/screens/home_screens.dart';
import 'package:flutterd/state/post_state.dart';
import 'package:provider/provider.dart';

class CreatePostScreens extends StatefulWidget {
  static const routeName = '/create-post';
  @override
  _CreatePostScreensState createState() => _CreatePostScreensState();
}

class _CreatePostScreensState extends State<CreatePostScreens> {
  String _communityName;
  String _title;
  String _type;
  String _content;
  final _form = GlobalKey<FormState>();

  void _createNewPost() async {
    var isvalid = _form.currentState.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState.save();
    bool isRegister = await Provider.of<PostState>(context, listen: false)
        .createNewPost(_communityName, _title, _type, _content);
    if (isRegister == false) {
      Navigator.of(context).pushReplacementNamed(HomeScreens.routeName);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Somthing is Wrong!Try Again"),
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a Post"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _form,
            child: Column(
              children: [
                Text(
                  "Create a Post",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: "Community name"),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Enter a valid Community Name';
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _communityName = v;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Post title"),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Provide realistic post title';
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _title = v;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Post Type"),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Provide valid post type';
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _type = v;
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: "Post Description"),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Provide valid post description';
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _content = v;
                  },
                ),
                Row(
                  children: [
                    RaisedButton(
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        _createNewPost();
                      },
                      child: const Text("Post"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
