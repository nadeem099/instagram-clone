import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/providers/firebaseStorage.dart';
import 'package:instagram_clone/screens/appContainer.dart';
import 'package:instagram_clone/screens/homepage.dart';
import 'package:instagram_clone/utilities/config.dart';
import 'package:instagram_clone/utilities/constant.dart';
import 'package:instagram_clone/utilities/sharedPrefrenceFunctions.dart';
import 'package:instagram_clone/utilities/themes/themes.dart';
import 'package:location/location.dart';
import 'package:flutter_geocoder/geocoder.dart';

class PostPage extends StatefulWidget {
  final File? postFile;
  PostPage({ this.postFile});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController descriptionEditingController = new TextEditingController();
  TextEditingController locationEditingController = new TextEditingController();
  String specificAddress = '';
  CollectionReference postRef = FirebaseFirestore.instance.collection('posts');
  bool isPostUploading = false;

  uploadPost() async{
    setState(() {
      isPostUploading = true;
    });
    String postId = pid.v4();
    String fileURL =  await startUpload(widget.postFile);
    // String userId = await SharedPreferenceFunctions.getuserUserIdSharedPreference();
    // print('user id fetched from the shared preference ${userId}');
    final DateTime timeStamp = DateTime.now();
    // postRef.doc(userId).collection("userposts").doc(postId).set  -- other method
    await postRef.doc(postId).set({
      "postId" : postId,
      "userId" : Constant.userID,
      "timeStamp" : timeStamp,
      "likes" : {'likeCount': 0, 'users': []},
      "username" : Constant.userName,
      "description" : descriptionEditingController.text,
      "location" : locationEditingController.text,
      "fileurl" : fileURL
    }).catchError((err)=>print(err));
      postRef.doc(postId).collection('comments').add({
                                          'commentText': descriptionEditingController.text,
                                          'userId': Constant.userID,
                                          'userName': Constant.userName,
                                          'timeStamp': DateTime.now()
                                        });
    Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return AppContainer(0, false);
    }));
  }

  //fetching user location
  fetchLocation() async{
    var myLocation;
    LocationData selectedLocation;
    String err;
    Location location = new Location();

    try{
      myLocation = await location.getLocation();
    }on PlatformException catch(e){
      if(e.code == "PERMISSION_DENIED"){
        err = "Please grant permission";
        print(err);
      }if(e.code == "PERMISSION_DENIED_NEVER_ASK"){
        err = "Permission denied - please enable it from app setting";
        print(err);
      }
      myLocation = null;
    }
    selectedLocation = myLocation;
    final coordinates =  Coordinates(selectedLocation.latitude, selectedLocation.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    String completeAdress = '${first.locality}, ${first.adminArea}, ${first.subLocality}, ${first.subAdminArea}, ${first.addressLine}, ${first.featureName}, ${first.thoroughfare}, ${first.subThoroughfare}';
    print(completeAdress);
    String specificAddress = '${first.locality}, ${first.countryName}';
    locationEditingController.text = specificAddress;
  }


  @override
  Widget build(BuildContext context) {
    //TODO: need to fix bottom overflow caused by keyboard
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop(true);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('New Post', style: TextStyle(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white : Colors.black),),
          actions: [
            IconButton(
              onPressed: (){
                uploadPost();
              }, 
              color: Colors.blue.shade500,
              icon: isPostUploading ? CircularProgressIndicator() : Icon(FontAwesomeIcons.check)
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white54 : Colors.black54),
                          image: DecorationImage(
                            image: AssetImage('assets/images/userProfilePicPlaceHolder.png')
                          )
                        )
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: descriptionEditingController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Write a caption...',
                            hintStyle: TextStyle(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white54 : Colors.black54)
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(2)
                        ),
                        child: Image.file(widget.postFile as File)
                      )
                    ],
                  ),
              ),
              Container(height: 1,color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white30 : Colors.black38),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 2,),
                    Expanded(
                      child: TextField(
                        controller: locationEditingController,
                        decoration: InputDecoration(
                          hintText: 'Add location',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none
                        )
                      ),
                    ),
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: (){
                        fetchLocation();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text('Get current location', style: TextStyle(color: Colors.white,)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue.shade500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        ),
    );
  }
}