import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/providers/database.dart';
import 'package:instagram_clone/screens/editProfile.dart';
import 'package:instagram_clone/utilities/config.dart';
import 'package:instagram_clone/widgets/feedTile.dart';

class SearchedProfile extends StatefulWidget {
  int? searchedIndexList;
  QuerySnapshot? searchSnapshot;
  SearchedProfile({required this.searchSnapshot, this.searchedIndexList});

  @override
  SearchedProfileState createState() => SearchedProfileState();
}

class SearchedProfileState extends State<SearchedProfile> {
  TextStyle style = TextStyle(fontWeight: FontWeight.bold);
  Stream? profilepostStream;
  // var profileSnapshot;
  bool arePhotosPresent = false;
  // bool isProfileDataLoaded = false;
  bool isGridView = true;
  DatabaseFunctions databaseFunctions = new DatabaseFunctions();


  @override
  void initState(){
    fetchSearchedUserPost();
    super.initState();
  }

  fetchSearchedUserPost() async{
    await databaseFunctions.getPostsOfSearchedUser(widget.searchSnapshot!.docs[widget.searchedIndexList as int]['userid'])
    .then((val){
      setState(() {
        profilepostStream = val;
      });
    });
    print(profilepostStream);
  }

  Widget profileGrid(){
    return StreamBuilder(
      stream: profilepostStream,
      builder: (context, AsyncSnapshot snapshot){
        print(snapshot.data.docs.length);
        if(snapshot.data == null){
          return CircularProgressIndicator();
        }else{
        if(snapshot.hasData && snapshot.data.docs.length != 0){
          arePhotosPresent = true;
          print(arePhotosPresent);
          return isGridView ?
            Flexible(
              child: GridView.builder(
                itemCount: snapshot.data.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
                itemBuilder: (context, index){
                  return GridTile(snapshot.data.docs[index]['fileurl']);
                }
              ),
            ) : 
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, index){
                  return FeedTile(
                    postId: snapshot.data.docs[index]['postId'], 
                    userName: snapshot.data.docs[index]['username'], 
                    postFileURL: snapshot.data.docs[index]['fileurl'],
                    description: snapshot.data.docs[index]['description'],
                    location: snapshot.data.docs[index]['location'],
                    likeCount: snapshot.data.docs[index]['likes']['likeCount']
                  );
                },
              ),
            );
        }else{
          arePhotosPresent = false;
          return Center(child: Container(child: Text('No photos', style: TextStyle(fontSize: 30))));
        }
        }
      },
    );
  } 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 22, left: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white : Colors.black),
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/userProfilePicPlaceHolder.png')
                    )
                  ),
                ),
                Column(
                  children: [
                    Text('22', style: style),
                    Text('Posts', style: style)
                  ],
                ),
                Column(
                  children: [
                    Text('402', style: style),
                    Text('Followers', style: style)
                  ],
                ),
                Column(
                  children: [
                    Text('613', style: style),
                    Text('Following', style: style)
                  ],
                )
              ],
            ),
          ),
          widget.searchSnapshot!.docs[widget.searchedIndexList as int]['name'] != '' && 
          widget.searchSnapshot!.docs[widget.searchedIndexList as int]['bio']  != ''  ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.searchSnapshot!.docs[widget.searchedIndexList as int]['name'], style: style),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.only(right: 100),
                  alignment: Alignment.centerLeft,
                  child: Text(widget.searchSnapshot!.docs[widget.searchedIndexList as int]['bio'])),
              ],
            ),
          ) :
          Text(''),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return EditProfile();
                }
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 150, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.blue.shade500,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text('Follow', style: TextStyle(color: Colors.white)),
            )
          ),
          SizedBox(height: 5,),
          // arePhotosPresent?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: (){
                  setState(() {
                    isGridView = true;
                  });
                }, 
                icon: Icon(Icons.grid_on_outlined)
              ),
              IconButton(
                onPressed: (){
                  setState(() {
                    isGridView = false;
                  });
                }, 
                icon: Icon(FontAwesomeIcons.list, size: 20,)
              )
            ],
          ),
          // Container(),
          profileGrid()
        ],
      ),
    );
  }
}


class GridTile extends StatelessWidget {
  String fileURL;
  GridTile(this.fileURL);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        margin: EdgeInsets.all(0.5),
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(fileURL)
          )
        ),
      ),
    );
  }
}

