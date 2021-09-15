import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/screens/appContainer.dart';
import 'package:instagram_clone/screens/homepage.dart';
import 'package:instagram_clone/screens/profile.dart';
import 'package:instagram_clone/screens/signin.dart';
import 'package:instagram_clone/screens/signup.dart';
import 'package:instagram_clone/utilities/config.dart';
import 'package:instagram_clone/utilities/constant.dart';
import 'package:instagram_clone/utilities/sharedPrefrenceFunctions.dart';
import 'package:instagram_clone/utilities/themes/themes.dart';
import 'package:instagram_clone/utilities/toggleSignUpAndSignIn.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RootApp());
}

class RootApp extends StatefulWidget {
  const RootApp({ Key? key }) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  bool isLoggedIn = false; 
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async{
    //getting user's logged in status
    await SharedPreferenceFunctions.getuserLoggInSharedPreference().then((value){
      setState(() {
        isLoggedIn = value;
      });
    });
    if(isLoggedIn){
      await SharedPreferenceFunctions.getuserUserNameSharedPreference().then((value){
        setState(() {
          Constant.userName = value;
        });
      });
    if(isLoggedIn){
      await SharedPreferenceFunctions.getuserUserIdSharedPreference().then((value){
        setState(() {
          Constant.userID = value;
        });
      });
    }
    }
    print('User login status: $isLoggedIn');
    print(Constant.userName);
    print(Constant.userID);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram-Clone',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? 
      AppContainer(0, false) :
      ToggleSignupAndSignIn() 
    );
  }
}