import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/configuration.dart';
import 'package:sweetolics_cakeapp/screens/widgets/cake_menu.dart';

class CustomCake2 extends StatefulWidget {
  const CustomCake2({Key? key}) : super(key: key);

  @override
  State<CustomCake2> createState() => _CustomCake2State();
}

final FirebaseFirestore firestore = FirebaseFirestore.instance;
bool selected = false;
RangeValues _currentRangeValues = const RangeValues(300, 900);

class _CustomCake2State extends State<CustomCake2> {
  void storeData(selected, date) async {
    CollectionReference collectionReference = firestore.collection("cakes");
    await collectionReference.doc().update({
      'budget': _currentRangeValues.end.round().toString(),
    });
  }

  int _count1 = 0;
  void increment() {
    setState(() {
      _count1 = _count1 + 1;
      print(_count1);
    });
  }

  void decrement() {
    setState(() {
      _count1 = _count1 - 1;
      print(_count1);
    });
  }

  final TextEditingController _PetBreedController = TextEditingController();
  var dropdownvalue;
  String _SelectedCakeType = "Baked";
  List _CakeType = ['Baked', 'Raw'];
  String _SelectedPrefferenceType = "Eggs";
  List _prefference = [
    'Eggs',
    'Eggless',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFECE3),
      appBar: AppBar(
        backgroundColor: Color(0xffFFECE3),
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Custom Cake Request",
          style: TextStyle(color: Colors.brown, fontSize: 22, wordSpacing: 3),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextButton(
                onPressed: () {},
                child: Text(
                  "Cancle",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(173, 121, 85, 71)),
                )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      "1",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    maxRadius: 23,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "...",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Color(0xffae759f),
                    child: Text(
                      "2",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    maxRadius: 23,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "...",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      "3",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    maxRadius: 23,
                  ),
                ], //row
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Cake Type",
                        style: TextStyle(
                            color: Colors.brown,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(color: Colors.white),
                    child: DropdownButtonFormField(
                      iconEnabledColor: Colors.brown,
                      value: dropdownvalue,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: Colors.brown, fontWeight: FontWeight.bold),
                        enabled: false,
                        filled: true,
                        fillColor: Color(0xffFFECE3),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown)),
                        labelText: 'Cake Type',
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          _SelectedCakeType = "$newValue";
                        });
                      },
                      items: _CakeType.map((Category1) {
                        return DropdownMenuItem(
                          child: new Text(Category1),
                          value: Category1,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 50.0,
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Container(
                              padding: EdgeInsets.only(left: 10.0, right: 15.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.white),
                              height: 50.0,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 10),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Servings(100 g / Person)",
                                        style: TextStyle(
                                            color: Colors.brown,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      icon: new Icon(
                                        CupertinoIcons.minus_circle_fill,
                                        color: Colors.brown,
                                      ),
                                      onPressed: decrement),
                                  Text("${_count1}"),
                                  IconButton(
                                      icon: new Icon(
                                        CupertinoIcons.add_circled_solid,
                                        color: Colors.brown,
                                      ),
                                      onPressed: increment)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Special Preffrences",
                        style: TextStyle(
                            color: Colors.brown,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(color: Colors.white),
                    child: DropdownButtonFormField(
                      iconEnabledColor: Colors.brown,
                      value: dropdownvalue,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: Colors.brown, fontWeight: FontWeight.bold),
                        enabled: false,
                        filled: true,
                        fillColor: Color(0xffFFECE3),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown)),
                        labelText: 'Eggs',
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          _SelectedPrefferenceType = "$newValue";
                        });
                      },
                      items: _CakeType.map((Category1) {
                        return DropdownMenuItem(
                          child: new Text(Category1),
                          value: Category1,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Container(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          primary: Color(0xff55286f)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomCake2(),
                          ),
                        );
                      },
                      child: Text("Next Page"))),
            )
          ], //column
        ),
      ),
    );
  }
}
