import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instanceFor(bucket: 'gs://instagram-clone-32b6b.appspot.com');
  
  startUpload(file) async{
    File uploadingFile = File(file.path);
    try{
      String storageFile = 'images/${DateTime.now()}';
      await _storage.ref(storageFile).putFile(uploadingFile);
      String downloadURL = await _storage.ref(storageFile).getDownloadURL();
      return downloadURL;
    }catch(e){
      print(e);
    }
  }
