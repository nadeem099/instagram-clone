import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/providers/database.dart';
import 'package:instagram_clone/screens/appContainer.dart';
import 'package:instagram_clone/utilities/config.dart';
import 'package:instagram_clone/utilities/constant.dart';
import 'package:instagram_clone/widgets/appbar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({ Key? key }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextStyle labelStyle = TextStyle(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white54 : Colors.black54); 
  UnderlineInputBorder inputBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white54 : Colors.black54)
  );
  final formkey = GlobalKey<FormState>();
  bool isUsernameAvailable = true;
  bool isProfilePageLoading = false;
  var profileSnapshot;
  DatabaseFunctions databaseFunctions = new DatabaseFunctions();
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController usernameEditingController = new TextEditingController();
  TextEditingController websiteEditingController = new TextEditingController();
  TextEditingController bioEditingController = new TextEditingController();

  @override
  void initState() {
  fetchProfileInfo();
    super.initState();
  }

  fetchProfileInfo() async{
    await databaseFunctions.getUserProfileInfo().then((val){
      setState(() {
        profileSnapshot = val;
      });
    });
    if(profileSnapshot.data()!['name'] != null){
      nameEditingController.text = profileSnapshot.data()!['name'];
    }
    if(profileSnapshot.data()!['userName'] != null){
      usernameEditingController.text = profileSnapshot.data()!['userName'];
    }
    if(profileSnapshot.data()!['website'] != null){
      websiteEditingController.text = profileSnapshot.data()!['website'];
    }
    if(profileSnapshot.data()!['bio'] != null){
      bioEditingController.text = profileSnapshot.data()!['bio'];
    }
  }

  uploadUserProfileInfo() async{
    if(formkey.currentState!.validate()){
      setState(() {
        isProfilePageLoading = true;
      });
      await databaseFunctions.updateUserProfileInfo({
      'name': nameEditingController.text,
      'userName': usernameEditingController.text,
      'website': websiteEditingController.text,
      'bio': bioEditingController.text,
      'nameSearchParams' : createSearchParams(nameEditingController.text),
      'usernameSearchParams' : createSearchParams(usernameEditingController.text)
      });
      print('user profile is update');
      Constant.userName = usernameEditingController.text;
      print(Constant.userName);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context){
          return AppContainer(4, false);
        }
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.cancel)
        ),
        title: Text('Edit Profile', style: TextStyle(
          color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white : Colors.black
        )),
        actions: [
          isProfilePageLoading ? 
          CircularProgressIndicator() :
          IconButton(
            onPressed: (){
              uploadUserProfileInfo();
            }, 
            icon: Icon(FontAwesomeIcons.check, color: Colors.blue.shade500,),
          ), 
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white : Colors.black), 
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/myprofile.png')
                  )
                ),
              ),
              GestureDetector(
                onTap: (){},
                child: Container(
                  child: Text('Change profile photo', style: TextStyle(color: Colors.blue.shade500, fontSize: 15),),
                ),
              ),
              Container(
                child: TextField(
                  controller: nameEditingController,
                  cursorColor: Colors.blue.shade800,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: labelStyle,
                    focusedBorder: inputBorder 
                  ),
                )
              ),
              Container(
                child: Form(
                  key: formkey,
                  child: TextFormField(
                    onChanged: (val){
                      if(val.length >= 2){
                        databaseFunctions.getDocumentByUsername(val).then((querySnapshot){
                          print(querySnapshot.size);
                          if(querySnapshot.size == 0){
                            setState(() {
                              isUsernameAvailable = true;
                            });
                          }else{
                            setState(() {
                              isUsernameAvailable = false;
                            });
                          }
                        });
                      }
                    },
                    validator: (val){
                      return val!.isNotEmpty && isUsernameAvailable ? null : 'Username is already taken';
                    },
                    controller: usernameEditingController,
                    cursorColor: Colors.blue.shade800,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: labelStyle,
                      focusedBorder: inputBorder 
                    ),
                  ),
                )
              ),
              Container(
                child: TextField(
                  controller: websiteEditingController,
                  cursorColor: Colors.blue.shade800,
                  decoration: InputDecoration(
                    labelText: 'Website',
                    labelStyle: labelStyle,
                    focusedBorder: inputBorder
                  ),
                )
              ),
              Container(
                child: TextField(
                  controller: bioEditingController,
                  cursorColor: Colors.blue.shade800,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  maxLength: 80,
                  decoration: InputDecoration(
                    labelText: 'Bio',
                    labelStyle: labelStyle,
                    focusedBorder: inputBorder
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

