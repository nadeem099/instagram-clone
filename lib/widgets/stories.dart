import 'package:flutter/material.dart';
import 'package:instagram_clone/utilities/config.dart';

Widget topRow(BuildContext context) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Stories", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: MediaQuery.of(context).size.width * 0.4),
        Row(
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.play_arrow)),
            Text("Watch All", style: TextStyle(fontWeight: FontWeight.bold))
          ]
        ) 
      ],
    );
  }


Widget stories() {
  return Expanded(
    child: Padding(
      padding : EdgeInsets.only(left: 10),
      child: ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, index){
        return Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Container(
                width: 70,
                height: 70,
                margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/userProfilePicPlaceHolder.png')
                    ),
                    border: Border.all(color: themeTernaryOperator),
                    shape: BoxShape.circle
                  ),
                ),
                SizedBox(height: 5,),
                Text('Your Story'.substring(0,7)+'..')
              ],
            ),
            index == 0 
            ? Positioned(
              bottom:25,
              right: 4,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.add, size: 20, color: Colors.white,),
              ),
            ): Container()
          ],
        );
        }
      ),
    ),
  );
}