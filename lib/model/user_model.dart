// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String email;
  String profilePhoto;
  String uid;
  User({
    required this.name,
    required this.email,
    required this.profilePhoto,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    "profilePhoto": profilePhoto,
    "email": email,
    'uid': uid,
  };

  static User fromMap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      name: snapshot['name'],
      email: snapshot['email'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
    );
  }
}
