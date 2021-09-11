import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/screens/uploadToFirebase.dart';
import 'package:instagram_clone/utilities/config.dart';
import 'package:instagram_clone/screens/PostPage.dart';
import 'package:instagram_clone/widgets/createPost.dart';
import 'package:image/image.dart' as img;
import 'dart:io';

class ImageCapture extends StatefulWidget {
  
  const ImageCapture({ Key? key }) : super(key: key);

  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  
  var _selectedImageFile;
  File? _convertedFile;
  // XFile? _selectedVideoFile, _capturedImageFile, _capturedVideoFile;

  final ImagePicker  _picker = ImagePicker();

  Future<void> pickFile(ImageSource source) async{
    XFile? _selectedImage = await _picker.pickImage(source: source);
    // XFile? selectedVideo = await _picker.pickVideo(source: ImageSource.gallery);
    // XFile? capturedImage = await _picker.pickImage(source: ImageSource.camera);
    // XFile? capturedVideo = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      _selectedImageFile = _selectedImage;
      // _selectedVideoFile = selectedVideo;
      // _capturedImageFile = capturedImage;
      // _capturedVideoFile = capturedVideo;
    });
    if(_selectedImageFile != null)XFiletoFile();
  }

  Future<void> cropImage() async{
    File? croppedFile = await ImageCropper.cropImage(sourcePath: _selectedImageFile!.path);
    setState(() {
      // _selectedImageFile = croppedFile ?? _selectedImageFile;
      if(croppedFile != null){
        _convertedFile = croppedFile;
      }
    });
  }

  void clear(){
    setState(() {
      _selectedImageFile = null;
    });
  }

  XFiletoFile() async{
    // final bytes = await File(_selectedImageFile!.path).readAsBytes();
    // final img.Image? _image = img.decodeImage(bytes);
    File _image = File(_selectedImageFile!.path);
    setState(() {
      _convertedFile = _image;
    });
  }

  Widget build(BuildContext context) {
    return _selectedImageFile == null 
    ? createPost(context, pickFile) 
    : Column(
      children: [
        Row(
          children: [
            cameraButton(context, pickFile),
            gallaryButton(context, pickFile),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Image.file(
            _convertedFile as File, 
            height: 500, 
            width: MediaQuery.of(context).size.width,
          )
        ),
        Row(
          children: <Widget>[
            imageEditingButton(Icon(Icons.crop), context, cropImage),
            imageEditingButton(Icon(Icons.refresh), context, clear)
          ],
        ),
        GestureDetector(
          onTap: (){
            // startUpload(_convertedFile);
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return PostPage(postFile: _convertedFile,);
            }));
          }, 
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.95,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5) ,
              color: Colors.blue.shade500
            ),
            child: Text('Post', style: TextStyle(color: Colors.white),),
          )
        )
      ],
    );
  }
}