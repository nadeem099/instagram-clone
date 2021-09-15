import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/screens/signup.dart';
import 'package:instagram_clone/utilities/config.dart';


InputDecoration inputFormDecoration(String textHint){
  return InputDecoration(
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white54 : Colors.black45),
              // borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white54 : Colors.black45),
              borderRadius: BorderRadius.circular(5),
            ),
            hintText: textHint,
            hintStyle: TextStyle(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white54 : Colors.black45),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white54 : Colors.black45),
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: currentTheme.currentTheme == ThemeMode.dark ? Colors.white54 : Colors.black45),
              borderRadius: BorderRadius.circular(5),
            )
          );
}


Widget buttonContainer(BuildContext context, String buttonName){
  return Container(
          width: MediaQuery.of(context).size.width - 40,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blue.shade300,
          ),
          child: Text(buttonName, style: TextStyle(color: Colors.white),),
        );
}

Widget loadingContainer(BuildContext context){
  return Container(
          width: MediaQuery.of(context).size.width - 40,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blue.shade300,
          ),
          child: CircularProgressIndicator(color: Colors.white,)
  );
}