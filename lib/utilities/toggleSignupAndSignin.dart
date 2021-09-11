import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/signin.dart';
import 'package:instagram_clone/screens/signup.dart';

class ToggleSignupAndSignIn extends StatefulWidget {
  const ToggleSignupAndSignIn({ Key? key }) : super(key: key);

  @override
  _ToggleSignupAndSignInState createState() => _ToggleSignupAndSignInState();
}

class _ToggleSignupAndSignInState extends State<ToggleSignupAndSignIn> {
  bool _isSignin = true;

  void toggleView(){
    setState(() {
      _isSignin = !_isSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_isSignin){
      return Signin(toggle: toggleView);
    }else{
      return Signup(toggle: toggleView);
    }
  }
}