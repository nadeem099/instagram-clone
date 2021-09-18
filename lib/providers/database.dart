import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  getUserByusernameSearch(String keyword) async{
    return await firestore.collection('users')
    .where('usernameSearchParams', arrayContains: keyword)
    .get();
  }

  getUserBynameSearch(String keyword) async{
    return await firestore.collection('users')
    .where('nameSearchParam', arrayContains: keyword)
    .get();
  }


  uploadUser(Map<String, dynamic> userMap) async{
    await firestore.collection('users').doc(userMap["userid"]).set(userMap)
    .catchError((err) => print(err));
  }

  //using this function to handle exception while signinup
  updateFollowerOnSignup(signedupUser)async{
    await firestore.collection('users').doc(signedupUser)
    .collection('followers').doc(signedupUser).set({'userid' : signedupUser});
  }

  //using this function to handle exception while signinup
  updateFollowingOnSignup(signedupUser)async{
    await firestore.collection('users').doc(signedupUser)
    .collection('following').doc(signedupUser).set({'userid' : signedupUser});
  }  

  //update searched user's follower
  addInSearchedUserFollowers(searchedUser)async{
    await firestore.collection('users').doc(searchedUser)
    .collection('followers').doc(Constant.userID).set({'userid': Constant.userID});
  }

  //update current user's following
  addInCurrentUserFollowing(searchedUser)async{
    await firestore.collection('users').doc(Constant.userID)
    .collection('following').doc(searchedUser).set({'userid' : searchedUser});
  }

  removeFromSearchedUserFollowers(searchedUser)async{
    await firestore.collection('users').doc(searchedUser)
    .collection('followers').doc(Constant.userID).delete();  
  }

  removeFromCurrentUserFollowing(searchedUser)async{
    await firestore.collection('users').doc(Constant.userID)
    .collection('following').doc(searchedUser).delete();  
  }  

  //method to verify if a user exists in the followings of signin user
  getUserFollowing(searchedUser)async{
    try{
      return await firestore.collection('users').doc(Constant.userID)
      .collection('following').doc(searchedUser).get();
    }catch(e){
      print(e.toString());
      // return 'error occured';
    }
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

  getPostsOfSearchedUser(String userId) async{
    return await firestore.collection('posts')
    .orderBy('timeStamp', descending:  true)
    .where('userId', isEqualTo: userId)
    .snapshots();
  }


//getting following of user's from users/doc/following collection
//then getting post of every user of following collection fomr post collection
  // getPostsOfSignedinUserFollowing() async{
  //   return await firestore.collection('users')
  //   .doc(Constant.userID).collection('following').get()
  //   .then((value) async{
  //     value.docs.forEach((element)async{
  //       // print(element.data()['userid']);
  //       firestore.collection('posts')
  //       .orderBy('timeStamp', descending: true)
  //       .where('userId', isEqualTo: element.data()['userid'])
  //       .snapshots().forEach((element) {
  //         element.docs.forEach((element) {
  //           print(element.data()['username']);
  //         });
  //       });
  //     });
  //   });
  // }

  getPostsOfSignedInUserFollowing() async{
    return await firestore.collection('users')
    .doc(Constant.userID).collection('following').get();
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