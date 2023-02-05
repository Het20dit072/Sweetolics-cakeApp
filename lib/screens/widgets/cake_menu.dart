import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class menuItemtab_quantity extends StatefulWidget {
  final String CardName;
  menuItemtab_quantity({required this.CardName});
  @override
  State<menuItemtab_quantity> createState() => menuItemtab_quantityState();
}

class menuItemtab_quantityState extends State<menuItemtab_quantity> {
  int _count = 0;
  void increment() {
    setState(() {
      _count = _count + 1;
      print(_count);
    });
  }

  void decrement() {
    setState(() {
      _count = _count - 1;
      print(_count);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: 05.0),
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
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.CardName,
                          style: TextStyle(
                              color: Color(0xffc02444),
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    IconButton(
                        icon: new Icon(
                          CupertinoIcons.minus_circle_fill,
                          color: Color(0xffc02444),
                        ),
                        onPressed: decrement),
                    Text("${_count}"),
                    IconButton(
                        icon: new Icon(
                          CupertinoIcons.add_circled_solid,
                          color: Color(0xffc02444),
                        ),
                        onPressed: increment)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Card1 extends StatefulWidget {
  @override
  State<Card1> createState() => _Card1State();
}

class _Card1State extends State<Card1> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Container(
        height: 100.0,
        width: width - 60.0,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
                height: 100.0,
                width: width - 60.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
