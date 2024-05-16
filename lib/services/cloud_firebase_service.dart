import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wigo/models/Trip.dart';

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

  Future<void> deleteTrip(Trip tripToBeDeleted) {
    //find document that has the same value as the tripToBeDeleted above
    var docToBeDeleted = _firestore
        .collection('trips')
        .where('owner_uuid', isEqualTo: tripToBeDeleted.owner_uuid)
        .where('city', isEqualTo: tripToBeDeleted.city)
        .where('budget', isEqualTo: tripToBeDeleted.budget)
        .where('members', isEqualTo: tripToBeDeleted.members)
        .get();
    return docToBeDeleted.then((value) {
      value.docs.forEach((element) {
        print(element.id);
        _firestore.collection('trips').doc(element.id).delete();
      });
    });
  }
}
