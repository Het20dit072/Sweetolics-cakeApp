import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/HomeScreen.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/configuration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/customizeCakePage2.dart';
import 'package:sweetolics_cakeapp/screens/widgets/date_picker.dart';
import 'package:intl/intl.dart';

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
                    backgroundColor: Colors.cyan,
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
                                  ? Colors.cyan
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
                                      ? Colors.cyan
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
                    activeColor: Colors.cyan,
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
                                  primary: Colors.cyan,
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
                                  primary: Colors.cyan,
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
                          primary: Color(0xff251749)),
                      onPressed: () async {
                        User? user = FirebaseAuth.instance.currentUser;
                        FirebaseFirestore.instance
                            .collection('cakes')
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
                    backgroundColor: Colors.cyan,
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
                                  ? Colors.cyan
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
                                      ? Colors.cyan
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
                            color: Colors.brown, fontWeight: FontWeight.bold),
                        enabled: false,
                        filled: true,
                        fillColor: Color.fromARGB(255, 198, 232, 236),
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
                          primary: Color(0xff251749)),
                      onPressed: () async {
                        User? user = await FirebaseAuth.instance.currentUser;
                        FirebaseFirestore.instance
                            .collection('cakes')
                            .doc(user?.uid)
                            .update({
                          'cake Type': _SelectedCakeType,
                          'Servings 100g/person': _count1,
                          'Special Preffrences': _SelectedPrefferenceType
                        }).then((value) {
                          print("success");
                        });
                        await Future.delayed(Duration(seconds: 2));

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                      },
                      child: Text("Next Page"))),
            )
          ], //column
        ),
      ),
    );
  }
}
