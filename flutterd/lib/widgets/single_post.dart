import 'package:flutter/material.dart';
import 'package:flutterd/model/post_model.dart';
import 'package:flutterd/widgets/single_comments.dart';
import 'package:provider/provider.dart';
import '../screens/category_screens.dart';
import '../screens/post_details_screens.dart';
import '../state/post_state.dart';

class SinglePost extends StatefulWidget {
  final Post post;
  SinglePost(this.post);

  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  bool _showComments = false;
  String commenttitle = '';
  final commentControler = TextEditingController();

  void _addComment() {
    if (commenttitle.length <= 0) {
      return;
    }
    Provider.of<PostState>(context, listen: false)
        .addcomment(widget.post.id, commenttitle);
    commentControler.text = '';
    commenttitle = '';
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                       PostDetailsScreens.routeName,
                      arguments: widget.post.id,
                    );
                  },
                  child: Text(
                    widget.post.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      CategoryScreens.routeName,
                      arguments: widget.post.category.id,
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(widget.post.category.title,
                      style: TextStyle(
                            color: Colors.blueGrey,
                            backgroundColor: Colors.white,                    
                          ),
                          ),
                    ),
                  ),
                ),
              ],
            ),
            if (widget.post.code.length != 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Type:",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0),
                    child: Card(
                      color: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          widget.post.code,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            widget.post.content.length > 200
                ? Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.post.content.substring(0, 200)}...",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              PostDetailsScreens.routeName,
                              arguments: widget.post.id,
                            );
                          },
                          child: Text(
                            "Read More",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    child: Text(
                      "${widget.post.content}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),


            Divider(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton.icon(
                    onPressed: () {
                       Provider.of<PostState>(context, listen: false)
                          .addlike(widget.post.id);
                    },
                    icon: Icon(
                      widget.post.like ?
                      Icons.favorite :
                      Icons.favorite_border,
                      color: Theme.of(context).accentColor,
                    ),
                    label: Text(
                      "Like(${widget.post.totallike})",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  FlatButton.icon(
                    onPressed: () {
                      setState(() {
                        _showComments = !_showComments;
                      });
                    },
                    icon: Icon(
                      Icons.comment,
                      color: Theme.of(context).accentColor,
                    ),
                    label: Text(
                      "Comment(${widget.post.comment.length})",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),


            if (_showComments)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: TextField(
                      controller: commentControler,
                      onChanged: (v) {
                        setState(() {
                          commenttitle = v;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Comment...",
                        suffix: IconButton(
                          onPressed: commenttitle.length <= 0
                              ? null
                              : () {
                                  _addComment();
                                },
                          icon: Icon(Icons.send),
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.post.comment
                            .map(
                              (e) => SingleComment(e),
                            )
                            .toList(),
                      ),
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}