import 'package:cloud_firestore/cloud_firestore.dart';
import '../repository_abstract/database_abstract.dart';

class FirestoreDBImpl implements FirestoreDB {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<DocumentReference<Object?>> addDoc(
      String collection, Map<String, dynamic> data) {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      return firebaseFirestore.collection(collection).add(data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<DocumentSnapshot> getDocById(
    String collection,
    String docId,
  ) async {
    try {
      return firebaseFirestore.collection(collection).doc(docId).get();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> addDocWithId(
    String collection,
    String docId,
    Map<String, dynamic> data,
  ) async {
    try {
      return await FirebaseFirestore.instance
          .collection(collection)
          .doc(docId)
          .set(data);
      // var existingDoc = await getDocById(collection, docId);
      // if (!existingDoc.exists) {
      //   await FirebaseFirestore.instance
      //       .collection(collection)
      //       .doc(docId)
      //       .set(data);
      //   return 'saved';
      // } else {
      //   throw ('Document already exist');
      // }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<QuerySnapshot<Object?>> getDocByField(
    String collection,
    String fieldName,
    dynamic value,
  ) {
    try {
      return firebaseFirestore
          .collection(collection)
          .where(fieldName, isEqualTo: value)
          .get();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<QuerySnapshot<Object?>> getAllDocs(String collection) {
    try {
      return firebaseFirestore.collection(collection).get();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateDoc(
    String collection,
    String docId,
    Map<String, dynamic> data,
  ) {
    try {
      return firebaseFirestore.collection(collection).doc(docId).update(data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteDoc(String collection, String docId) {
    try {
      return firebaseFirestore.collection(collection).doc(docId).delete();
    } catch (e) {
      throw Exception(e);
    }
  }

  // @override
  static String generateFirestoreId(String collection) {
    return FirebaseFirestore.instance.collection(collection).doc().id;
  }
}
