import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 100, 10, 00),
                child: Container(
                  child: SvgPicture.asset(
                    "assets/images/logo.svg",
                    height: 200,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 00, 10, 0),
                child: Container(
                  child: SvgPicture.asset(
                    "assets/images/logo_name.svg",
                    height: 70,
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // <-- Radius
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Login For Students",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // <-- Radius
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Login For Admin",
                          style: TextStyle(fontSize: 20),
                        ))),
              ),
            ])));
  }
}
