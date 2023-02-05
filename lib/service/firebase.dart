import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<void> addData(Map<String, dynamic> data) async {
    final CollectionReference ref = _db.collection('collection_name');
    await ref
        .add(data)
        .then((value) => print("Document Added with ID: ${value.id}"));
  }
}
