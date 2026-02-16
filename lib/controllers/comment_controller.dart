
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:reel_stream/constants.dart';
import 'package:reel_stream/models/comment.dart';
import 'package:reel_stream/controllers/auth_controller.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;

  String _postId = "";

  void updatePostId(String id) {
    _postId = id;
    getComments();
  }

  getComments() async {
    _comments.bindStream(firestore.collection("videos").doc(_postId).collection("comments").snapshots().map((QuerySnapshot query) {
      List<Comment> retVal = [];
      for (var element in query.docs) {
        retVal.add(Comment.fromSnap(element));
      }
      return retVal;
    }));
  }

  postComment(String commentText) async {
    try{
       if (commentText.isNotEmpty) {
      DocumentSnapshot userDoc =
          await firestore.collection("users")
              .doc(AuthController.instance.user.uid)
              .get();

      var userData = userDoc.data() as Map<String, dynamic>;

      var allDocs = await firestore
          .collection("videos")
          .doc(_postId)
          .collection("comments")
          .get();

      int len = allDocs.docs.length;

      Comment comment = Comment(
        username: userData['name'],
        comment: commentText.trim(),
        datePublished: DateTime.now(),
        likes: [],
        profilePhoto: userData['profilePhoto'],
        uid: AuthController.instance.user.uid,
        id: "Comment $len",
      );

      await firestore
          .collection("videos")
          .doc(_postId)
          .collection("comments")
          .doc("Comment $len")
          .set(comment.toJson());

          DocumentSnapshot doc= await firestore.collection("videos").doc(_postId).get();
         await firestore.collection("videos").doc(_postId).update({
            "commentCount": (doc.data()! as dynamic)["commentCount"] + 1,
          });

    }
    }catch(e){
      Get.snackbar("Error while commenting", e.toString());
    }
  }
  likeComment(String id)async{
    var uid=authContoller.user.uid;
    DocumentSnapshot doc= await firestore.collection("videos").doc(_postId).collection("comments").doc(id).get();

    if((doc.data()! as dynamic)["likes"].contains(uid)){
       await firestore.collection("videos").doc(_postId).collection("comments").doc(id).update({
        "likes": FieldValue.arrayRemove([uid])
      });
      
    }else{
       await firestore.collection("videos").doc(_postId).collection("comments").doc(id).update({
        "likes": FieldValue.arrayUnion([uid])
      });
    }
  }
}
