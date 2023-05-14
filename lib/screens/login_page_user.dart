import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sweetolics_cakeapp/screens/admin/Post_cake.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/HomeScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final authResult = await _auth.signInWithCredential(credential);
    final user = authResult.user;
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/light-1.png'))),
                        )),
                    Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/light-2.png'))),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Positioned(
                  child: Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                child: Center(
                  child: Text(
                    "login With Google Account",
                    style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: InkWell(
                  onTap: () async {
                    var user = await _signInWithGoogle();
                    print('User ID: ${user!.uid}');
                    Future.delayed(Duration(seconds: 2));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(143, 148, 251, 1),
                          Color.fromRGBO(143, 148, 251, .6),
                        ])),
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Image.asset(
                            "assets/images/google.png",
                            height: 30,
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Login With Google",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
