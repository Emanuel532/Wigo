import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(
      String collection, String documentId) {
    return _firestore.collection(collection).doc(documentId).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getTripsByOwnerAndFriends(
      String ownerUuid) {
    return _firestore
        .collection('trips')
        .where('owner_uuid', isEqualTo: ownerUuid)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllDocuments(
      String collection) {
    return _firestore.collection(collection).get();
  }

  Future<void> addDocument(String collection, Map<String, dynamic> data) {
    return _firestore.collection(collection).add(data);
  }

  Future<void> updateDocument(
      String collection, String documentId, Map<String, dynamic> data) {
    return _firestore.collection(collection).doc(documentId).update(data);
  }

  Future<void> deleteDocument(String collection, String documentId) {
    return _firestore.collection(collection).doc(documentId).delete();
  }
}
