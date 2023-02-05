import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/customizeCake.dart';
import 'package:sweetolics_cakeapp/screens/widgets/Cake_card.dart';
import 'package:sweetolics_cakeapp/screens/widgets/navigation_bar.dart';
import 'package:sweetolics_cakeapp/screens/widgets/slidingpannel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/cakeData.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFECE3),
        title: Text(
          "Welcome to Sweetolics",
          style: TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.heart,
                  color: Colors.brown,
                )),
          ),
        ],
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.brown,
            )),
      ),
      // extendBody for floating bar get better perfomance
      extendBody: true,
      backgroundColor: Color(0xffFFECE3),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: CakeImages.length,
            itemBuilder: (context, index) {
              return Cake_Card(
                  img: CakeImages[index]['img'],
                  title: CakeImages[index]['title'],
                  subtitle: CakeImages[index]['subtitle'],
                  price: CakeImages[index]['price']);
            }),
      ),

      bottomNavigationBar: navigationBar(),
    );
  }
}
