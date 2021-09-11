import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/screens/homepage.dart';
import 'package:instagram_clone/screens/profile.dart';
import 'package:instagram_clone/utilities/config.dart';
import 'package:instagram_clone/utilities/imageCapture.dart';
import 'package:instagram_clone/utilities/themes/themes.dart';
import 'package:instagram_clone/widgets/appbar.dart';
import 'package:instagram_clone/widgets/bottomnav.dart';
import 'package:instagram_clone/widgets/createPost.dart';

class AppContainer extends StatefulWidget {
  int navIndex = 0;
  AppContainer(this.navIndex);

  @override
  AppContainerState createState() => AppContainerState();
}

class AppContainerState extends State<AppContainer> {

  List<Widget>? tabs;

  createtabs(context){
  tabs = [
      Container(child: Feeds()),
      Container(child: Text('Search')),
      Container(child: ImageCapture()),
      Container(child: Text('Activity')),
      Container(child: UserProfile()),
    ];
  }

  PreferredSizeWidget getAppBar(){
    if(widget.navIndex == 0){
      return appBarMain();
    }else if(widget.navIndex == 1){
      return searchAppBar();
    }else if(widget.navIndex == 2){
      return postAppBar();
    }else if(widget.navIndex == 3){
      return activityAppBar();
    }else{
      return profileAppBar();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    createtabs(context);
    return Scaffold(
      appBar: getAppBar(),
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