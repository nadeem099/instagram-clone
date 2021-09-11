import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/utilities/constant.dart';

class DatabaseFunctions{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  getDocumentByUsername(String username) async{
    return await firestore.collection('users')
    .where('userName', isEqualTo: username)
    .get();
  }

  getDocumentByEmailId(String email) async{
    return await firestore.collection('users')
    .where('email', isEqualTo: email)
    .get();
  }

  uploadUser(Map<String, dynamic> userMap) async{
    await firestore.collection('users').doc(userMap["userid"]).set(userMap)
    .catchError((err) => print(err));
  }

  getPostDetails() async{
    return await firestore.collection('posts').orderBy("timeStamp", descending: true).snapshots();
  }

  getPostsOfUser() async{
    return await firestore.collection('posts')
    .orderBy("timeStamp", descending: true)
    .where('userId', isEqualTo: Constant.userID)
    .snapshots();
  }

  updateUserProfileInfo(data) async{
    await firestore.collection('users')
    .doc(Constant.userID).update(data);
  }

  getUserProfileInfo() async{
    return await firestore.collection('users')
    .doc(Constant.userID).get();
  }

  Future<List> getUserWhoLiked(String postId) async{
    var userLikedList;
    await firestore.collection('posts')
    .doc(postId).get().then((value) {
      userLikedList = value.data()!['likes']['users'];
    });
    return userLikedList as List;
  }

  increaseLikes(String postId, int likeCount) async{
    var userLikedList = await getUserWhoLiked(postId);
    userLikedList.add(Constant.userID);
    print(userLikedList.length);
    return await firestore.collection('posts')
    .doc(postId).update({'likes': {'likeCount' : likeCount, 'users' : userLikedList}});
  }

  decreaseLikes(String postId, int likeCount) async{
    var userLikedList = await getUserWhoLiked(postId);
    bool isRemoved = userLikedList.remove(Constant.userID);
    if(isRemoved){
      return await firestore.collection('posts')
      .doc(postId).update({'likes': {'likeCount' : likeCount, 'users' : userLikedList}});
    }else{
      print('no user found or something went wrong');
    }
  }

  uploadComment(String commentText, String postId) async{
    await firestore.collection('posts').doc(postId).collection('comments').add({
      'commentText': commentText,
      'userId': Constant.userID,
      'userName': Constant.userName,
      'timeStamp': DateTime.now()
    });
  }

  getComments(String postId) async{
    return await firestore.collection('posts').doc(postId).collection('comments')
    .orderBy('timeStamp', descending: true).snapshots();
  }

}