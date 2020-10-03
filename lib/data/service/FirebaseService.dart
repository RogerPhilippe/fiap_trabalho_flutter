import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiap_trabalho_flutter/data/model/Task.dart';
import 'package:fiap_trabalho_flutter/data/model/User.dart';
import 'package:fiap_trabalho_flutter/data/service/LogUtils.dart';
import 'package:fiap_trabalho_flutter/data/utils/UserSession.dart';
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

  static Future<bool> saveTasks(UserSession userSession, List<Task> tasks, FirebaseFirestore firestore) async {

    tasks.forEach((task) async {
      await firestore.collection("tasks").add({
        "userID" : userSession.userID,
        "taskID" : task.id,
        "taskTitle" : task.title,
        "taskDescription" : task.description,
        "taskDateCreated" : task.dateCreated,
        "todoDate" : task.todoDate,
        "lastUpdateDate" : task.lastUpdateDate,
        "status" : task.status
      });
    });

    return true;

  }

  static Future<QuerySnapshot> getTasks(UserSession userSession, FirebaseFirestore firestore) async {

    return await firestore.collection("tasks").where("userID", isEqualTo: userSession.userID).get();
  }

  static Future<bool> removeTasks(UserSession userSession, FirebaseFirestore firestore) async {

    await firestore.collection("tasks").where("userID", isEqualTo: userSession.userID).get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        LogUtils.info("Removing task ${doc['taskTitle']}");
        doc.reference.delete();
      });
    });

    return true;
  }

  static void removeUser(UserSession userSession,  FirebaseFirestore firestore) async {

    await firestore.collection("users").where("userID", isEqualTo: userSession.userID).get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        LogUtils.info("Removing user ${doc['userID']}");
        doc.reference.delete();
      });
    });
  }

}