import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/providers/auth.dart';
import 'package:instagram_clone/utilities/config.dart';
import 'package:instagram_clone/utilities/constant.dart';
import 'package:instagram_clone/utilities/sharedPrefrenceFunctions.dart';
import 'package:instagram_clone/utilities/toggleSignupAndSignin.dart';

PreferredSizeWidget appBarMain(context){
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
      onPressed: ()async{
        await AuthFunctions().signoutUser();
        Constant.userID = '';
        Constant.userName = '';
        SharedPreferenceFunctions.saveUserLoggedInSharedPreference(false);
        SharedPreferenceFunctions.saveUserEmailIdSharedPreference('');
        SharedPreferenceFunctions.saveUserIdSharedPreference('');
        SharedPreferenceFunctions.saveUserNameSharedPreference('');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return ToggleSignupAndSignIn();
        }));
      },
      icon: const Icon(Icons.logout)
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

PreferredSizeWidget profileAppBar({username = ''}){
  print(username);
  return AppBar(
    backgroundColor: currentTheme.currentTheme == ThemeMode.dark ? Color(0xff1C1C1D) : Color(0xffF3F4F8),
    elevation: 0,
    title: Container(
      padding: EdgeInsets.only(left: 5),
      child: Center(
        child: Text(
          username != '' ? username : Constant.userName,
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
