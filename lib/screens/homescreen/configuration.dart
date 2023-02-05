import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Color primaryColor = Color(0xff416d6d);

List<Map> categories = [
  {
    'name': 'Birthday',
  },
  {
    'name': 'Wedding',
  },
  {
    'name': 'Valentines',
  },
];
List<Map> categories2 = [
  {'name': 'Baby Shower'},
  {
    'name': 'Celebration',
  },
  {
    'name': 'Others',
  },
];

List<BoxShadow> listShadow = [
  BoxShadow(
    color: Colors.grey.shade300,
    blurRadius: 30,
    offset: Offset(0, 10),
  ),
];

Widget buildFilter(String name, bool selected) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(14),
      ),
      border: Border.all(
        width: 1,
        color: selected ? Colors.transparent : Colors.grey.shade300,
      ),
      boxShadow: [
        BoxShadow(
          color: selected ? Colors.blue.shade300 : Colors.white,
          spreadRadius: 3,
          blurRadius: 0,
          offset: Offset(0, 0),
        ),
      ],
      color: selected ? Colors.blue[300] : Colors.white,
    ),
    child: Row(
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: selected ? Colors.white : Colors.grey[800],
          ),
        ),
      ],
    ),
  );
}
