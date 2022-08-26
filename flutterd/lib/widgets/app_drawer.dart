import 'package:flutter/material.dart';
import 'package:flutterd/screens/login_screens.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutterd/screens/create_post_screen.dart';
import '../screens/create_community_screen.dart';

class AddDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalStorage storage = LocalStorage("usertoken");
    _logoutnow() {
      storage.clear();
      Navigator.of(context).pushReplacementNamed(LoginScreens.routeName);
    }

    // will redirect to the community creation screen
    _createCommunityScreen() {
      Navigator.of(context)
          .pushReplacementNamed(CreateCommunityScreens.routeName);
    }

    void _createPostScreen() {
      Navigator.of(context).pushReplacementNamed(CreatePostScreens.routeName);
    }

    return Drawer(
      child: Column(
        children: [
          Spacer(),
          Text(
            "About",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.indigo,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
                "Best Community market place in the world. Version: 0.0.1"),
          ),
          ListTile(
            onTap: () {
              _createCommunityScreen();
            },
            trailing: Icon(
              Icons.people,
              color: Theme.of(context).accentColor,
            ),
            title: Text('Create Group'),
          ),
          ListTile(
            onTap: () {
              // _creategroupnow();
            },
            trailing: Icon(
              Icons.input,
              color: Theme.of(context).accentColor,
            ),
            title: Text('Join Group'),
          ),
          ListTile(
            onTap: () {
              _createPostScreen();
            },
            trailing: Icon(
              Icons.note_add,
              color: Theme.of(context).accentColor,
            ),
            title: Text('Create Post'),
          ),
          Spacer(),
          Divider(),
          ListTile(
            onTap: () {
              _logoutnow();
            },
            trailing: Icon(
              Icons.logout,
              color: Theme.of(context).accentColor,
            ),
            title: Text("LogOut"),
          ),
        ],
      ),
    );
  }
}
