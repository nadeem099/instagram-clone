import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget BottomNavBar(){
  return Row(
    children: [
      IconButton(onPressed: (){}, icon: Icon(Icons.home_filled)),
      IconButton(onPressed: (){}, icon: Icon(Icons.search)),
      IconButton(onPressed: (){}, icon: Icon(Icons.add)),
      IconButton(onPressed: (){}, icon: Icon(Icons.comment)),
      IconButton(onPressed: (){}, icon: Icon(Icons.person))
    ],
  );
}