import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/screens/homepage.dart';
import 'package:instagram_clone/utilities/config.dart';

Widget cameraButton(context, pickFile){
  return  Padding(
    padding: EdgeInsets.symmetric(horizontal:15, vertical: 20),
    child: Container(
            width: MediaQuery.of(context).size.width * 0.42,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white : Colors.black),
              borderRadius: BorderRadius.circular(20)
            ),
            child: IconButton(
              onPressed: (){
                pickFile(ImageSource.camera);
              },
              icon: Icon(FontAwesomeIcons.camera),
            ),
          ),
  );
}

Widget gallaryButton(context, pickFile){
  return  Padding(
    padding: EdgeInsets.symmetric(horizontal:15, vertical: 20),
    child: Container(
            width: MediaQuery.of(context).size.width * 0.42,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white : Colors.black),
              borderRadius: BorderRadius.circular(20)
            ),
            child: IconButton(
              onPressed: (){
                pickFile(ImageSource.gallery);
                // Navigator.push(context, MaterialPageRoute(builder: (context){
                //   return ;
                // }));
              },
              icon: Icon(Icons.add),
            ),
          ),
  );
}

Widget imageEditingButton(icon, context, cropOrClear){
  return  Padding(
    padding: EdgeInsets.symmetric(horizontal:15, vertical: 20),
    child: Container(
            width: MediaQuery.of(context).size.width * 0.42,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white : Colors.black),
              borderRadius: BorderRadius.circular(20)
            ),
            child: IconButton(
              onPressed: (){
                cropOrClear();
              },
              icon: icon,
            ),
          ),
  );
}


Widget postText(context){
  return SingleChildScrollView(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Container(
            margin: EdgeInsets.all(7),
            // height: MediaQuery.of(context).size.height* 0.,
            child: TextField(
              maxLines: 10,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white : Colors.black)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white : Colors.black)
                ),
                hintText: "What's in your mind?",
                // fillColor: Color(0xffF2F3F4),
                filled: true,
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.blue.shade500,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Text('Post', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  Container(
                    
                  )
                ],
              ),
            ),
          )
      ],
    ),
  )
    ;
}

Widget createPost(context, pickFile){
  return Column(
    children: [
      Row(
        children: [
          cameraButton(context, pickFile),
          gallaryButton(context, pickFile),
        ],
      ),
      postText(context) 
    ],
  );
}