import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/utilities/config.dart';
import 'package:instagram_clone/utilities/constant.dart';

PreferredSizeWidget appBarMain(){
  return AppBar(
    backgroundColor: currentTheme.currentTheme == ThemeMode.dark ? Color(0xff1C1C1D) : Color(0xffF3F4F8),
    elevation: 0,
    title: Row(
    children: [
      IconButton(
        onPressed: (){}, 
        icon: const Icon(Icons.camera_alt_outlined),
      ),
      Image.asset(
        'assets/images/logo.png', 
        height: 40,
        color: currentTheme.currentTheme == ThemeMode.dark 
               ? Colors.white
               : Colors.black,
      ),
    ],
  ),
  actions: [
    IconButton(
      onPressed: () => currentTheme.toggleTheme(), 
      icon: const Icon(Icons.brightness_4)
    ),
    IconButton(
      onPressed: (){},
      icon: const Icon(FontAwesomeIcons.facebookMessenger)
    ),
    ],
  );
}

PreferredSizeWidget ThemeChangerAppBar(){
  return AppBar(
        elevation: 0,
        backgroundColor: currentTheme.currentTheme == ThemeMode.dark ? Color(0xff1C1C1D) : Color(0xffF3F4F8),
        actions: [
          GestureDetector(
            onTap: (){
              currentTheme.toggleTheme();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.brightness_4)
            ),
          )
        ]
        );
}


PreferredSizeWidget searchAppBar(){
  return AppBar(
    backgroundColor: currentTheme.currentTheme == ThemeMode.dark ? Color(0xff1C1C1D) : Color(0xffF3F4F8),
    elevation: 0,
    title: Text(
      'Search',
      style: TextStyle(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white : Colors.black),
    ),
  );
}

PreferredSizeWidget postAppBar(){
  return AppBar(
    backgroundColor: currentTheme.currentTheme == ThemeMode.dark ? Color(0xff1C1C1D) : Color(0xffF3F4F8),
    elevation: 0,
    title: Text(
      'Post',
      style: TextStyle(color:  currentTheme.currentTheme == ThemeMode.dark ? Colors.white : Colors.black),
    ),
  );
}

PreferredSizeWidget activityAppBar(){
  return AppBar(
    backgroundColor: currentTheme.currentTheme == ThemeMode.dark ? Color(0xff1C1C1D) : Color(0xffF3F4F8),
    elevation: 0,
    title: Text(
      'Activity',
      style: TextStyle(color:  currentTheme.currentTheme == ThemeMode.dark ? Colors.white : Colors.black),
    ),
  );
}

PreferredSizeWidget profileAppBar(){
  return AppBar(
    backgroundColor: currentTheme.currentTheme == ThemeMode.dark ? Color(0xff1C1C1D) : Color(0xffF3F4F8),
    elevation: 0,
    title: Container(
      padding: EdgeInsets.only(left: 5),
      child: Center(
        child: Text(
          Constant.userName,
          style: TextStyle(
            color:  currentTheme.currentTheme == ThemeMode.dark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22
          ),
        ),
      ),
    ),
  );
}
