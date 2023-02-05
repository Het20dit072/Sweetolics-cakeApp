import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyGridView extends StatefulWidget {
  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  List<String> buttonTitles = [
    'Birthday',
    'Wedding',
    'Valentines',
    'Baby Shower',
    'Celebrations',
    'Others'
  ];
  Map<String, Color> buttonColors = {
    'Birthday': Colors.white,
    'Wedding': Colors.white,
    'Valentines': Colors.white,
    'Baby Shower': Colors.white,
    'Celebrations': Colors.white,
    'Others': Colors.white
  };

  void updateButtonColor(String title) {
    setState(() {
      buttonColors.forEach((key, value) {
        if (key == title) {
          buttonColors[key] = Colors.brown;
        } else {
          buttonColors[key] = Colors.white;
        }
      });
    });

    // Save the selected button text to Firebase Firestore
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        children: buttonTitles.map((title) {
          return Container(
            decoration: BoxDecoration(
                color: buttonColors[title],
                border: Border.all(color: Colors.grey)),
            child: ElevatedButton(
              onPressed: () => updateButtonColor(title),
              child: Text(
                title,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
