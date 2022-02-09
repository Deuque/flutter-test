import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseManager {
  static FirebaseManager? _one;

  static FirebaseManager get shared =>
      (_one == null ? (_one = FirebaseManager._()) : _one!);

  FirebaseManager._();

  Future<void> initialise() => Firebase.initializeApp();

  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  CollectionReference tasksRef(path) =>
      firestore.collection(path);
}

