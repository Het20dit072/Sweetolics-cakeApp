import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sweetolics_cakeapp/screens/MyOrder_page.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/OfferPAGE.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/customizeCake.dart';

class navigationBar extends StatefulWidget {
  @override
  State<navigationBar> createState() => _navigationBarState();
}

class _navigationBarState extends State<navigationBar> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    return CustomNavigationBar(
      iconSize: 30.0,
      elevation: 10,
      selectedColor: Color.fromARGB(255, 4, 201, 255),
      strokeColor: Color.fromARGB(255, 4, 201, 255),
      unSelectedColor: Color.fromARGB(123, 0, 0, 0),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      items: [
        CustomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          title: Text("Explore"),
        ),
        CustomNavigationBarItem(
          icon: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => OfferPage()));
              },
              child: Icon(Icons.explore)),
          title: Text("Offers"),
        ),
        CustomNavigationBarItem(
          icon: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CustomCake()));
            },
            child: Icon(
              CupertinoIcons.add_circled_solid,
              color: Color(0xffc02444),
              size: 30,
            ),
          ),
          title: Text("Add"),
        ),
        CustomNavigationBarItem(
          icon: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyOrderPage()));
              },
              child: Icon(Icons.request_quote_sharp)),
          title: Text("Orders"),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
