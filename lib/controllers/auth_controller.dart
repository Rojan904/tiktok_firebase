import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_firebase/core/constants.dart';
import 'package:tiktok_firebase/view/screens/auth/signup_screen.dart';
import 'package:tiktok_firebase/view/screens/home_screen.dart';

import '../model/user_model.dart' as model;

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  //register the user
  late Rx<File?> _pickedImage; //observable, updated when event changes
  late Rx<User?> _user;

  File? get profilePhoto => _pickedImage.value;

  @override
  void onReady() {
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(
      firebaseAuth.authStateChanges(),
    ); //streams state chang es in auth
    // ever(_user, _setInitialScreen); //wheneever user value chnnages
    super.onReady();
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => SignupScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      _pickedImage = Rx<File?>(File(pickedImage.path));

      Get.snackbar('Profile Picture', "Uploaded picture successfully");
    }
  }

  void registerUser(
    String username,
    String email,
    String password,
    File? image,
  ) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //save our user to auth firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // Upload profile picture using uid from credential

        String downloadUrl = await _uploadToStorage(image, cred.user!.uid);
        final user = model.User(
          name: username,
          email: email,
          profilePhoto: downloadUrl,
          uid: cred.user!.uid,
        );
        await firebaseFirestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        Get.snackbar('Registration', "Success regitering user.");
      } else {
        Get.snackbar("Error creating account", 'Please enter all the fields.');
      }
    } catch (e) {
      Get.snackbar("Error creating account", e.toString());
      print(e.toString());
    }
  }

  Future<String> _uploadToStorage(File image, String uid) async {
    if (!image.existsSync()) {
      throw Exception('Profile image does not exist.');
    }

    try {
      final ref = firebaseStorage.ref().child('profilePics').child('$uid.jpg');
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw Exception("Upload failed: ${e.message}");
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((val) {
              Get.snackbar('Login', "Success logging in user.");
            });
      } else {
        Get.snackbar("Error logging in", 'Enter all fields');
      }
    } catch (e) {
      Get.snackbar("Error logging in", e.toString());
    }
  }
}
