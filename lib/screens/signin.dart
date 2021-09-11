import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/database.dart';
import 'package:instagram_clone/screens/appContainer.dart';
import 'package:instagram_clone/utilities/config.dart';
import 'package:instagram_clone/utilities/constant.dart';
import 'package:instagram_clone/utilities/sharedPrefrenceFunctions.dart';
import 'package:instagram_clone/utilities/signupValidationFunctions.dart';
import 'package:instagram_clone/widgets/essentialWidgets.dart';

class Signin extends StatefulWidget {
  final Function toggle;
  const Signin({required this.toggle});

  @override
  _SigninState createState() => _SigninState();
} 

class _SigninState extends State<Signin> {
  TextEditingController usernameEditingController = new TextEditingController();
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  DatabaseFunctions databaseFunctions = new DatabaseFunctions();
  bool isLoading = false;


signInUser() async{
    setState(() {
      isLoading = true;
    });
    authFunctions.signinUserWithEmailAndPassword(emailEditingController.text, passwordEditingController.text);
    await databaseFunctions.getDocumentByEmailId(emailEditingController.text)
    .then((val){
      Constant.userID = val.docs[0]['userid'];
      Constant.userName = val.docs[0]['userName'];
      print(Constant.userID);
      print(Constant.userName);
    });
    SharedPreferenceFunctions.saveUserLoggedInSharedPreference(true);
    // SharedPreferenceFunctions.saveUserIdSharedPreference('User id saved to shared prefernce ${userid}');
    SharedPreferenceFunctions.saveUserNameSharedPreference(usernameEditingController.text);
    SharedPreferenceFunctions.saveUserEmailIdSharedPreference(emailEditingController.text);
    Navigator.pushReplacement(
    context, 
    MaterialPageRoute(
      builder: (context){
        return AppContainer(0);
      }
    )
  );
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
                Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    child: TextField(
                      controller: emailEditingController,
                      cursorColor: currentTheme.currentTheme == ThemeMode.dark ? Colors.white54 : Colors.black45,
                      decoration: inputFormDecoration('Enter email')
                    ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  child: TextField(
                    controller: passwordEditingController,
                    cursorColor: currentTheme.currentTheme == ThemeMode.dark ? Colors.white54 : Colors.black45,
                    decoration: inputFormDecoration('Password')
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: (){signInUser();},
                  child: buttonContainer(context, 'Log In')
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Forgotten your login details? "),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        child: Text('Get help with loggin in', style: TextStyle(color: Colors.blue.shade300),),
                      ),
                    ),
                  ]
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Expanded(child: Padding(padding: EdgeInsets.only(left: 20), child: Container(
                        height: 1, 
                        color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white54 : Colors.black45,
                      ))),
                      Text("  OR  "),
                      Expanded(child: Padding(padding: EdgeInsets.only(right: 20), child: Container(
                        height: 1, 
                        color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white54 : Colors.black45,
                      ))),
                      ]
                    )
                  ),
                  SizedBox(height: 20),
                  buttonContainer(context, 'Log In With Username'),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account? "),
                            GestureDetector(
                              onTap: (){
                                widget.toggle();
                              },
                              child: Container(
                                child: Text('Sign up.', style: TextStyle(color: Colors.blue.shade300),),
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