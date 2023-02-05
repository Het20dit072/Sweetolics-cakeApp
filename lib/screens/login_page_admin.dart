// Import the necessary packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminApp extends StatefulWidget {
  @override
  _AdminAppState createState() => _AdminAppState();
}

class _AdminAppState extends State<AdminApp> {
  // Declare the variables to store the form data
  late String name;
  late int price;
  late String image;
  late String description;

  // Reference to the Firestore collection
  final CollectionReference cakeCollection =
      FirebaseFirestore.instance.collection('cakesdetails');

  // Handle the form submission
  void _submitForm() {
    // Add the form data to the Firestore collection
    cakeCollection.add({
      'name': name,
      'price': price,
      'image': image,
      'description': description
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Name field
            TextField(
              decoration: InputDecoration(
                hintText: 'Name',
              ),
              onChanged: (value) => setState(() => name = value),
            ),
            // Price field
            TextField(
              decoration: InputDecoration(
                hintText: 'Price',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() => price = int.parse(value)),
            ),
            // Image field
            TextField(
              decoration: InputDecoration(
                hintText: 'Image URL',
              ),
              onChanged: (value) => setState(() => image = value),
            ),
            // Description field
            TextField(
              decoration: InputDecoration(
                hintText: 'Description',
              ),
              onChanged: (value) => setState(() => description = value),
            ),
            // Submit button
            ElevatedButton(
              child: Text('Submit'),
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }
}
