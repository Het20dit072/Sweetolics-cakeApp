import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/HomeScreen.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/customizeCake.dart';

import 'add_image.dart';

class PostCakeDetails extends StatefulWidget {
  @override
  _PostCakeDetailsState createState() => _PostCakeDetailsState();
}

class _PostCakeDetailsState extends State<PostCakeDetails> {
  // Declare the controllers for the form fields
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _CakeTypeController = TextEditingController();
  final _FlavourController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Reference to the Firestore collection
  final DocumentReference<Map<String, dynamic>> cakeCollection =
      FirebaseFirestore.instance.collection('cakesdetails').doc(user!.uid);

  // Handle the image picker

  @override
  Widget build(BuildContext context) {
    void _submitForm() async {
      // Add the form data to the Firestore collection
      cakeCollection.set({
        'Cake Name': _nameController.text,
        'price': int.parse(_priceController.text),
        'Cake Type': _CakeTypeController.text,
        'Cake Flavour': _FlavourController.text,
        'description': _descriptionController.text,
      });
      await Future.delayed(Duration(seconds: 2));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PetsImage()));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: Text('Cake Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              // Name field
              RoundedTextField(
                controller: _nameController,
                hintText: 'Cake Name',
              ),
              SizedBox(
                height: 20,
              ),
              // Price field
              RoundedTextField(
                controller: _priceController,
                hintText: 'Price',
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              // Image field
              RoundedTextField(
                controller: _CakeTypeController,
                hintText: 'Cake Type',
              ),
              SizedBox(
                height: 20,
              ),
              // Description field
              RoundedTextField(
                controller: _FlavourController,
                hintText: 'Flavour',
              ),
              SizedBox(
                height: 20,
              ),
              RoundedTextField(
                controller: _descriptionController,
                hintText: 'Description',
              ),
              // Submit button
              Container(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                  child: Text('Submit'),
                  onPressed: _submitForm,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;

  RoundedTextField({
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
