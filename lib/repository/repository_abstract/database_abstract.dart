import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreDB {
  Future<void> addDocWithId(
      String collection, String docId, Map<String, dynamic> data);

  Future<DocumentReference> addDoc(
      String collection, Map<String, dynamic> data);

  Future<QuerySnapshot> getDocByField(
      String collection, String fieldName, dynamic value);

  Future<DocumentSnapshot> getDocById(String collection, String docId);

  Future<QuerySnapshot> getAllDocs(String collection);

  Future<void> updateDoc(
      String collection, String docId, Map<String, dynamic> data);

  Future<void> deleteDoc(String collection, String docId);
}
