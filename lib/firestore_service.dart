import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Method to add user data to Firestore
  Future<void> addUser(String name) async {
    await _db.collection('users').add({'name': name});
  }

  // Method to get documents from a specific collection
  Stream<List<DocumentSnapshot>> getDocuments(String collectionPath) {
    return _db.collection(collectionPath).snapshots().map((snapshot) => snapshot.docs);
  }
}