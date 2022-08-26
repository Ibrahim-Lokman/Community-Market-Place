import 'package:flutter/material.dart';
import 'package:flutterd/screens/category_screens.dart';
import 'package:flutterd/screens/home_screens.dart';
import 'package:flutterd/screens/login_screens.dart';
import 'package:flutterd/screens/post_details_screens.dart';
import 'package:flutterd/screens/register_screens.dart';
import 'package:flutterd/state/post_state.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'screens/create_community_screen.dart';
import 'screens/create_post_screen.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalStorage storage = LocalStorage("usertoken");
    return ChangeNotifierProvider(
      create: (ctx) => PostState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.blueGrey,
        ),
        home: FutureBuilder(
          future: storage.ready,
          builder: (context, snapshop) {
            if (snapshop.data == null) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (storage.getItem('token') == null) {
              return LoginScreens();
            }
            return HomeScreens();
          },
        ),
        routes: {
          HomeScreens.routeName: (ctx) => HomeScreens(),
          PostDetailsScreens.routeName: (ctx) => PostDetailsScreens(),
          CategoryScreens.routeName: (ctx) => CategoryScreens(),
          LoginScreens.routeName: (ctx) => LoginScreens(),
          RegisterScreens.routeName: (ctx) => RegisterScreens(),
          CreateCommunityScreens.routeName: (ctx) => CreateCommunityScreens(),
          CreatePostScreens.routeName: (ctx) => CreatePostScreens(),
        },
      ),
    );
  }
}
