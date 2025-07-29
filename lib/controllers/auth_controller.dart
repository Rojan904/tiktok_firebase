import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_firebase/core/constants.dart';

import '../model/user_model.dart' as model;

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  //register the user
  late Rx<File?> _pickedImage; //observable, updated when event changes
  File? get profilePhoto => _pickedImage.value;
  void pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      Get.snackbar('Profile Picture', "Uploaded picture successfully");
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
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
        String downloadUrl = await _uploadToStorage(image);
        final user = model.User(
          name: username,
          email: email,
          profilePhoto: downloadUrl,
          uid: cred.user!.uid,
        );
        await firebaseFirestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson())
            .then((val) {
              Get.snackbar('Registration', "Success regitering user.");
            });
      } else {
        Get.snackbar("Error creating account", 'Please enter all the fields.');
      }
    } catch (e) {
      Get.snackbar("Error creating account", e.toString());
    }
  }

  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
