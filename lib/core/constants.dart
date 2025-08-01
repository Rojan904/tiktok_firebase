import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_firebase/controllers/auth_controller.dart';
import 'package:tiktok_firebase/view/screens/add_video_screen.dart';
import 'package:tiktok_firebase/view/screens/video_screen.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

//firebase
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firebaseFirestore = FirebaseFirestore.instance;

//controleler
var authController = AuthController.instance;

var pages = [
  VideoScreen(),
  Text('Home Screen'),
  AddVideoScreen(),
  Text('Home Screen'),
  Text('Home Screen'),
];
