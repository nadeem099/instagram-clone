import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/appContainer.dart';
import 'package:instagram_clone/screens/searchedProfile.dart';
import 'package:instagram_clone/utilities/config.dart';

class Search extends StatefulWidget {
  bool isSearching;
  bool onChangeOccured;
  QuerySnapshot? searchSnapshot;
  Search({required this.isSearching, required this.onChangeOccured, required this.searchSnapshot});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {
    print(widget.searchSnapshot);
    return widget.isSearching ?
    Column(
      children: [
        Container(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white54 : Colors.black54, height: 0.1,),
        widget.onChangeOccured ?
        Expanded(
          child: ListView.builder(
            itemCount: widget.searchSnapshot!.docs.length,
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return AppContainer(4, true, widget.searchSnapshot, index);
                  }));
                },
                child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/userProfilePicPlaceHolder.png')
                              )
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.searchSnapshot!.docs[index]['userName'],style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(widget.searchSnapshot!.docs[index]['name'])
                            ],
                          )
                        ],
                      ),
                    )
              );
            }
          ),
        ):
        Container()
      ],
    ):
    Container();
  }
}