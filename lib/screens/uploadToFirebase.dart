
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// class UploadToFirebase extends StatefulWidget {
//   final file;
//   const UploadToFirebase({this.file});

//   @override
//   _UploadToFirebaseState createState() => _UploadToFirebaseState();
// }

// class _UploadToFirebaseState extends State<UploadToFirebase> {

//   final FirebaseStorage _storage = FirebaseStorage.instanceFor(bucket: 'gs://instagram-clone-32b6b.appspot.com');
  
//   startUpload() async{
//     File file = File(widget.file.path);
//     try{
//       await _storage.ref('images/${DateTime.now()}');
//     }catch(e){
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }


