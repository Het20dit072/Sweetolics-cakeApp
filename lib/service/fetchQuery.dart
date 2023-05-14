import 'package:cloud_firestore/cloud_firestore.dart';

// Define a reference to your Firestore database
final firestore = FirebaseFirestore.instance;

// Define the collection you want to fetch data from
final CollectionReference collectionReference =
    firestore.collection("cakesdetails");

// Fetch data from the collection
void fetchData() async {
  // Get a stream of documents from the collection
  Stream<QuerySnapshot> snapshot = collectionReference.snapshots();

  // Listen to the stream and process each document
  snapshot.listen((querySnapshot) {
    // Cast querySnapshot to QuerySnapshot
    QuerySnapshot qs = querySnapshot;

    qs.docs.forEach((document) {
      // Do something with each document
      print(document.data);
    });
  });
}
