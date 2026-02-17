import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:reel_stream/controllers/auth_controller.dart';
import 'package:reel_stream/views/widgets/screens/add_video_screen.dart';
import 'package:reel_stream/views/widgets/screens/auth/video_screen.dart';
import 'package:reel_stream/views/widgets/screens/profile_screen.dart';
import 'package:reel_stream/views/widgets/screens/search_screen.dart';

List pages =[
  VideoScreen(),
   SearchScreen(),
  const AddVideoScreen(),
  Text("Messages Screen"),
 ProfileScreen(uid: authController.user.uid)

];
//Colors
const backgroundColor = Colors.black;
var buttonColor = Colors.red.shade400;
const borderColor = Colors.grey;

//Firebase
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore  = FirebaseFirestore.instance;

//Controller
var authContoller = AuthController.instance;