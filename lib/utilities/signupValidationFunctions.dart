import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/screens/signup.dart';
import 'package:instagram_clone/utilities/config.dart';

String? validateUserName(String? val){
  // String? errMessage;
  if(val!.isEmpty || val.length < 2){
    return "Username should be atleast two characters long";
  }else if(signup.doesUserNameExistStatus == true){
    return "Username is already taken";
  }else{
    return null;
  }
}

String? validateEmail(String? val){
  if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val as String))return null;
  else return "Enter a valid email";
}

String? validatePassword(String? val){
  return val!.isEmpty || val.length < 6 ? "Password should not be less than 6 characters" : null;
}

