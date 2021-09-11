import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/stories.dart';

class InstaStories extends StatefulWidget {
  const InstaStories({ Key? key }) : super(key: key);

  @override
  _InstaStoriesState createState() => _InstaStoriesState();
}

class _InstaStoriesState extends State<InstaStories> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topRow(context),
        stories()
      ],
    );
  }
}





