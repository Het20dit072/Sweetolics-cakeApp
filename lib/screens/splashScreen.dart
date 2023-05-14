import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/HomeScreen.dart';
import 'package:sweetolics_cakeapp/screens/initial_page.dart';
import 'package:sweetolics_cakeapp/screens/login_page_admin.dart';
import 'package:lottie/lottie.dart';

import 'login_page_user.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => InitialPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFECE3),
      body: Center(
        child: SvgPicture.asset(
          'assets/images/LOTUS.svg',
        ),
      ),
    );
  }
}
