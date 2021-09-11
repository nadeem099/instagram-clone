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
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram-Clone',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
      debugShowCheckedModeBanner: false,
      home: ToggleSignupAndSignIn(),
    );
  }
}