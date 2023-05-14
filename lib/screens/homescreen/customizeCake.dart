import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/HomeScreen.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/configuration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/customizeCakePage2.dart';
import 'package:sweetolics_cakeapp/screens/widgets/date_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:sweetolics_cakeapp/screens/widgets/uploadPhotoButton.dart';

class CustomCake extends StatefulWidget {
  const CustomCake({Key? key}) : super(key: key);

  @override
  State<CustomCake> createState() => _CustomCakeState();
}

final _firestore = FirebaseFirestore.instance;

bool selected = false;
var firebaseInstance;
FirebaseAuth auth = FirebaseAuth.instance;
User? user = FirebaseAuth.instance.currentUser;
firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;
int selectedIndex = 0;
RangeValues _currentRangeValues = const RangeValues(300, 900);

class _CustomCakeState extends State<CustomCake> {
  int index = 0;
  List<String> _filters = [
    'Birthday',
    'Wedding',
    'Valentines',
    'Baby Shower',
    'Celebrations',
    'Others'
  ];
  TimeOfDay _time = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  String displayDate = '';
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (selectedTime != null) {
      setState(() {
        _time = selectedTime;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    displayDate = DateFormat.yMMMMd().format(selectedDate);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(2030));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        displayDate = DateFormat.yMMMMd().format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd8b4e2),
      appBar: AppBar(
        backgroundColor: Color(0xffd8b4e2),
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
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MyHomePage()));
                },
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
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xffae759f),
                    child: Text(
                      "1",
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
                      "2",
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
                      "4",
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
              height: 175,
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
                        "What Kind of Cake You Want ?",
                        style: TextStyle(
                            color: Colors.brown,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 35,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 10,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: selectedIndex == index
                                  ? Color(0xffae759f)
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  print('Selected: ${_filters[index]}');
                                });
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: selectedIndex == index
                                      ? Color(0xffae759f)
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  _filters[index],
                                  style: TextStyle(
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 175,
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
                        "Price Range",
                        style: TextStyle(
                            color: Colors.brown,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  RangeSlider(
                    values: _currentRangeValues,
                    activeColor: Color(0xffae759f),
                    inactiveColor: Color(0xffFFECE3),
                    min: 100,
                    max: 1600,
                    divisions: 15,
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString(),
                      _currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                      });
                    },
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
                        "When should the cake be ready",
                        style: TextStyle(
                            color: Colors.brown,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 1),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Date :",
                            style: TextStyle(
                                color: Colors.brown,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              height: 30,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Color(0xffFFECE3),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(14),
                                ),
                                border:
                                    Border.all(width: 1, color: Colors.white),
                              ),
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.arrow_drop_down),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xffae759f),
                                  shape: StadiumBorder(),
                                ),
                                onPressed: () => _selectDate(context),
                                label: Text(displayDate),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 1),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Time :",
                            style: TextStyle(
                                color: Colors.brown,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              height: 30,
                              width: 160,
                              decoration: BoxDecoration(
                                color: Color(0xffFFECE3),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(14),
                                ),
                                border:
                                    Border.all(width: 1, color: Colors.white),
                              ),
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.arrow_drop_down),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xffae759f),
                                  shape: StadiumBorder(),
                                ),
                                onPressed: () => _selectTime(context),
                                label: Text(_time.format(context)),
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 30, 18, 0),
              child: Container(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          primary: Color(0xff55286f)),
                      onPressed: () async {
                        User? user = FirebaseAuth.instance.currentUser;
                        FirebaseFirestore.instance
                            .collection('cakes')
                            .doc(user?.uid)
                            .collection('orders')
                            .doc(user?.uid)
                            .set({
                          'budget': _currentRangeValues.end.round().toString(),
                          'Cake Occasion': _filters[index],
                          'time': _time.format(context),
                        }).then((value) {
                          print("success");
                        });

                        Future.delayed(Duration(seconds: 2));

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomCake2()));
                      },
                      child: Text("Next Page"))),
            )
          ], //column
        ),
      ),
    );
  }
}

// for secondpage
class CustomCake2 extends StatefulWidget {
  const CustomCake2({Key? key}) : super(key: key);

  @override
  State<CustomCake2> createState() => _CustomCake2State();
}

class _CustomCake2State extends State<CustomCake2> {
  int index = 0;
  List<String> _cakeTypelist = [
    'Backed',
    'Raw',
  ];
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

