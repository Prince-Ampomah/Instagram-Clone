import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/constants.dart';
import '../../core/utils/utils.dart';
import '../../model/user_model/user_model.dart';
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
  Future<void> updateNestedDocs(String collection1, String docId1,
      String collection2, String docId2, Map<String, dynamic> data) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore
        .collection(collection1)
        .doc(docId1)
        .collection(collection2)
        .doc(docId2)
        .update(data);
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
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> addNestedDocsWithId(
    String collection1,
    String docId1,
    String collection2,
    String docId2,
    Map<String, dynamic> data,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection1)
          .doc(docId1)
          .collection(collection2)
          .doc(docId2)
          .set(data);
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
  ) async {
    try {
      return await firebaseFirestore
          .collection(collection)
          .doc(docId)
          .update(data);
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

  @override
  Future<void> deleteNestedDocsWithId(
    String collection1,
    String docId1,
    String collection2,
    String docId2,
  ) {
    try {
      return firebaseFirestore
          .collection(collection1)
          .doc(docId1)
          .collection(collection2)
          .doc(docId2)
          .delete();
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Query the user who posted the feed from the [Users] collection in
  /// the database.
  ///
  static Future<UserModel> getUserData(String userId) async {
    UserModel userModel = UserModel();

    try {
      // use post [userId] field to fetch the user the db
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection(Const.usersCollection)
          .doc(userId)
          .get();
      return userModel = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }

    return userModel;
  }
}
