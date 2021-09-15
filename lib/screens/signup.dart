import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/utilities/constant.dart';
import 'package:instagram_clone/utilities/sharedPrefrenceFunctions.dart';
import 'package:instagram_clone/utilities/signupValidationFunctions.dart';
import 'package:instagram_clone/utilities/config.dart';
import 'package:instagram_clone/widgets/essentialWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'appContainer.dart';

class Signup extends StatefulWidget {
  final Function toggle;
  // static double inputBoxheight = 50;
  bool? doesUserNameExistStatus;
  Signup({required this.toggle});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController usernameEditingController = new TextEditingController();
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  Map<String, dynamic> userMap= {};
  String userid = uid.v4();
  bool isLoading = false;


signupForNewUser() async{
  print(signup.doesUserNameExistStatus);
  await db.getDocumentByUsername(usernameEditingController.text)
  .then((querySnapshot){
    if(querySnapshot.size == 0){
      signup.doesUserNameExistStatus = false; //username does not exists
    }else{
      signup.doesUserNameExistStatus = true; //username exists
    }
  });
  print("After update");
  print(signup.doesUserNameExistStatus);
  if(formkey.currentState!.validate() && signup.doesUserNameExistStatus == false){
    setState(() {
      isLoading = true;
    });
    userMap = {
      "userid" : userid, 
      "userName" : usernameEditingController.text,
      "name" : '',
      "bio" : '',
      "email" : emailEditingController.text,
      "usernameSearchParams" : createSearchParams(usernameEditingController.text)
    };
    db.uploadUser(userMap);
    authFunctions.signupUserWithEmailAndPassword(emailEditingController.text, passwordEditingController.text);
    SharedPreferenceFunctions.saveUserLoggedInSharedPreference(true);
    SharedPreferenceFunctions.saveUserNameSharedPreference(usernameEditingController.text);
    SharedPreferenceFunctions.saveUserEmailIdSharedPreference(emailEditingController.text);
    Constant.userName = usernameEditingController.text;
    Constant.userID = userid;
    SharedPreferenceFunctions.saveUserIdSharedPreference(Constant.userID);
    Navigator.pushReplacement(
    context, 
    MaterialPageRoute(
      builder: (context){
        return AppContainer(0, false);
      }
    )
  );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            // margin: EdgeInsets.only(top: 200),
            child: Column(
              children: [
                SizedBox(height: 50),
                 Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: (){currentTheme.toggleTheme();},
                    child: Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.brightness_4),
                    ),
                  ),
                ),
                SizedBox(height: 160),
                Image.asset('assets/images/logo.png', height: 70, color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white : Colors.black,),
                SizedBox(height: 25),
                // doesUserNameExistStatus?  Container(
                //         child: Text("Username is already taken"),
                //       ): Container(),
                // SizedBox(height: 15),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 70,
                        child: TextFormField(
                          controller: usernameEditingController,
                          validator: (val){return validateUserName(val);},
                          cursorColor: currentTheme.currentTheme == ThemeMode.dark ? Colors.white54 : Colors.black45,
                          decoration: inputFormDecoration("Enter username")
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 70,
                        child: TextFormField(
                          controller: emailEditingController,
                          validator: (val){return validateEmail(val);},
                          cursorColor: currentTheme.currentTheme == ThemeMode.dark ? Colors.white54 : Colors.black45,
                          decoration: inputFormDecoration('Enter email')
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 70,
                        child: TextFormField(
                          controller: passwordEditingController,
                          validator: (val){return validatePassword(val);},
                          cursorColor: currentTheme.currentTheme == ThemeMode.dark ? Colors.white54 : Colors.black45,
                          decoration: inputFormDecoration('Password')
                        ),
                      ),
                      SizedBox(height: 20),
                      isLoading ?
                      loadingContainer(context) :
                      GestureDetector(
                        onTap: (){
                          signupForNewUser();
                        },
                        child: buttonContainer(context, 'Sign Up'),
                      ),
                    ]
                  )
                ),
                SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? "),
                            GestureDetector(
                              onTap: (){
                                widget.toggle();
                                signup.doesUserNameExistStatus = true;
                              },
                              child: Container(
                                child: Text('Login in.', style: TextStyle(color: Colors.blue.shade300),),
                              )
                            )
                          ]
                        )
                    ],
                  ),
                ],
              ),
          ),
        ),
      )
    );
  }
}