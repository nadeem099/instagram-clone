import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/providers/database.dart';
import 'package:instagram_clone/screens/homepage.dart';
import 'package:instagram_clone/screens/profile.dart';
import 'package:instagram_clone/screens/search.dart';
import 'package:instagram_clone/screens/searchedProfile.dart';
import 'package:instagram_clone/utilities/config.dart';
import 'package:instagram_clone/utilities/imageCapture.dart';
import 'package:instagram_clone/utilities/themes/themes.dart';
import 'package:instagram_clone/widgets/appbar.dart';
import 'package:instagram_clone/widgets/bottomnav.dart';
import 'package:instagram_clone/widgets/createPost.dart';

class AppContainer extends StatefulWidget {
  int navIndex = 0;
  int? searchedListindex;
  bool isSearchProfile = false;
  QuerySnapshot? searchSnapshot;
  AppContainer(this.navIndex, this.isSearchProfile, [this.searchSnapshot, this.searchedListindex]);

  @override
  AppContainerState createState() => AppContainerState();
}

class AppContainerState extends State<AppContainer> {
  List<Widget>? tabs;
  bool isSearching = false;
  bool onChangeOccured = false;
  TextEditingController searchEditingController = new TextEditingController();
  DatabaseFunctions databaseFunctions = new DatabaseFunctions();
  QuerySnapshot? searchSnapshot;

  createtabs(context){
  tabs = [
      Container(child: Feeds()),
      Container(child: Search(isSearching: isSearching, onChangeOccured: onChangeOccured, searchSnapshot: searchSnapshot,)),
      Container(child: ImageCapture()),
      Container(child: Text('Activity')),
      Container(child: widget.isSearchProfile ? SearchedProfile(searchSnapshot: widget.searchSnapshot, searchedIndexList: widget.searchedListindex,) : UserProfile() ),
    ];
  }

  searchUser(val) async{
    await databaseFunctions.getUserByusernameSearch(val).then((data){
      setState(() {
        searchSnapshot = data;
        onChangeOccured = true;
      });
    });
  }

//search bar writing here cause i wanted to use setState
PreferredSizeWidget searchAppBar(context){

  return AppBar(
    backgroundColor: currentTheme.currentTheme == ThemeMode.dark ? Color(0xff1C1C1D) : Color(0xffF3F4F8),
    toolbarHeight: 70,
    elevation: 0,
    actions: [
      isSearching ? 
      IconButton(
        onPressed: (){
          setState(() {
            isSearching = false;
            FocusScope.of(context).unfocus();
            searchEditingController.text = '';
          });
        }, 
        icon: Icon(Icons.cancel_outlined)
      ) :
      Container(),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: currentTheme.currentTheme == ThemeMode.dark ?
                   Colors.grey.shade800 : 
                   Colors.grey.shade300,   
            borderRadius: BorderRadius.circular(10)
          ),
          width: isSearching ? MediaQuery.of(context).size.width*0.8 : MediaQuery.of(context).size.width*0.9,
          child: TextField(
              onTap: (){
                setState(() {
                  isSearching = true;
                });
              },
              onChanged: (val){
                searchUser(val);
              },
              controller: searchEditingController,
              cursorColor: currentTheme.currentTheme == ThemeMode.dark ? Colors.white38 : Colors.black38,
              decoration: InputDecoration(
                icon: !isSearching ? Icon(Icons.search, color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white38 : Colors.black38,) : null,
                hintText: 'Search',
                hintStyle: TextStyle(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white38 : Colors.black38),
                border: InputBorder.none
                )
              ),
          ),
      ),
      Expanded(child: Container())
    ],
  );
}


  PreferredSizeWidget getAppBar(context){
    if(widget.navIndex != 1){
      setState(() {
        isSearching = false;
        searchEditingController.text = '';
      });
    }
    if(widget.navIndex == 0){
      return appBarMain(context);
    }else if(widget.navIndex == 1){
      return searchAppBar(context);
    }else if(widget.navIndex == 2){
      return postAppBar();
    }else if(widget.navIndex == 3){
      return activityAppBar();
    }else{
      if(widget.isSearchProfile){
        print(widget.searchSnapshot);
        print('searchedProfile appbar will load');
        return profileAppBar(username: widget.searchSnapshot!.docs[widget.searchedListindex as int]['userName']);
      }else{
        print('userProfile appbar will load');
        return profileAppBar();
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    createtabs(context);
    return Scaffold(
      appBar: getAppBar(context),
      body: tabs![widget.navIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: currentTheme.currentTheme == ThemeMode.dark ? Color(0xff1C1C1D) : Color(0xffF3F4F8),
        selectedIconTheme: currentTheme.currentTheme == ThemeMode.dark ? IconThemeData(color: Colors.white) : IconThemeData(color: Colors.black),
        unselectedIconTheme: currentTheme.currentTheme == ThemeMode.dark ? IconThemeData(color: Colors.white60) : IconThemeData(color: Colors.black54),
        iconSize: 30,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: widget.navIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Post'),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.heart), label: 'Activity'),
          BottomNavigationBarItem(icon: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/userProfilePicPlaceHolder.png'),
              )
            ),
          ), label: 'Profile')
          // Icon(Icons.person), label: 'Profile')
      ],
        onTap: (index){
          setState((){
            widget.navIndex = index;
          });
        },
      )
  );
  }
}