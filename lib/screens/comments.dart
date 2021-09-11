
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/database.dart';
import 'package:instagram_clone/utilities/config.dart';
import 'package:instagram_clone/utilities/constant.dart';
import 'package:instagram_clone/widgets/appbar.dart';

class Comments extends StatefulWidget {
  String postId;
  String postDescription;
  Comments({required this.postId, required this.postDescription});

  @override
  _CommentsState createState() => _CommentsState();
}


class _CommentsState extends State<Comments> {
  Stream? commentStream;
  DatabaseFunctions databaseFunctions = new DatabaseFunctions();
  TextEditingController commentTextEditingController = new TextEditingController();

  @override
  void initState() {
    databaseFunctions.getComments(widget.postId).then((val){
      setState(() {
        commentStream = val;
      });
    });
    super.initState();
  }

  postComment() async{
    await databaseFunctions.uploadComment(commentTextEditingController.text, widget.postId);
    databaseFunctions.getComments(widget.postId);
    commentTextEditingController.text = '';
  }

  Widget commentList(){
    return StreamBuilder(
        stream: commentStream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return Center(child: Container(child: Text('No Comments Yet' ,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),);
          }else{
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index){
                if(index == 0){
                  return Column( 
                  children: [
                    CommentTile(username: Constant.userName, commentText: widget.postDescription), 
                    Container(height: 1, color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white12 : Colors.black12),
                    CommentTile(username: snapshot.data.docs[index]['userName'] ,
                            commentText: snapshot.data.docs[index]['commentText']),

                  ],);
                }else if(index == snapshot.data.docs.length-1){
                  return Container();
                }
                else {
                  return CommentTile(username: snapshot.data.docs[index]['userName'] ,
                            commentText: snapshot.data.docs[index]['commentText']);
                }
              },
            );
          }
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: currentTheme.currentTheme == ThemeMode.dark ? Color(0xff1C1C1D) : Color(0xffF3F4F8),
        title: Text('Comments', style: TextStyle(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white : Colors.black),),
      ),
      body: Stack(
        children: [ 
          commentList(),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 17, top: 10, bottom: 10),
              color: currentTheme.currentTheme == ThemeMode.dark ? Color(0xff1C1C1D) : Color(0xffF3F4F8),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage('assets/images/userProfilePicPlaceHolder.png')
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(color: themeTernaryOperator)
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: TextField(
                      controller: commentTextEditingController,
                      decoration: InputDecoration(
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: (){
                      if(commentTextEditingController.text != ''){
                        postComment();
                      }
                    },
                    child: Container(
                      child: Text('Post', style: TextStyle(color: Colors.blue.shade500),),
                    ),
                  )
                ],
              ),
            )
          ),
        ],
      )
    );
  }
}

class CommentTile extends StatelessWidget {
  String username;
  String commentText;
  CommentTile({required this.username, required this.commentText});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/myprofile.png')
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(color: themeTernaryOperator)
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white: Colors.black,
                          fontSize: 15
                        ),
                        children: <TextSpan>[
                          TextSpan(text: username+' ', style: TextStyle(fontWeight: FontWeight.bold,)),
                          TextSpan(text: commentText)
                        ]
                      )
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4,), 
                child: Text('31 m', style: TextStyle(fontSize: 10, color: Colors.grey.shade700),)
              ),
            ],
          ),
    );
  }
}




