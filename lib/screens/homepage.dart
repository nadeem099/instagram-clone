import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/providers/database.dart';
import 'package:instagram_clone/screens/instaStories.dart';
import 'package:instagram_clone/utilities/config.dart';
import 'package:instagram_clone/widgets/feedTile.dart';

class Feeds extends StatefulWidget {
  const Feeds({ Key? key }) : super(key: key);

  @override
  _FeedsState createState() => _FeedsState();
}


class _FeedsState extends State<Feeds> {
  Stream? postStream;
  DatabaseFunctions databaseFunctions = new DatabaseFunctions();

  @override
  void initState() {
    fetchPosts();
    super.initState();
  }

  fetchPosts() async{
    await databaseFunctions.getPostDetails().then((posts){
      setState(() {
        postStream = posts;
        print(postStream);
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: postStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return Column(
            children: [
              SizedBox(child: InstaStories(), height: MediaQuery.of(context).size.height * 0.17,),
              Center(child: Container(child: Text('No posts yet', style: TextStyle(fontSize: 30),),)),
            ],
          );
        }else{
          // print(snapshot);
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index){
              // print(snapshot);
              return 
              index == 0
              ? Column(
                children: [
                  SizedBox(
                    child: InstaStories(),
                    height: MediaQuery.of(context).size.height * 0.17,
                  ),
                  FeedTile(
                    postId: snapshot.data.docs[index]['postId'],
                    userName: snapshot.data.docs[index]["username"],
                    postFileURL: snapshot.data.docs[index]["fileurl"],
                    description: snapshot.data.docs[index]["description"],
                    location: snapshot.data.docs[index]["location"],
                    likeCount: snapshot.data.docs[index]["likes"]["likeCount"]
                  )
                ],
              ) : 
              FeedTile(
                postId: snapshot.data.docs[index]['postId'],
                userName: snapshot.data.docs[index]["username"],
                postFileURL: snapshot.data.docs[index]["fileurl"],
                description: snapshot.data.docs[index]["description"],
                location: snapshot.data.docs[index]["location"],
                likeCount: snapshot.data.docs[index]["likes"]["likeCount"],
              );
            }
          );
        }
      }
    );  
  }
}


