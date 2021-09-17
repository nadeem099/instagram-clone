import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/providers/database.dart';
import 'package:instagram_clone/screens/comments.dart';
import 'package:instagram_clone/utilities/config.dart';
import 'package:instagram_clone/utilities/constant.dart';
import 'package:instagram_clone/utilities/sharedPrefrenceFunctions.dart';
import 'package:instagram_clone/utilities/themes/themes.dart';


class FeedTile extends StatefulWidget {
  String  postId;
  String userName;
  String postFileURL;
  String description;
  String location;
  int likeCount;
  FeedTile({
    required this.postId,
    required this.userName, 
    required this.postFileURL,
    required this.description,
    required this.location,
    required this.likeCount
  });

  @override
  _FeedTileState createState() => _FeedTileState();
}

class _FeedTileState extends State<FeedTile> {
    DatabaseFunctions databaseFunctions = new DatabaseFunctions();
    bool isLiked = false;
    //TODO: like color gets refreshed back to black when page is switched
    updateLikes() async{
      String sharePreferenceUserLikedId = Constant.userID + widget.postId;
      isLiked = await SharedPreferenceFunctions.getUserLikedSharedPreference(sharePreferenceUserLikedId);
      if(!isLiked){
        await databaseFunctions.increaseLikes(widget.postId, widget.likeCount+1);
        setState(() {
          isLiked = true;
        });
        await SharedPreferenceFunctions.saveUserLikedSharedPreference(isLiked, sharePreferenceUserLikedId);
      }else{
        await databaseFunctions.decreaseLikes(widget.postId, widget.likeCount-1);
        setState(() {
          isLiked = false;
        });
        await SharedPreferenceFunctions.saveUserLikedSharedPreference(isLiked, sharePreferenceUserLikedId);
      }
    }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          Container(
            child: Container(
              child: Column(
                children: [
                  Container(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white12 : Colors.black12, height: 1,),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 15, bottom: 10, right:0),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/userProfilePicPlaceHolder.png')
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(color: themeTernaryOperator)
                          ),
                        ),
                        SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(widget.userName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                            ),
                            widget.location != "" ? Text(widget.location) : Container()
                          ],
                        ),
                        Spacer(),
                        IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
                      ],
                    ),
                  ),
                  Container(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white12 : Colors.black12, height: 1,),
                ]
              )
            )
          ),
          Container(
            width: 500,
            height: 500,
            margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.postFileURL)
                ),
                shape: BoxShape.rectangle
              ),
            ),
          // Container(
          //   child: Image.network(postFileURL, height: 550, width: MediaQuery.of(context).size.width,),
          // ),
          Container(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white12 : Colors.black12, height: 1,),
          Container(
            child: Row(
              children: <Widget>[
               IconButton(onPressed: () async{
                 await updateLikes();
                 print(isLiked);
               }, icon: isLiked ? 
                   Icon(FontAwesomeIcons.heart, color: Colors.red):
                   Icon(FontAwesomeIcons.heart, color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white : Colors.black)
                  ),
               IconButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context){
                   return Comments(postId: widget.postId, postDescription: widget.description);
                 }));
               }, icon: Icon(FontAwesomeIcons.comment)),
               Container(
                 padding: EdgeInsets.symmetric(horizontal: 10),
                 child: RotationTransition(
                   turns: AlwaysStoppedAnimation(-50/360), 
                   child: Icon(Icons.send_outlined),
                   )
                  )
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 12,),
            child: Text('${widget.likeCount} likes', style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   alignment: Alignment.centerLeft,
              //   padding: EdgeInsets.only(left: 12,top: 5),
              //   child: Text('nadeem', style: TextStyle(fontWeight: FontWeight.bold),),
              // ),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 12, top: 5, bottom: 8),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white: Colors.black,
                      fontSize: 15
                    ),
                    children: <TextSpan>[
                      TextSpan(text: widget.userName+' ', style: TextStyle(fontWeight: FontWeight.bold,)),
                      TextSpan(text: widget.description)
                    ]
                  ),
                ),
              ),
            ],
          ),
          // GestureDetector(
          //   onTap: (){},
          //   child: Container(
          //     alignment: Alignment.centerLeft,
          //     padding: EdgeInsets.only(left: 12, bottom: 12),
          //     child: GestureDetector(
          //       onTap: (){},
          //       child: Text(
          //         'View all 494 comments', 
          //         style: TextStyle(color: Colors.grey.shade600),
          //       )
          //     ),
          //   ),
          // ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 12, bottom: 12),
            child: Text('1 day ago', style: TextStyle(color: Colors.grey.shade600, fontSize: 10)),
          )
        ],
      ),
    );
  }
}