import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/providers/database.dart';
import 'package:instagram_clone/screens/signin.dart';
import 'package:instagram_clone/utilities/config.dart';

class AuthFunctions{
  final FirebaseAuth _auth = FirebaseAuth.instance; 

  UserObj? userFromFirebaseUser(User? firebaseUser){
    return firebaseUser != null ? UserObj(userId: firebaseUser.uid) : null; 
  }

  signupUserWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      User? firebaseUser = userCredential.user;
      return userFromFirebaseUser(firebaseUser);
    }catch(e){
      print(e);
    }
  }

  signinUserWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      User? firebaseUser = userCredential.user;
      return userFromFirebaseUser(firebaseUser);
    }catch(e){
      print(e);
    }
  }

  signinUserWithUserNameAndPassword(String username, String password) async{
    //check whether username exist in the database?
    //if exists fetch the corresponding email
    QuerySnapshot emailSearchSnapshot;
    try{
      emailSearchSnapshot = db.getDocumentByUsername(username);
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailSearchSnapshot.docs[0]["email"], 
        password: password
      );
      User? firebaseUser = userCredential.user;
      return userFromFirebaseUser(firebaseUser);
    }catch(e){
      print(e);
    }
  }

  signoutUser() async{
    try{
     await  _auth.signOut();
    }catch(e){
      print(e);
    }
  }

}