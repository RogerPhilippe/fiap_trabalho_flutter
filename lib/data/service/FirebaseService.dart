import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiap_trabalho_flutter/data/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {

  static Future<DocumentReference> saveFireStore(User user, FirebaseFirestore firestore) {

    return firestore.collection("users").add({
      "userID" : user.id,
      "userName" : user.name,
      "userEmail": user.email
    });
  }

  static Future<QuerySnapshot> findUserFirestore(User user, FirebaseFirestore firestore) {

    return firestore.collection("users")
        .where("userEmail", isEqualTo: user.email).get();
  }

  static Future<FirebaseUser> loginFirebase(User user, FirebaseAuth auth) {

    return auth.signInWithEmailAndPassword(email: user.email, password: user.id);
  }

  static Future<FirebaseUser> createFirebaseUser(User user, FirebaseAuth auth) {

    return auth.createUserWithEmailAndPassword(email: user.email, password: user.id);
  }

}