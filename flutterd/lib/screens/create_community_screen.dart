import 'package:flutter/material.dart';
import 'package:flutterd/screens/login_screens.dart';
import 'package:flutterd/screens/home_screens.dart';
import 'package:flutterd/state/post_state.dart';
import 'package:provider/provider.dart';

class CreateCommunityScreens extends StatefulWidget {
  static const routeName = '/create-community';
  @override
  _CreateCommunityScreensState createState() => _CreateCommunityScreensState();
}

class _CreateCommunityScreensState extends State<CreateCommunityScreens> {
  String _communityName;
  final _form = GlobalKey<FormState>();

  void _registerNewCommunity() async {
    var isvalid = _form.currentState.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState.save();
    bool isRegister = await Provider.of<PostState>(context, listen: false)
        .registerNewCommunity(_communityName);
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
        title: Text("Create a community"),
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
                  "Create a community",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Community Name"),
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
                Row(
                  children: [
                    RaisedButton(
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        _registerNewCommunity();
                      },
                      child: Text("Create"),
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