  var dropdownvalueCaketype;
  var dropdownvalueprefference;
  String _SelectedCakeType = "Baked";
  List _CakeType = ['Baked', 'Raw'];
  String _SelectedPrefferenceType = "With Egg";
  List _prefference = [
    ' With Egg',
    'Eggless',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd8b4e2),
      appBar: AppBar(
        backgroundColor: Color(0xffd8b4e2),
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
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
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
                      "4",
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
              height: 150,
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
                        "Cake Type ",
                        style: TextStyle(
                            color: Colors.brown,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 35,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _cakeTypelist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 10,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: selectedIndex == index
                                  ? Color(0xffae759f)
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  print('Selected: ${_cakeTypelist[index]}');
                                });
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: selectedIndex == index
                                      ? Color(0xffae759f)
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  _cakeTypelist[index],
                                  style: TextStyle(
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
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
                                        left: 0, right: 10),
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: ListTile(
                      title: Text(
                        'Special Prefferences :',
                        style: TextStyle(
                            color: Colors.brown,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 05, top: 10),
                        child: Text(
                          '(Allergies, food restrictions,etc..)',
                          style: TextStyle(
                              color: Colors.brown,
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(color: Colors.white),
                    child: DropdownButtonFormField(
                      iconEnabledColor: Colors.brown,
                      value: dropdownvalueprefference,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        enabled: false,
                        filled: true,
                        fillColor: Color(0xffae759f),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown)),
                        labelText: 'Eggs',
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          _SelectedPrefferenceType = "$newValue";
                        });
                      },
                      items: _prefference.map((Category2) {
                        return DropdownMenuItem(
                          child: new Text(Category2),
                          value: Category2,
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
                      onPressed: () async {
                        User? user = await FirebaseAuth.instance.currentUser;
                        DocumentReference mainDocRef = FirebaseFirestore
                            .instance
                            .collection('cakes')
                            .doc(user?.uid);

// Create or update the subcollection document
                        DocumentReference subDocRef =
                            mainDocRef.collection('orders').doc(user?.uid);
                        subDocRef.update({
                          'cake Type': _SelectedCakeType,
                          'Servings (100g per person)': _count1,
                          'Special Preffrences': _SelectedPrefferenceType
                        }).then((value) {
                          print("success");
                        });

                        await Future.delayed(Duration(seconds: 2));

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomCake3()),
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

// for thirdpage
class CustomCake3 extends StatefulWidget {
  const CustomCake3({Key? key}) : super(key: key);

  @override
  State<CustomCake3> createState() => _CustomCake3State();
}

class _CustomCake3State extends State<CustomCake3> {
  late File pickedImage;
  bool image_pick = true;
  File? imageFile;
  File? _photo;
  String? url;
  String? di;

  final ImagePicker _picker = ImagePicker();
  imagePickerOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
              child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: Container(
              color: Colors.white,
              height: 210,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Pic Image From",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          print('yes it runs');
                          final pickedFile = await _picker.pickImage(
                              source: ImageSource.camera);

                          setState(() {
                            if (pickedFile != null) {
                              _photo = File(pickedFile.path);
                              if (_photo == null) return;
                              final fileName = basename(_photo!.path);
                              final destination = 'Add_cake/$fileName';
                              try {
                                final ref = firebase_storage
                                    .FirebaseStorage.instance
                                    .ref(destination)
                                    .child('Add_cake/');

                                ref.putFile(_photo!);
                              } catch (e) {
                                print('error occured');
                              }
                            } else {
                              print('No image selected.');
                            }
                          });
                        },
                        icon: const Icon(Icons.camera),
                        label: const Text("CAMERA"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          print('yes it runs');
                          final pickedFile = await _picker.pickImage(
                              source: ImageSource.gallery);

                          setState(() {
                            if (pickedFile != null) {
                              _photo = File(pickedFile.path);
                              if (_photo == null) return;
                              final fileName = basename(_photo!.path);
                              final destination = 'Add_cake/$fileName';
                              try {
                                final ref = firebase_storage
                                    .FirebaseStorage.instance
                                    .ref(destination)
                                    .child('Add_cake/');

                                ref.putFile(_photo!);
                              } catch (e) {
                                print('error occured');
                              }
                            } else {
                              print('No image selected.');
                            }
                          });
                        },
                        icon: const Icon(Icons.image),
                        label: const Text("GALLERY"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.close),
                        label: const Text("CANCEL"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
        });
  }
// for cake shape avatars

  Color _bgColorAvatar1 = Colors.white;
  Color _bgColorAvatar2 = Colors.white;
  Color _bgColorAvatar3 = Colors.white;

  void _changeColorAvatar1() async {
    setState(() {
      _bgColorAvatar1 = Colors.cyan;
      _bgColorAvatar2 = Colors.white;
      _bgColorAvatar3 = Colors.white;
      print("Round Shape Selected");
    });

    User? user = await FirebaseAuth.instance.currentUser;
    CollectionReference cakesCollection =
        FirebaseFirestore.instance.collection('cakes');
    DocumentReference userDocument = cakesCollection.doc(user?.uid);

    Map<String, dynamic> cakeData = {'Cake Shape': 'Round Cake'};

    CollectionReference subCollection = userDocument.collection('orders');
    DocumentReference subCollectionDocument = subCollection.doc(user?.uid);

    subCollectionDocument.update(cakeData).then((value) {
      print("success");
    });
  }

  void _changeColorAvatar2() async {
    setState(() {
      _bgColorAvatar1 = Colors.white;
      _bgColorAvatar2 = Colors.cyan;
      _bgColorAvatar3 = Colors.white;
      print("Square Shape Selected");
    });
    User? user = await FirebaseAuth.instance.currentUser;
    CollectionReference cakesCollection =
        FirebaseFirestore.instance.collection('cakes');
    DocumentReference userDocument = cakesCollection.doc(user?.uid);

    Map<String, dynamic> cakeData = {'Cake Shape': 'Square Cake'};

    CollectionReference subCollection = userDocument.collection('orders');
    DocumentReference subCollectionDocument = subCollection.doc(user?.uid);

    subCollectionDocument.update(cakeData).then((value) {
      print("success");
    });
  }

  void _changeColorAvatar3() async {
    setState(() {
      _bgColorAvatar1 = Colors.white;
      _bgColorAvatar2 = Colors.white;
      _bgColorAvatar3 = Colors.cyan;
      print("Heart Shape Selected");
    });

    User? user = await FirebaseAuth.instance.currentUser;
    CollectionReference cakesCollection =
        FirebaseFirestore.instance.collection('cakes');
    DocumentReference userDocument = cakesCollection.doc(user?.uid);

    Map<String, dynamic> cakeData = {'Cake Shape': 'Heart Cake'};

    CollectionReference subCollection = userDocument.collection('orders');
    DocumentReference subCollectionDocument = subCollection.doc(user?.uid);

    subCollectionDocument.update(cakeData).then((value) {
      print("success");
    });
  }

  // for Cake Tier

  Color _bgColorTierAvatar1 = Colors.white;
  Color _bgColorTierAvatar2 = Colors.white;
  Color _bgColorTierAvatar3 = Colors.white;
  Color _bgColorTierAvatar4 = Colors.white;

  void _changeColorTierAvatar1() async {
    setState(() {
      _bgColorTierAvatar1 = Colors.cyan;
      _bgColorTierAvatar2 = Colors.white;
      _bgColorTierAvatar3 = Colors.white;
      _bgColorTierAvatar4 = Colors.white;

      print("One Tier Selected");
    });
    User? user = await FirebaseAuth.instance.currentUser;
    CollectionReference cakesCollection =
        FirebaseFirestore.instance.collection('cakes');
    DocumentReference userDocument = cakesCollection.doc(user?.uid);

    Map<String, dynamic> cakeData = {'Cake Tier': 'One Tier'};

    CollectionReference subCollection = userDocument.collection('orders');
    DocumentReference subCollectionDocument = subCollection.doc(user?.uid);

    subCollectionDocument.update(cakeData).then((value) {
      print("success");
    });
  }

  void _changeColorTierAvatar2() async {
    setState(() {
      _bgColorTierAvatar1 = Colors.white;
      _bgColorTierAvatar2 = Colors.cyan;
      _bgColorTierAvatar3 = Colors.white;
      _bgColorTierAvatar4 = Colors.white;

      print("Two Tier Selected");
    });
    User? user = await FirebaseAuth.instance.currentUser;
    CollectionReference cakesCollection =
        FirebaseFirestore.instance.collection('cakes');
    DocumentReference userDocument = cakesCollection.doc(user?.uid);

    Map<String, dynamic> cakeData = {'Cake Tier': 'Two Tier'};

    CollectionReference subCollection = userDocument.collection('orders');
    DocumentReference subCollectionDocument = subCollection.doc(user?.uid);

    subCollectionDocument.update(cakeData).then((value) {
      print("success");
    });
  }

  void _changeColorTierAvatar3() async {
    setState(() {
      _bgColorTierAvatar1 = Colors.white;
      _bgColorTierAvatar2 = Colors.white;
      _bgColorTierAvatar3 = Colors.cyan;
      _bgColorTierAvatar4 = Colors.white;

      print("Multi tier Selected");
    });
    User? user = await FirebaseAuth.instance.currentUser;
    CollectionReference cakesCollection =
        FirebaseFirestore.instance.collection('cakes');
    DocumentReference userDocument = cakesCollection.doc(user?.uid);

    Map<String, dynamic> cakeData = {'Cake Tier': 'multi Tier'};

    CollectionReference subCollection = userDocument.collection('orders');
    DocumentReference subCollectionDocument = subCollection.doc(user?.uid);

    subCollectionDocument.update(cakeData).then((value) {
      print("success");
    });
  }

  void _changeColorTierAvatar4() async {
    setState(() {
      _bgColorTierAvatar1 = Colors.white;
      _bgColorTierAvatar2 = Colors.white;
      _bgColorTierAvatar3 = Colors.white;
      _bgColorTierAvatar4 = Colors.cyan;

      print("Minicake  Selected");
    });
    User? user = await FirebaseAuth.instance.currentUser;
    CollectionReference cakesCollection =
        FirebaseFirestore.instance.collection('cakes');
    DocumentReference userDocument = cakesCollection.doc(user?.uid);

    Map<String, dynamic> cakeData = {'Cake Tier': 'Mini Cakes'};

    CollectionReference subCollection = userDocument.collection('orders');
    DocumentReference subCollectionDocument = subCollection.doc(user?.uid);

    subCollectionDocument.update(cakeData).then((value) {
      print("success");
    });
  }

  final List<String> _cakeImages = [
    'assets/images/Cake1.jpg',
    'assets/images/Cake2.jpg',
    'assets/images/Cake3.jpg',
    'assets/images/Cake4.jpg',
    'assets/images/Cake5.jpg',
    'assets/images/Cake6.jpg',
    'assets/images/pinata_chocolate.jpg',
    'assets/images/redvelvetcake.jpeg',
    'assets/images/cheesecake.jpg',
  ];

  int index = 0;
  List<String> _filters = [
    'Birthday',
    'Wedding',
    'Valentines',
    'Baby Shower',
    'Celebrations',
    'Others'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd8b4e2),
      appBar: AppBar(
        backgroundColor: Color(0xffd8b4e2),
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
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
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
                    backgroundColor: Colors.white,
                    child: Text(
                      "2",
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
                      "3",
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
                      "4",
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
              height: 330,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 25, bottom: 05),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Cake Aspects",
                        style: TextStyle(
                            color: Colors.brown,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 05),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "You Can show us an example of what you did like or go on and add your preferences ",
                        style: TextStyle(
                            color: Colors.brown,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                      height: 150.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _cakeImages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 120.0,
                            child: Card(
                              child: Image.asset(
                                _cakeImages[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.9,
                      height: 45,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.transparent,
                              offset: Offset(0, 0),
                              blurRadius: 20,
                              spreadRadius: 0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(40),
                          border:
                              Border.all(color: Color(0xff646cd9), width: 2)),
                      child: GestureDetector(
                        onTap: () {
                          imagePickerOptions(context);
                        },
                        child: Center(
                            child: Text(
                          'pick cake image ',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w400),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 25, bottom: 05),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Cake Shape",
                        style: TextStyle(
                            color: Colors.brown,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: _changeColorAvatar1,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.brown,
                                    width: 2.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: _bgColorAvatar1,
                                  radius: 34.0,
                                  child: Image.asset(
                                    "assets/images/RoundCake.png",
                                    height: 50,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Round Cake",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: _changeColorAvatar2,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.brown,
                                    width: 2.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: _bgColorAvatar2,
                                  radius: 34.0,
                                  child: Image.asset(
                                    "assets/images/SquareCake.png",
                                    height: 50,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Square Cake",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: _changeColorAvatar3,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.brown,
                                    width: 2.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: _bgColorAvatar3,
                                  radius: 34.0,
                                  child: Image.asset(
                                    "assets/images/HeartCake.png",
                                    height: 50,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Heart Cake",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 25, bottom: 05),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Cake Tier",
                        style: TextStyle(
                            color: Colors.brown,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: _changeColorTierAvatar1,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.brown,
                                    width: 2.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: _bgColorTierAvatar1,
                                  radius: 34.0,
                                  child: Image.asset(
                                    "assets/images/oneTier.png",
                                    height: 50,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "One Tier Cake",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: _changeColorTierAvatar2,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.brown,
                                    width: 2.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: _bgColorTierAvatar2,
                                  radius: 34.0,
                                  child: Image.asset(
                                    "assets/images/TwoTier.png",
                                    height: 50,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Two Tier Cake",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: _changeColorTierAvatar3,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.brown,
                                    width: 2.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: _bgColorTierAvatar3,
                                  radius: 34.0,
                                  child: Image.asset(
                                    "assets/images/MultiTier.png",
                                    height: 50,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Multi Tier Cake",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: _changeColorTierAvatar4,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.brown,
                                    width: 2.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: _bgColorTierAvatar4,
                                  radius: 34.0,
                                  child: Image.asset(
                                    "assets/images/MiniCakes.png",
                                    height: 50,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Mini Cakes",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Container(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            primary: Color(0xff55286f)),
                        onPressed: () async {
                          if (_photo == null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomCake4()),
                            );
                          } else {
                            User? user =
                                await FirebaseAuth.instance.currentUser;
                            Reference ref = storage
                                .ref()
                                .child("cake_images")
                                .child("image.jpg");

                            UploadTask uploadTask = ref.putFile(_photo!);

                            uploadTask.whenComplete(() async {
                              String downloadUrl = await ref.getDownloadURL();
                              User? user =
                                  await FirebaseAuth.instance.currentUser;

                              // Generate a unique document ID for the new subcollection
                              String newSubcollectionId = FirebaseFirestore
                                  .instance
                                  .collection('cakes')
                                  .doc(user?.uid)
                                  .collection('orders')
                                  .doc(user?.uid)
                                  .id;

                              // Add the new subcollection with the generated ID
                              FirebaseFirestore.instance
                                  .collection('cakes')
                                  .doc(user?.uid)
                                  .collection('orders')
                                  .doc(user?.uid)
                                  .update({'Cake Image': downloadUrl}).then(
                                      (value) {
                                print("success");
                              });
                            });
                            await Future.delayed(Duration(seconds: 2));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomCake4()),
                            );
                          }
                        },
                        child: Text("Next Page"))))
          ], //column
        ),
      ),
    );
  }
}
// for fourthpage

class CustomCake4 extends StatefulWidget {
  const CustomCake4({Key? key}) : super(key: key);

  @override
  State<CustomCake4> createState() => _CustomCake4State();
}

class _CustomCake4State extends State<CustomCake4> {
  String _selectedFlavor = 'Vanilla';

  final List<String> _flavors = [
    'Vanilla',
    'Chocolate',
    'Strawberry',
    'Lemon',
    'Orange',
  ];

  final Map<String, Color> _flavorColors = {
    'Vanilla': Color(0xffF3E5AB),
    'Chocolate': Color(0xff7B3F00),
    'Strawberry': Color(0xffFB2943),
    'Lemon': Color(0xfffafa33),
    'Orange': Color(0xffffa500),
  };
  String _selectedlayerCream1 = 'Chocolate';

  final List<String> _flavors1 = [
    'Vanilla',
    'Chocolate',
    'Strawberry',
    'Lemon',
    'Orange',
  ];

  final Map<String, Color> _flavor1Colors = {
    'Vanilla': Color(0xffF3E5AB),
    'Chocolate': Color(0xff7B3F00),
    'Strawberry': Color(0xffFB2943),
    'Lemon': Color(0xfffafa33),
    'Orange': Color(0xffffa500),
  };
  String _selectedlayerCream2 = 'Vanilla';

  final List<String> _flavors2 = [
    'Vanilla',
    'Chocolate',
    'Strawberry',
    'Lemon',
    'Orange',
  ];

  final Map<String, Color> _flavor2Colors = {
    'Vanilla': Color(0xffF3E5AB),
    'Chocolate': Color(0xff7B3F00),
    'Strawberry': Color(0xffFB2943),
    'Lemon': Color(0xfffafa33),
    'Orange': Color(0xffffa500),
  };
  String _selectedDecoration = 'chocochips';

  final List<String> _decoration = ['chocochips', 'Sprinkles'];

  final Map<String, AssetImage> _decorside = {
    'chocochips': AssetImage("assets/images/chocochips.png"),
    'Sprinkles': AssetImage("assets/images/sprinkle.png")
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd8b4e2),
      appBar: AppBar(
        backgroundColor: Color(0xffd8b4e2),
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
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
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
                    backgroundColor: Colors.white,
                    child: Text(
                      "2",
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
                      "4",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    maxRadius: 23,
                  ),
                ], //row
              ),
            ),
            Container(
                height: 70,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 80, 0),
                      child: Text(
                        'Sponge Type',
                        style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    DropdownButton<String>(
                      elevation: 0,
                      value: _selectedFlavor,
                      onChanged: (value) {
                        setState(() {
                          _selectedFlavor = value!;
                        });
                      },
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      icon: Icon(Icons.arrow_drop_down,
                          color: Colors.transparent),
                      items: _flavors.map((flavor) {
                        return DropdownMenuItem<String>(
                          value: flavor,
                          child: Text(
                            flavor,
                            style: TextStyle(
                                color: _flavorColors[_selectedFlavor],
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        );
                      }).toList(),
                    ),
                    CircleAvatar(
                      backgroundColor: _flavorColors[_selectedFlavor],
                      radius: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )),
            SizedBox(
              height: 15,
            ),
            Container(
                height: 100,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                      child: Text(
                        '1st Layer Cream ',
                        style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(width: 35),
                    DropdownButton<String>(
                      elevation: 0,
                      value: _selectedlayerCream1,
                      onChanged: (value) {
                        setState(() {
                          _selectedlayerCream1 = value!;
                        });
                      },
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      icon: Icon(Icons.arrow_drop_down,
                          color: Colors.transparent),
                      items: _flavors1.map((flavor1) {
                        return DropdownMenuItem<String>(
                          value: flavor1,
                          child: Text(
                            flavor1,
                            style: TextStyle(
                                color: _flavor1Colors[_selectedlayerCream1],
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        );
                      }).toList(),
                    ),
                    CircleAvatar(
                      backgroundColor: _flavor1Colors[_selectedlayerCream1],
                      radius: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )),
            SizedBox(
              height: 15,
            ),
            Container(
                height: 100,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 18, 0),
                      child: Text(
                        '2nd Layer Cream ',
                        style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(width: 35),
                    DropdownButton<String>(
                      elevation: 0,
                      value: _selectedlayerCream2,
                      onChanged: (value) {
                        setState(() {
                          _selectedlayerCream2 = value!;
                        });
                      },
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      icon: Icon(Icons.arrow_drop_down,
                          color: Colors.transparent),
                      items: _flavors1.map((flavor2) {
                        return DropdownMenuItem<String>(
                          value: flavor2,
                          child: Text(
                            flavor2,
                            style: TextStyle(
                                color: _flavor2Colors[_selectedlayerCream2],
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        );
                      }).toList(),
                    ),
                    CircleAvatar(
                      backgroundColor: _flavor2Colors[_selectedlayerCream2],
                      radius: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )),
            SizedBox(
              height: 15,
            ),
            Container(
                height: 100,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 18, 0),
                      child: Text(
                        'Side Decoration ',
                        style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(width: 35),
                    DropdownButton<String>(
                      elevation: 0,
                      value: _selectedDecoration,
                      onChanged: (value) {
                        setState(() {
                          _selectedDecoration = value!;
                        });
                      },
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      icon: Icon(Icons.arrow_drop_down,
                          color: Colors.transparent),
                      items: _decoration.map((flavor2) {
                        return DropdownMenuItem<String>(
                          value: flavor2,
                          child: Text(
                            flavor2,
                            style: TextStyle(
                                color: _flavor2Colors[_selectedDecoration],
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        );
                      }).toList(),
                    ),
                    CircleAvatar(
                      backgroundImage: _decorside[_selectedDecoration],
                      radius: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )),
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
                      onPressed: () async {
                        User? user = await FirebaseAuth.instance.currentUser;
                        DocumentReference<Map<String, dynamic>> userDocRef =
                            FirebaseFirestore.instance
                                .collection('cakes')
                                .doc(user?.uid);
                        Map<String, dynamic> data = {
                          'Sponge Type ': _selectedFlavor,
                          '1st layer cream': _selectedlayerCream1,
                          '2nd layer cream': _selectedlayerCream2,
                          'Sprinkles': _selectedDecoration,
                          'Approved': false,
                        };
                        userDocRef
                            .collection('orders')
                            .doc(user?.uid)
                            .update(data)
                            .then((value) {
                          print("success");
                        });
                        await Future.delayed(Duration(seconds: 2));

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                      },
                      child: Text("Send Request "))),
            )
          ], //column
        ),
      ),
    );
  }
}
// last page