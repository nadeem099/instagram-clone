import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/auth.dart';
import 'package:instagram_clone/providers/database.dart';
import 'package:instagram_clone/screens/signup.dart';
import 'package:instagram_clone/utilities/themes/themes.dart';
import 'package:uuid/uuid.dart';

//object for accessing the currentTheme of the app
CustomTheme currentTheme = new CustomTheme();

  //formkey object to store the validation status during signup
  final formkey = GlobalKey<FormState>();

// updating the height of the input fields 
//  updateInputFieldHeight(){
//   if(formkey.currentState == null){
//     Signup.inputBoxheight = 50;
//   }else{
//     Signup.inputBoxheight = 70;
//   }
// }

//instance of signup required for username input field validation
var signup = new Signup(toggle: (){});

Color themeTernaryOperator = currentTheme.currentTheme == ThemeMode.dark ? Colors.white : Colors.black;





//DatabaseFunctions class instance
DatabaseFunctions db = new DatabaseFunctions(); 

//AuthFunctions class instance
AuthFunctions authFunctions = new AuthFunctions();

//Unique user id generator object
var uid = Uuid();

//Unique post id generator object
var pid = Uuid();