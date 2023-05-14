import 'package:flutter/material.dart';
import 'package:sweetolics_cakeapp/screens/admin/add_image.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/HomeScreen.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/customizeCake.dart';
import 'package:sweetolics_cakeapp/screens/initial_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sweetolics_cakeapp/screens/login_page_user.dart';
import 'package:sweetolics_cakeapp/screens/splashScreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      home: SplashScreen(),
    );
  }
}
